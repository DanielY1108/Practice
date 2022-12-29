import UIKit
import CalcCore


var calc = CalcOperation(baseNumber: 2, operationNodes: [CalcOperationNode(op: .plus, operand: 3),
                                                         CalcOperationNode(op: .multiply, operand: 4),
                                                         CalcOperationNode(op: .plus, operand: 5)])
print(calc.operationString())
calc.mergePriorityNode()
var result = calc.mergeOperationNode()

