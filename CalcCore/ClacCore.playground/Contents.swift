import UIKit
import CalcCore


var calc = Operation(baseNumber: 2, operationNodes: [OperationNode(op: .plus, operand: 3),
                                                     OperationNode(op: .multiply, operand: 4),
                                                     OperationNode(op: .plus, operand: 5)])

calc.mergePriorityNode()
var result: () = calc.mergeOperationNode()
 
