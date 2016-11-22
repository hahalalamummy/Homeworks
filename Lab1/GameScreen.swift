//
//  GameScreen.swift
//  Lab1
//
//  Created by Admin on 11/18/16.
//  Copyright © 2016 Admin. All rights reserved.
//

import UIKit

class GameScreen: UIViewController {
    
    @IBOutlet weak var circleProgressView: CircleProgressView!
    @IBOutlet weak var pokemonImage: UIImageView!
    @IBOutlet weak var pokemonInformation: UILabel!
    @IBOutlet weak var score: UILabel!
    
    var pokemon: [ModelPokemon] = []
    var selectedPokemon = Array(repeating: true, count: 747)
    
    var pickingPokemon:Int = 0
    var pickingAnswerButton:Int = 0
    
    var timer = Timer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        scoreValue=0
        self.circleProgressView.progress = 0
        self.circleProgressView.trackBackgroundColor = UIColor(white: 1, alpha: 0.5)
        pokemon = DataManager.shared.listAllPokemon()
        self.pokemonImage.layer.cornerRadius = 10
        score.text=String(scoreValue)
        
        pickNew()
        setUp()
    }
    
    func pickNew() {
        pickingPokemon = Int(arc4random_uniform(747))
        while generation[Int(pokemon[pickingPokemon].gen)] == false &&
            selectedPokemon[Int(pokemon[pickingPokemon].id) - 1] == false
        {
            pickingPokemon = Int(arc4random_uniform(747))
        }
        selectedPokemon[Int(pokemon[pickingPokemon].id) - 1] = false
        pickingAnswerButton = Int(arc4random_uniform(4) + 100)
    }
    
    func setUp() {
        
        
        self.pokemonImage.image = UIImage(named: pokemon[pickingPokemon].img)
        self.view.backgroundColor = UIColor().HexToColor(hexString: pokemon[pickingPokemon].color)
        self.pokemonImage.image = self.pokemonImage.image?.withRenderingMode(.alwaysTemplate)
        self.pokemonImage.tintColor = UIColor.black
        
        self.pokemonInformation.alpha = 0
        
        for i in 100...103 {
            let button = self.view.viewWithTag(i) as! UIButton
            button.backgroundColor = UIColor.white
        }
        
        
        var button = self.view.viewWithTag(pickingAnswerButton) as! UIButton
        button.setTitle(pokemon[pickingPokemon].name, for: .normal)
        
        for i in 100...103 {
            button = self.view.viewWithTag(i) as! UIButton
            if i != pickingAnswerButton {
                var pickingWrongAnswer = Int(arc4random_uniform(747))
                while pokemon[pickingWrongAnswer].gen != 1 && pickingWrongAnswer != pickingPokemon {
                    pickingWrongAnswer = Int(arc4random_uniform(747))
                }
                button.setTitle(pokemon[pickingWrongAnswer].name, for: .normal)
            }
        }
    }
    
    @IBAction func pushBackButton(_ sender: AnyObject) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func answerButton(_ sender: AnyObject) {
        pokemonInformation.text = String(pokemon[pickingPokemon].tag + " " + pokemon[pickingPokemon].name)
        
        if sender.tag == pickingAnswerButton {
            let button = self.view.viewWithTag(sender.tag) as! UIButton
            button.backgroundColor = UIColor.green
            scoreValue += 1
            score.text=String(scoreValue)
        }
        else {
            let rightButton = self.view.viewWithTag(pickingAnswerButton) as! UIButton
            let wrongButton = self.view.viewWithTag(sender.tag) as! UIButton
            rightButton.backgroundColor = UIColor.green
            wrongButton.backgroundColor = UIColor.red
        }
        self.pokemonImage.image = self.pokemonImage.image?.withRenderingMode(.alwaysOriginal)
        pokemonInformation.alpha = 1
        
        
        timer.invalidate()
        nextPokemon()
        
    }
    
    func nextPokemon() {
        pickNew()
        self.view.isUserInteractionEnabled = false
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2) {
            self.timer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(self.timerAction), userInfo: nil, repeats: true)
            //self.view.slideInFromLeft()
            self.pokemonImage.slideInFromLeft()
            self.view.isUserInteractionEnabled = true
            self.setUp()
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        circleProgressView.setTrackWidth(width: circleProgressView.frame.size.width/2)
        timer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(timerAction), userInfo: nil, repeats: true)
    }
    func timerAction() {
        self.circleProgressView.progress+=0.001
        if self.circleProgressView.progress >= 0.998 {
            timer.invalidate()
            
            self.navigationController?.popViewController(animated: true)
        }
    }
}


