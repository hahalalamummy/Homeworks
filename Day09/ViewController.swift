//
//  ViewController.swift
//  Day09
//
//  Created by Admin on 11/3/16.
//  Copyright © 2016 Admin. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var text: UILabel!
    @IBOutlet weak var c: UIButton!
    @IBOutlet weak var negative: UIButton!
    @IBOutlet weak var percent: UIButton!
    @IBOutlet weak var div: UIButton!
    @IBOutlet weak var seven: UIButton!
    @IBOutlet weak var eight: UIButton!
    @IBOutlet weak var nine: UIButton!
    @IBOutlet weak var mul: UIButton!
    @IBOutlet weak var four: UIButton!
    @IBOutlet weak var five: UIButton!
    @IBOutlet weak var six: UIButton!
    @IBOutlet weak var sub: UIButton!
    @IBOutlet weak var one: UIButton!
    @IBOutlet weak var two: UIButton!
    @IBOutlet weak var three: UIButton!
    @IBOutlet weak var add: UIButton!
    @IBOutlet weak var zero: UIButton!
    @IBOutlet weak var dock: UIButton!
    @IBOutlet weak var equal: UIButton!
    
    var processing: String = ""
    
    var firstNumber:Double = 0.0
    var secondNumber:Double = 0.0
    
    var calculation:Int = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        for i in 100...118 {
            if let button = self.view.viewWithTag(i) as? UIButton
            {
                //button.backgroundColor = UIColor.clear
                //button.layer.cornerRadius = 5
                button.layer.borderWidth = 0.5
                button.layer.borderColor = UIColor.black.cgColor
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func c(_ sender: AnyObject) {
        text.text = "0"
        processing=""
        firstNumber=0
        secondNumber=0
        calculation=0
    }
    @IBAction func negative(_ sender: AnyObject) {
        if text.text?.characters.first == "-" {
            text.text?.remove(at: (text.text?.startIndex)!)
            processing.remove(at: processing.startIndex)
        } else {
            text.text?.insert("-", at: (text.text?.startIndex)!)
            processing.insert("-", at: processing.startIndex)
        }
    }
    @IBAction func percent(_ sender: AnyObject) {
        if processing == "" {
            if firstNumber != 0 {
                processing=String(firstNumber)
            } else {
                return
            }
        }
        var number:Double = Double(processing)!
        number/=100
        if number.truncatingRemainder(dividingBy: 1) == 0 {
            processing=String(Int(number))
        } else {
            processing=String(number)
        }
        text.text=processing
    }
    
    @IBAction func zero(_ sender: AnyObject) {
        if processing != "0" {
            processing += "0"
        }
        text.text=processing
    }
    @IBAction func one(_ sender: AnyObject) {
        processing += "1"
        text.text=processing
    }
    @IBAction func two(_ sender: AnyObject) {
        processing += "2"
        text.text=processing
    }
    @IBAction func three(_ sender: AnyObject) {
        processing += "3"
        text.text=processing
    }
    @IBAction func four(_ sender: AnyObject) {
        processing += "4"
        text.text=processing
    }
    @IBAction func five(_ sender: AnyObject) {
        processing += "5"
        text.text=processing
    }
    @IBAction func six(_ sender: AnyObject) {
        processing += "6"
        text.text=processing
    }
    @IBAction func seven(_ sender: AnyObject) {
        processing += "7"
        text.text=processing
    }
    @IBAction func eight(_ sender: AnyObject) {
        processing += "8"
        text.text=processing
    }
    @IBAction func nine(_ sender: AnyObject) {
        processing += "9"
        text.text=processing
    }
    
    func handling() {
        if processing != "" {
            secondNumber=firstNumber
            firstNumber=Double(processing)!
            processing=""
        }
        if secondNumber == 0 {
            return
        }
        
        switch calculation {
        case 1:
            firstNumber=secondNumber+firstNumber
        case 2:
            firstNumber=secondNumber-firstNumber
        case 3:
            firstNumber=secondNumber*firstNumber
        case 4:
            firstNumber=secondNumber/firstNumber
        default:
            print(Error.self)
        }
        if firstNumber.truncatingRemainder(dividingBy: 1) == 0 {
            text.text=String(Int(firstNumber))
        } else {
            text.text=String(firstNumber)
        }
    }
    
    @IBAction func add(_ sender: AnyObject) {
        calculation=1
        handling()
    }
    @IBAction func sub(_ sender: AnyObject) {
        calculation=2
        handling()
    }
    @IBAction func mul(_ sender: AnyObject) {
        calculation=3
        handling()
    }
    @IBAction func div(_ sender: AnyObject) {
        calculation=4
        handling()
    }
    
    @IBAction func dock(_ sender: AnyObject) {
        if processing == "" {
            processing = "0."
            text.text=processing
            return
        }
        let number:Double = Double(processing)!
        if number.truncatingRemainder(dividingBy: 1) == 0 {
            //int
            processing += "."
            text.text=processing
        }
    }
    @IBAction func equal(_ sender: AnyObject) {
        handling()
        calculation=0
        secondNumber=0
    }
}

