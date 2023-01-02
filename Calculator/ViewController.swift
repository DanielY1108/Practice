//
//  ViewController.swift
//  Calculator
//
//  Created by JINSEOK on 2022/12/29.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var displayLabel: UILabel!
    
    private var currentNumber: Double = 0 { didSet { updateUI1() }}
    private var currentOperator: Operator? 
    private var currentOperation = Operation() { didSet { updateUI() }}
    
    func updateUI() {
        displayLabel.text = currentOperation.operationString()
    }
    func updateUI1() {
        displayLabel.text = String(currentNumber)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func numberPadPressed(_ sender: UIButton) {
        guard let numString = sender.currentTitle else { return }
        
        currentNumber = currentNumber * 10 + Double(numString)!
    }
    
    @IBAction func dotButtonPressed(_ sender: UIButton) {
        
    }
    
    @IBAction func operatorButtonPressed(_ sender: UIButton) {
        guard let symbol = sender.currentTitle else { return }
        addOperationNode()
        
        switch symbol {
        case Operator.add.symbol:
            currentOperator = .add
        case Operator.subtract.symbol:
            currentOperator = .subtract
        case Operator.multiply.symbol:
            currentOperator = .multiply
        case Operator.divide.symbol:
            currentOperator = .divide
        default: break
        }
        
    }
    
    func addOperationNode() {
        guard currentNumber != 0 else { return }
        if let op = currentOperator {
            currentOperation.operationNodes.append(OperationNode(op: op, operand: currentNumber))
        } else {
            currentOperation.baseNumber = currentNumber
        }
        currentNumber = 0
    }
    
    
    @IBAction func functionButtonPressed(_ sender: UIButton) {
        let symbol = sender.currentTitle
        switch symbol {
        case "AC":
            displayLabel.text = "0.0"
            currentNumber = 0
            currentOperation = Operation()
        case "+/-":
            guard currentNumber != 0 else { return }
            currentNumber = currentNumber * -1
        case "%":
            currentNumber = currentNumber / 100
        default: break
        }
    }
    
    @IBAction func resultButtonPressed(_ sender: UIButton) {
        addOperationNode()
    }
}
