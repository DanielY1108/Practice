//
//  CalculateLogic.swift
//  Calculator
//
//  Created by JINSEOK on 2022/12/30.
//

import Foundation

enum Operator {
    case add
    case subtract
    case multiply
    case divide
   
    
    var doCalculate: (Double, Double) -> Double? {
        switch self {
        case .add:
            return (+)
        case .subtract:
            return (-)
        case .multiply:
            return (*)
        case .divide:
            return (/)
        }
    }
    
    var symbol: String {
        switch self {
        case .add:
            return "+"
        case .subtract:
            return "-"
        case .multiply:
            return "x"
        case .divide:
            return "÷"
        }
    }
}

struct OperationNode {
    var op: Operator
    var operand: Double
}

struct Operation {
    var baseNumber: Double
    var operationNodes: [OperationNode]
    
    init() {
        self.baseNumber = 0
        self.operationNodes = [OperationNode]()
    }
    
    func mergeOperationNode() -> Double {
        let value = operationNodes.reduce(baseNumber) { result, node in
            node.op.doCalculate(result, node.operand) ?? 0
        }
        return value
    }
    
    func operationString() -> String {
        return String(mergeOperationNode())
    }
}
