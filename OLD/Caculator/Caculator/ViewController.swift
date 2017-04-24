//
//  ViewController.swift
//  Caculator
//
//  Created by LangDylan on 18/01/2017.
//  Copyright © 2017 Dylan Lang. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet weak var display: UILabel!
    
    var userIsInTheMiddleOfTypingNumber : Bool=false;
    
    var brain=CalculatorBrain()
    
    
    @IBAction func appendDigit(_ sender: UIButton) {
        let digit=sender.currentTitle!
        //        print("digit=\(digit)")
        
        if userIsInTheMiddleOfTypingNumber {
            display.text=display.text!+digit;
        }else{
            display.text=digit
            userIsInTheMiddleOfTypingNumber=true
        }
    }
    
    @IBAction func operate(_ sender: UIButton) {
        if userIsInTheMiddleOfTypingNumber{
            enter()
        }
        if let operation=sender.currentTitle{
            if let result=brain.performOperation(operation){
                displayValue=result
            }else{
                displayValue=0
            }
            //            switch operation{
            //            case "×":performOperation {$0*$1}
            //            case "÷":performOperation {$1/$0}
            //            case "+":performOperation {$0+$1}
            //            case "−":performOperation {$1-$0}
            //            case "√":performOperation2 {sqrt($0)}
            //            default:break
            //            }
        }
    }
    
    //    func performOperation(operation: (Double,Double)->Double){
    //        if openStack.count>=2{
    //            displayValue=operation(openStack.removeLast(),openStack.removeLast())
    //            enter()
    //        }
    //    }
    //
    //    func performOperation2(operation: (Double)->Double){
    //        if openStack.count>=1{
    //            displayValue=operation(openStack.removeLast())
    //            enter()
    //        }
    //    }
    //
    //    func performOperation(operation: Double -> Double){
    //        if openStack.count>=1{
    //            displayValue=operation(openStack.removeLast())
    //            enter()
    //        }
    //    }
    
    func multiply(op1:Double,op2:Double)->Double{
        return op1*op2
    }
    
    
    //    var openStack=Array<Double>() //var openStack:Array<Double>=Array<Double>()
    
    @IBAction func enter() {
        userIsInTheMiddleOfTypingNumber=false
        //        openStack.append(displayValue)
        //        print("openStack=\(openStack)")
        
        if let result = brain.pushOperand(displayValue){
            displayValue=result
        }else{
            displayValue=0
        }
    }
    
    var displayValue:Double{
        get{
            return NumberFormatter().number(from: display.text!)!.doubleValue
            //                (NumberFormatter().number(from: display.text!)?.doubleValue)! //new
        }
        set{
            display.text="\(newValue)"
//            userIsInTheMiddleOfTypingNumber=false
        }
    }
    
}

