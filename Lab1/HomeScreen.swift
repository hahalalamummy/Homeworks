//
//  HomeScreen.swift
//  Lab1
//
//  Created by Admin on 11/18/16.
//  Copyright © 2016 Admin. All rights reserved.
//

import UIKit

class HomeScreen: UIViewController {
    @IBOutlet weak var highScoreLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func playButton(_ sender: AnyObject) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "GameScreen") as! GameScreen
        navigationController?.pushViewController(vc, animated: true)
        //self.present(vc, animated: true)
    }
    
    @IBAction func settingButton(_ sender: AnyObject) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "SettingScreen") as! SettingScreen
        navigationController?.pushViewController(vc, animated: true)
    }
    override func viewWillAppear(_ animated: Bool) {
        // Hide the navigation bar on the this view controller
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        if scoreValue > highScore {
            highScore = scoreValue
            highScoreLabel.text = "NEW HIGHSCORE"
            scoreLabel.text = String(highScore)
        } else {
            highScoreLabel.text = "HIGHSCORE: "+String(highScore)
            scoreLabel.text = String(scoreValue)
        }
    }
}
