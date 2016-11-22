//
//  SettingScreen.swift
//  Lab1
//
//  Created by Admin on 11/20/16.
//  Copyright © 2016 Admin. All rights reserved.
//

import UIKit

class SettingScreen: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func generationButton(_ sender: AnyObject) {
        let button = self.view.viewWithTag(sender.tag) as! UIButton
        
        if generation[sender.tag-99] == true {
            generation[sender.tag-99] = false
            button.alpha = 0.5
        } else {
            generation[sender.tag-99] = true
            button.alpha = 1
        }
    }
    
}
