//
//  ViewController.swift
//  BMI Calculator
//
//  Created by JinSeok Yang on 2022/08/22.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var txtHeight: UITextField!
    @IBOutlet var txtWeight: UITextField!
    @IBOutlet var lblResult: UILabel!
    
    @IBAction func segment(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
        } else {
        }
    }
    
    @IBAction func swichOnOff(_ sender: UISwitch) {
        if sender.isOn {
        } else {
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    @IBAction func button(_ sender: UIButton) {
        if txtHeight.text == "" || txtWeight.text == "" {
            print("input error")
            lblResult.text = "키와 체중을 입력하시오"
        } else {
            let height = Double(txtHeight.text!)!  //text는 옵셔널 String형이다.
            let weight = Double(txtWeight.text!)!  //text field에 값이 없으면 fatal error
            let bmi = weight / (height * height * 0.0001)
            let ShortBmi = String(format: "%.1f", bmi)
            var body = ""
            var color = UIColor.white
         
            if bmi >= 40 {
                body = "초고도비만"
                color = UIColor(displayP3Red: 1, green: 0, blue: 0, alpha: 1)
            } else if bmi < 40 && bmi >= 35 {
                body = "고도비만"
                color = UIColor(displayP3Red: 0.7, green: 0, blue: 0, alpha: 1)
            } else if bmi < 35 && bmi >= 30 {
                body = "비만"
                color = UIColor(displayP3Red: 0.3, green: 0, blue: 0, alpha: 1)
            } else if bmi < 30 && bmi >= 25 {
                body = "과체중"
                color = UIColor(displayP3Red: 0, green: 0.3, blue: 0, alpha: 1)
            } else if bmi < 25 && bmi >= 18.5 {
                body = "정상체중"
                color = UIColor(displayP3Red: 0, green: 1, blue: 0, alpha: 1)
            } else if bmi < 18.5 {
                body = "저체중"
                color = UIColor(displayP3Red: 0, green: 0, blue: 1, alpha: 1)
            }
            print("BMI : \(ShortBmi), 판정 : \(body)")
            lblResult.backgroundColor = color
            lblResult.text = "BMI : \(ShortBmi), 판정 : \(body)"
            lblResult.clipsToBounds = true
            lblResult.layer.cornerRadius = 10
        }
    }
}
