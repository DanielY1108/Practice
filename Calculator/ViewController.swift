//
//  ViewController.swift
//  Calculator
//
//  Created by JINSEOK on 2022/12/29.
//

import UIKit
import CalcCore

class ViewController: UIViewController {
    
    @IBOutlet weak var calcLabel: UILabel!
    
    private var isFinishNumberTyping: Bool = true
    private var isDotOn: Bool = false
//    private var currentOperation = CalcOperation(baseNumber: 0.0, operationNodes: [CalcOperationNode]())
//    private var currentOperator: CalcOperator?
    
    private var currentNumber: Double {
        get {
            guard let number = Double(calcLabel.text!) else { return 0 }
            return number
        }
        set {
            calcLabel.text = String(Int(newValue))
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func numberPadPressed(_ sender: UIButton) {
        if let numberStr = sender.currentTitle {
            if isFinishNumberTyping && !isDotOn {
                calcLabel.text = numberStr
                isFinishNumberTyping = false
            } else {
                if sender.currentTitle == "." {
                    let isInt = currentNumber == floor(currentNumber)
                    
                    if !isInt || calcLabel.text == "." {
                        return
                    }
                }
                calcLabel.text?.append(numberStr)
            }
        }
    }
    
    @IBAction func dotButtonPressed(_ sender: UIButton) {
        if !isDotOn {
            isDotOn = true
            calcLabel.text?.append(sender.currentTitle!)
        }
    }
    
    
    @IBAction func operatorButtonPressed(_ sender: UIButton) {
    }
    
    func addOperationNode() {
    }
    
    
    
    @IBAction func resultButtonPressed(_ sender: UIButton) {
        
    }
}
