//
//  CreateClassViewController.swift
//  quan ly
//
//  Created by Admin on 10/26/16.
//  Copyright © 2016 Admin. All rights reserved.
//

import UIKit

class CreateClassViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var textFieldClassName: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textFieldClassName.delegate = self
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        self.view.addGestureRecognizer(tapGesture)
    }
    func dismissKeyboard() {
        view.endEditing(true)
    }
    
    @IBAction func addNewClassButton(_ sender: AnyObject) {
        if let className = textFieldClassName.text {
            if className != "" {
                ClassDataManager.shared.creatNewClass(name: className)
            }
        }
        
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let viewController = storyBoard.instantiateViewController(withIdentifier: "ViewController") as! ViewController
        self.present(viewController, animated:true, completion:nil)
    }
    
}
