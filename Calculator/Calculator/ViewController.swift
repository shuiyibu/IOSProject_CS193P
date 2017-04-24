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
    
    @IBAction func appendDigit(_ sender: UIButton){
        let digit = sender.currentTitle!
        if userIsInTheMiddleOfTypingANumber{
            display.text = display.text! + digit
        }else{
            display.text = digit
            userIsInTheMiddleOfTypingANumber = true;
        }
        
        
    }
    
    
    
    
    @IBAction func operate(_ sender: UIButton) {
        let operation=sender.currentTitle!
        if userIsInTheMiddleOfTypingANumber{
            enter()
        }
        
        switch operation {
        case "×": performOperation(operation: multiply)
        default: break
        }
        
    }
    
    func performOperation(operation: (Double,Double)->Double){
        if operandStack.count>=2{
            displayValue=operation(operandStack.removeLast(),operandStack.removeLast())
            enter()
        }
    }
    
    func multiply(op1:Double,op2:Double)->Double{
        return op1*op2
    }
    
    
    
    
    var operandStack = Array<Double>()
    @IBAction func enter() {
        userIsInTheMiddleOfTypingANumber = false
        operandStack.append(displayValue)
        print("OA = \(operandStack)")
    }
    
    var displayValue: Double{
        get{
            return NumberFormatter().number(from: display.text!)!.doubleValue
        }
        
        set{
            display.text = "\(newValue)"
            userIsInTheMiddleOfTypingANumber = false
        }
        
    }
    
    
    
    
    
}

