//
//  CalculatorBrain.swift
//  Calculator
//
//  Created by LangDylan on 2017/5/4.
//  Copyright © 2017年 Dylan Lang. All rights reserved.
//

import Foundation

struct CalculatorBrain{
    
    
    private var accumulator: Double?
    
    private enum Operation{
        case constant(Double)
        case unaryOperation((Double) -> Double)
        case binaryOperation((Double,Double) -> Double)
        case equals
    }
    
    private var operations = [
        "π" : Operation.constant(Double.pi),
        "e" : Operation.constant(M_E),
        "√" : Operation.unaryOperation(sqrt),
        "cos" : Operation.unaryOperation(cos),
        "±" : Operation.unaryOperation({-$0}),
        "+" : Operation.binaryOperation(+),
        "−" : Operation.binaryOperation(-),
        "×" : Operation.binaryOperation(*),
        "÷" : Operation.binaryOperation(/),
        "=" : Operation.equals
    ]
    
    mutating func performOperation(_ symbol: String)
    {
        if let operation = operations[symbol]{
            switch operation {
            case .constant(let value):
                accumulator = value
            case .unaryOperation(let function):
                if accumulator != nil{
                    accumulator = function(accumulator!)
                }
            case .binaryOperation(let function):
                if accumulator != nil{
                    pendingBinaryOperation = PendingBinaryOperation(function: function, fisrtOperand: accumulator!)
                    accumulator = nil
                }
            case .equals:
                performPendingBinaryOperation()
            }
        }
        
    }
    
    
    private mutating func performPendingBinaryOperation(){
        if pendingBinaryOperation != nil && accumulator != nil{
            accumulator = pendingBinaryOperation!.perform(with: accumulator!)
            pendingBinaryOperation = nil
        }
    }
    
    
    
    private var pendingBinaryOperation: PendingBinaryOperation?
    
    private struct PendingBinaryOperation{
        let function: (Double, Double) -> Double
        let fisrtOperand: Double
        
        func perform(with secondOperand: Double) -> Double {
            return function(fisrtOperand, secondOperand)
        }
    }
    
    
    
    mutating func setOperand(_ operand: Double)
    {
        accumulator = operand
    }
    
    var result: Double?{
        get{
            return accumulator
        }
    }
    
    
}
