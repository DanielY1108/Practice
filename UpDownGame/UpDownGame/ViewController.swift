//
//  ViewController.swift
//  UpDownGame
//
//  Created by JinSeok Yang on 2022/08/25.
//

import UIKit

class ViewController: UIViewController {
    
    var randomNumber = 0
    var tryCount = 0
    var win = 0
    var lose = 0
    @IBOutlet weak var hint: UILabel!
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var tryCountLabel: UILabel!
    @IBOutlet weak var sliderValue: UILabel!
    @IBOutlet weak var minimumValueLabel: UILabel!
    @IBOutlet weak var maximumValueLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        slider.setThumbImage(UIImage(named: "slider_thumb"), for: .normal)
        reset()
    }
    
    func reset() {
        if randomNumber == Int(slider.value) {
            win += 1
            hint.text = "\(win)th Win, \(lose)th Lose"
        } else if tryCount >= 5 {
            lose += 1
            hint.text = "\(win)th Win, \(lose)th Lose"
        } else {
            win = 0
            lose = 0  //초기화하는 다른 방법은 없나?
            hint.text = "\(win)th Win, \(lose)th Lose"
        }
        print("reset")
        randomNumber = Int.random(in: 0...30)
        print(randomNumber)
        tryCount = 0
        tryCountLabel.text = "0 / 5"
        minimumValueLabel.text = "0"
        maximumValueLabel.text = "30"
        sliderValue.text = "15"
        slider.minimumValue = 0
        slider.maximumValue = 30
        slider.value = 15
    }
   
    @IBAction func sliderValueChanged(_ sender: UISlider) {
        let integerValue: Int = Int(sender.value)
        print(integerValue)
        
        sliderValue.text = String(integerValue)
    }
    
    func showAlert(message: String) {
        //메시지 창 컨트롤러 인스턴스 생성
        let alert = UIAlertController(title: nil,
                                      message: message,
                                      preferredStyle: .alert)
        //메시지 창 컨트롤러에 들어갈 버튼 액션 객체 생성
        let againAction = UIAlertAction(title: "Again",
                                     style: .default,
                                     handler: nil)  //handler - 버튼 클릭했을 때 실행될 구문(아무일 없으면 생략 or nil)
        let resetAction = UIAlertAction(title: "Reset",
                                        style: .default) { action in
            self.reset()
        }
        
        //메시지 창 컨트롤러에 버튼 액션을 추가
        alert.addAction(againAction)
        alert.addAction(resetAction)
        //메시지 창 컨트롤러를 표시
        present(alert,
                animated: true,
                completion: nil)
    }  //alert 만들기...이해 불가
    
    @IBAction func touchUpHitButton(_ sender: UIButton) {
        print(slider.value)
        let hitValue: Int = Int(slider.value)
        slider.value = Float(hitValue)
        print(hitValue)
        
        tryCount += 1
        tryCountLabel.text = "\(tryCount) / 5"
        //tryCountLabel.text = String(tryCount) + "/ 5"
        
        if tryCount == 4 {
            hint.text = "Focus. It's your last chance 🧐"
        }
        
        if randomNumber == Int(slider.value) {
            showAlert(message: "You Win! \n Congratulation!")
            reset()
        } else if tryCount >= 5 {
            showAlert(message: "Oops...You Lose \n Try Again")
            reset()
        }else if randomNumber > hitValue {
            minimumValueLabel.text = String(hitValue)
            slider.minimumValue = Float(hitValue)
        } else {
            maximumValueLabel.text = String(hitValue)
            slider.maximumValue = Float(hitValue)
        }
    }
    
    @IBAction func touchUpResetButton(_ sender: UIButton) {
        print("touch up reset button")
        reset()
    }
}
