//
//  CalcCore.swift
//  Calculator
//
//  Created by JINSEOK on 2022/12/29.
//

import Foundation

public enum Operator {
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
}

public struct OperationNode {
    public var op: Operator
    // operand 나온 값
    public var operand: Double
    
    public init(op: Operator, operand: Double) {
        self.op = op
        self.operand = operand
    }
}

public struct Operation {
    public var baseNumber: Double
    public var operationNodes: [OperationNode]
    
    public init(baseNumber: Double, operationNodes: [OperationNode]) {
        self.baseNumber = baseNumber
        self.operationNodes = operationNodes
    }
    
    public mutating func mergePriorityNode() {
        
        var newNodes = [OperationNode]()
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
                
                newNodes.append(OperationNode(op: latestNode.op, operand: newOperand))
            } else {
                newNodes.append(node)
            }
        }
        
        self.operationNodes = newNodes
    }
    
    public func mergeOperationNode() {
        let value = operationNodes.reduce(baseNumber) { (result: Double, element: OperationNode) in
            element.op.doCalculation(result, element.operand)
        }
        print(value)
    }
    
}
