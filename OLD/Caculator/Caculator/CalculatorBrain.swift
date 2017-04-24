//
//  CalculatorBrain.swift
//  Caculator
//
//  Created by LangDylan on 22/01/2017.
//  Copyright © 2017 Dylan Lang. All rights reserved.
//

import Foundation

class CalculatorBrain
{
    private enum Op// : Printable
    {
        case Operand(Double)
        case UnaryOperation(String,(Double)->Double)
        case BinaryOperation(String,(Double,Double)->Double)
        
        var description:String{
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
    
    private var opStack = [Op]()
    private var knownOps = [String:Op]()
    
    init(){
        knownOps["×"]=Op.BinaryOperation("×",*)
        knownOps["÷"]=Op.BinaryOperation("÷"){$1/$0}
        knownOps["+"]=Op.BinaryOperation("+",+)
        knownOps["−"]=Op.BinaryOperation("−"){$1-$0}
        knownOps["√"]=Op.UnaryOperation("√",sqrt)
    }
    
    var program:AnyObject{//guaranteed to be a propertylist
        get{
            var opStack.map{$0.description}
        }
        set{
            if let opSymbols=newValue as? Array<String>{
                var newOpStack=[Op]()
                for opSymbol in opSymbols{
                    if let op=knownOps[opSymbol]{
                        newOpStack.append(op)
                    }else if let operand=NumberFormatter().number(from: opSymbol)?.doubleValue{
                        newOpStack.append(.Operand(operand))
                    }
                }
                opStack=newOpStack
            }
        }
    }
    
    private func evaluate(_ ops:[Op]) -> (result:Double?,remainingOps:[Op]) {
        if !ops.isEmpty{
            var remainingOps=ops
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
        print("\(opStack)=\(result) with \(remainder) left over")
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
