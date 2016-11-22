//
//  SettingScreen.swift
//  Lab1
//
//  Created by Admin on 11/20/16.
//  Copyright © 2016 Admin. All rights reserved.
//

import UIKit

class SettingScreen: UIViewController {
    @IBOutlet weak var soundEffectSwitch: UISwitch!
    @IBOutlet weak var musicSwitch: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        soundEffectSwitch.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
        musicSwitch.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func generationButton(_ sender: AnyObject) {
        var count = 0
        
        for i in generation {
            if i == true {
                count += 1
            }
        }
        
        if count == 2 && generation[sender.tag-99] == true {
            return
        }
        
        let button = self.view.viewWithTag(sender.tag) as! UIButton
        
        if generation[sender.tag-99] == true {
            generation[sender.tag-99] = false
            button.alpha = 0.5
        } else {
            generation[sender.tag-99] = true
            button.alpha = 1
        }
    }
    
    @IBAction func backToHome(_ sender: AnyObject) {
        self.navigationController?.popViewController(animated: true)
    }
}
