//
//  SettingScreen.swift
//  Lab1
//
//  Created by Admin on 11/20/16.
//  Copyright © 2016 Admin. All rights reserved.
//

import UIKit

class SettingScreen: UIViewController {
    var generation = Array(repeating: false, count: 6)
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
        if button.alpha == 1 {
            button.alpha = 0.5
        } else {
            button.alpha = 1
        }
        switch sender.tag {
        case 100:
            generation[0]=true
            
        case 101:
            generation[1]=true
            
        case 102:
            generation[2]=true
            
        case 103:
            generation[3]=true
            
        case 104:
            generation[4]=true
            
        case 105:
            generation[5]=true
            
        default:
            print(Error.self)
        }
    }
    
}
