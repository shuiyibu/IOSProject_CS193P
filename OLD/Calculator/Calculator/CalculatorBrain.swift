//
//  CalculatorBrain.swift
//  Calculator
//
//  Created by LangDylan on 2017/4/24.
//  Copyright © 2017年 Dylan Lang. All rights reserved.
//

import Foundation
class CalculatorBrain
{
    private enum Op: CustomStringConvertible// : Printable
    {
        case Operand(Double)
        case UnaryOperation(String,(Double)->Double)
        case BinaryOperation(String,(Double,Double)->Double)
        
        var description: String{
            get {
                switch self{
                case .Operand(let operand):
                    return "\(operand)"
                case .UnaryOperation(let symbol, _):
                    return symbol
                case .BinaryOperation(let symbol, _):
                    return symbol
                }
            }
        }
    }
    
    private var opStack = [Op]() //1. 保存所有的操作符
    private var knownOps = [String:Op]() //2. 算术运算
    
    init(){
        func learnOp(_ op: Op){
            knownOps[op.description] = op
        }
        
        learnOp(Op.BinaryOperation("×",*))//?
       // knownOps["×"]=Op.BinaryOperation("×",*)
        knownOps["÷"]=Op.BinaryOperation("÷"){$1/$0}
        knownOps["+"]=Op.BinaryOperation("+",+)
        knownOps["−"]=Op.BinaryOperation("−"){$1-$0}
        knownOps["√"]=Op.UnaryOperation("√",sqrt)
        
    }
    
    var program: AnyObject{//guaranteed to be a PropertyList
        get{
//            var returnValue = [String]()
//            for op in opStack{
//                returnValue.append(op.description)
//            }
//            return returnValue
            return opStack.map{$0.description}
        }
        set{
            
        }
    }
    
    private func evaluate(_ ops:[Op]) -> (result:Double?,remainingOps:[Op]) {
        if !ops.isEmpty{
            var remainingOps=ops //just for copy
            let op=remainingOps.removeLast()
            switch op {
            case .Operand(let operand):
                return (operand,remainingOps)
            case .UnaryOperation(_, let operation):
                let operandEvaluation=evaluate(remainingOps)
                if let operand=operandEvaluation.result{
                    return (operation(operand),operandEvaluation.remainingOps)
                }
            case .BinaryOperation(_, let operation):
                let op1Evaluation=evaluate(remainingOps)
                if let operand1=op1Evaluation.result{
                    let op2Evaluation=evaluate(op1Evaluation.remainingOps)
                    if let operand2=op2Evaluation.result{
                        return (operation(operand1,operand2),op2Evaluation.remainingOps)
                    }
                }
            }
        }
        return (nil,ops)
    }
    
    func evaluate()->Double?{
        let (result,_)=evaluate(opStack)
 print("\(opStack)=\(String(describing: result)) with \(remainder) left over")
        return result
    }
    
    func pushOperand(_ operand:Double)->Double? {
        opStack.append(Op.Operand(operand))
        return evaluate()
    }
    
    func  performOperation(_ symbol:String)->Double? {
        if let operation=knownOps[symbol]{
            opStack.append(operation)
        }
        return evaluate()
    }
    
    
}
