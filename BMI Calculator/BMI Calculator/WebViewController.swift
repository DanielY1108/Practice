//
//  WebViewController.swift
//  BMI Calculator
//
//  Created by JinSeok Yang on 2022/08/23.
//

import UIKit
import WebKit

class WebViewController: UIViewController {

    @IBOutlet var webView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func goNaver(_ sender: UIButton) {
        if let url = URL(string: "https://m.naver.com") {
            let request = URLRequest(url: url)
            webView.load(request)
        }
    }
}
