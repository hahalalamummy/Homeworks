//
//  ViewController.swift
//  Homework
//
//  Created by Admin on 11/1/16.
//  Copyright © 2016 Admin. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var searchBar: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func search(_ sender: AnyObject) {
//        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
//        
//        let createClassViewController = storyBoard.instantiateViewController(withIdentifier: "SearchResults") as! SearchResults
//        
//        createClassViewController.searchInformation = searchBar.text!
//        
//        self.present(createClassViewController, animated:true, completion:nil)
    }
    
}

