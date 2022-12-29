//
//  CalcCore.swift
//  Calculator
//
//  Created by JINSEOK on 2022/12/29.
//

import Foundation

public enum CalcOperator {
    case plus
    case minus
    case multiply
    case divide
    
    public var doCalculation: (Double, Double) -> Double {
        switch self {
        case .plus:
            return (+)
        case .minus:
            return (-)
        case .multiply:
            return (*)
        case .divide:
            return (/)
        }
    }
    
    var symbol: String {
        switch self {
        case .plus:
            return "+"
        case .minus:
            return "-"
        case .multiply:
            return "x"
        case .divide:
            return "÷"
        }
    }
}

public struct CalcOperationNode {
    public var op: CalcOperator
    // operand = 나온 값
    public var operand: Double
    
    public init(op: CalcOperator, operand: Double) {
        self.op = op
        self.operand = operand
    }
}

public struct CalcOperation {
    public var baseNumber: Double
    public var operationNodes: [CalcOperationNode]
    
    public init(baseNumber: Double, operationNodes: [CalcOperationNode]) {
        self.baseNumber = baseNumber
        self.operationNodes = operationNodes
    }
    
    public mutating func mergePriorityNode() {
        
        var newNodes = [CalcOperationNode]()
        var base: Double

        for node in self.operationNodes {
            if node.op == .multiply || node.op == .divide {
                guard !newNodes.isEmpty else {
                    base = baseNumber
                    return
                }
                let latestNode = newNodes.removeLast()
                base = latestNode.operand
                let newOperand = node.op.doCalculation(base, node.operand)
                
                newNodes.append(CalcOperationNode(op: latestNode.op, operand: newOperand))
            } else {
                newNodes.append(node)
            }
        }
        
        self.operationNodes = newNodes
    }
    
    public func mergeOperationNode() -> Double {
        let value = operationNodes.reduce(baseNumber) { (result: Double, element: CalcOperationNode) in
            element.op.doCalculation(result, element.operand)
        }
        return value
    }
   
    
}
