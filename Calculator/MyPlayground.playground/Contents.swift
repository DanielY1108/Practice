import UIKit
import Foundation

enum Operatior {
    case add
    case subtract
    case multiply
    case divide
    
    var doCalculate: (Double, Double) -> Double {
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
    var op: Operatior
    var operand: Double
}

struct Operation {
    var baseNumber: Double
    var operationNodes: [OperationNode]
    
    func mergeOperationNode() {
        let value = operationNodes.reduce(baseNumber) { result, node in
            node.op.doCalculate(result, node.operand)
        }
        print(value)
    }
}

let operation = Operation(baseNumber: 5, operationNodes: [OperationNode(op: .add, operand: 5),
                                                          OperationNode(op: .multiply, operand: 3)])

operation.mergeOperationNode()
