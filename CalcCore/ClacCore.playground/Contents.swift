import UIKit
import CalcCore


//var calc = CalcOperation(baseNumber: 2, operationNodes: [CalcOperationNode(op: .plus, operand: 3),
//                                                         CalcOperationNode(op: .multiply, operand: 4),
//                                                         CalcOperationNode(op: .plus, operand: 5)])
//
//calc.mergePriorityNode()
//var result: () = calc.mergeOperationNode()
 
var a = "123"

let b = a.last
let c = a.index(a.endIndex, offsetBy: -2)
let d = String(a[c...])
let e = a.suffix(2)
print(b)
print(c)
print(d)
print(e)
