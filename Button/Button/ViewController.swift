//
//  ViewController.swift
//  Button
//
//  Created by JinSeok Yang on 2022/08/22.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var lblText: UILabel!   //암묵적인 언래핑
    var x = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func lblPlus(_ sender: UIButton) {
        x += 1
        lblText.text = String(x)
    }
    @IBAction func lblMinus(_ sender: UIButton) {
        x -= 1
        lblText.text = String(x)
    }
    
}

