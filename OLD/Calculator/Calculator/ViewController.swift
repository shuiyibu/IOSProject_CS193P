//
//  ViewController.swift
//  Calculator
//
//  Created by LangDylan on 2017/4/24.
//  Copyright © 2017年 Dylan Lang. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var display: UILabel!
    
    var userIsInTheMiddleOfTypingANumber = false
    
    var brain = CalculatorBrain()
    
    //    1.
    @IBAction func appendDigit(_ sender: UIButton){
        let digit = sender.currentTitle!
        if userIsInTheMiddleOfTypingANumber{
            display.text = display.text! + digit
        }else{
            display.text = digit
            userIsInTheMiddleOfTypingANumber = true;
        }
    }
    
//    3.加减乘除运算
    @IBAction func operate(_ sender: UIButton) {
        if userIsInTheMiddleOfTypingANumber{
            enter()
        }
        if let operation=sender.currentTitle{
            if let result = brain.performOperation(operation){
                displayValue = result
            }else{
                displayValue = 0
            }
        }
    }
    
    //    2.
    @IBAction func enter() {
        userIsInTheMiddleOfTypingANumber = false
        if let result = brain.pushOperand(displayValue){
            displayValue = result
        }else{
            displayValue = 0 //
        }
    }
    
    var displayValue: Double{
        get{
            return NumberFormatter().number(from: display.text!)!.doubleValue
        }
        set{
            display.text = "\(newValue)"
            //userIsInTheMiddleOfTypingANumber = false
        }
    }
    
}

