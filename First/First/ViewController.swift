//
//  ViewController.swift
//  First
//
//  Created by JinSeok Yang on 2022/08/22.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var lblHello1: UILabel!
    @IBOutlet var txtName: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    @IBAction func btnSend(_ sender: UIButton) {
        lblHello1.text = "Hello," + txtName.text!
    }
}

