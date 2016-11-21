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
    
    var pokemon: [ModelPokemon] = []
    
    var pickingPokemon:Int = 0
    var pickingAnswerButton:Int = 0
    
    var timer = Timer()
    var rightAnswer = 100
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.view.backgroundColor = self.pokemonImage.tintColor
        self.circleProgressView.progress = 0
        self.circleProgressView.trackBackgroundColor = UIColor(white: 1, alpha: 0.5)
        self.pokemonImage.image = self.pokemonImage.image?.withRenderingMode(.alwaysTemplate)
        self.pokemonImage.tintColor = UIColor.black
        self.pokemonImage.layer.cornerRadius = 10
        self.pokemonInformation.alpha = 0
        pokemon = DataManager.shared.listAllPokemon()
        setUp()
    }
    
    func setUp() {
        pickingPokemon = Int(arc4random_uniform(747) + 1)
        while pokemon[pickingPokemon].gen != 1 {
            pickingPokemon = Int(arc4random_uniform(747) + 1)
        }
        
        pickingAnswerButton = Int(arc4random_uniform(4) + 100)
        
        
        
        var button = self.view.viewWithTag(pickingAnswerButton) as! UIButton
        button.setTitle(pokemon[pickingPokemon].name, for: .normal)
        
        for i in 100...103 {
            button = self.view.viewWithTag(i) as! UIButton
            if i != pickingAnswerButton {
                var pickingWrongAnswer = Int(arc4random_uniform(747) + 1)
                while pokemon[pickingWrongAnswer].gen != 1 && pickingWrongAnswer != pickingPokemon {
                    pickingWrongAnswer = Int(arc4random_uniform(747) + 1)
                }
                button.setTitle(pokemon[pickingWrongAnswer].name, for: .normal)
            }
        }
    }
    
    @IBAction func pushBackButton(_ sender: AnyObject) {
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    @IBAction func answerButton(_ sender: AnyObject) {
        if sender.tag == rightAnswer {
            let button = self.view.viewWithTag(sender.tag) as! UIButton
            button.backgroundColor = UIColor.green
        }
        else {
            let rightButton = self.view.viewWithTag(rightAnswer) as! UIButton
            let wrongButton = self.view.viewWithTag(sender.tag) as! UIButton
            rightButton.backgroundColor = UIColor.green
            wrongButton.backgroundColor = UIColor.red
        }
        self.pokemonImage.image = self.pokemonImage.image?.withRenderingMode(.alwaysOriginal)
        timer.invalidate()
        pokemonInformation.alpha = 1
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        
        circleProgressView.setTrackWidth(width: circleProgressView.frame.size.width/2)
        timer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(timerAction), userInfo: nil, repeats: true)
    }
    func timerAction() {
        self.circleProgressView.progress+=0.001
    }
}

extension UIView {
    
    @IBInspectable var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = newValue > 0
        }
    }
    
    @IBInspectable var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }
    
    @IBInspectable var borderColor: UIColor? {
        get {
            return UIColor(cgColor: layer.borderColor!)
        }
        set {
            layer.borderColor = newValue?.cgColor
        }
    }
}

extension UIColor {
    
    var redValue: CGFloat{
        return cgColor.components! [0]
    }
    
    var greenValue: CGFloat{
        return cgColor.components! [1]
    }
    
    var blueValue: CGFloat{
        return cgColor.components! [2]
    }
    
    var alphaValue: CGFloat{
        return cgColor.components! [3]
    }
}
