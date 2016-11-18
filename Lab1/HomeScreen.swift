//
//  HomeScreen.swift
//  Lab1
//
//  Created by Admin on 11/18/16.
//  Copyright © 2016 Admin. All rights reserved.
//

import UIKit

class HomeScreen: UIViewController {
    
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
    override func viewWillAppear(_ animated: Bool) {
        // Hide the navigation bar on the this view controller
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
}
