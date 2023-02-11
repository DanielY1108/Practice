//
//  ViewController.swift
//  Deleagte
//
//  Created by JINSEOK on 2022/12/23.
//

import UIKit
import SnapKit

class FirstViewController: UIViewController {
    
    var textFiled: UITextField = {
        let tf = UITextField(frame: CGRect(x: 50, y: 350, width: 300, height: 40))
        tf.placeholder = "글씨를 입력하세요."
        tf.backgroundColor = .white
        tf.font = .systemFont(ofSize: 24, weight: .bold)
        return tf
    }()
    
    lazy var button: UIButton = {
        let button = UIButton(frame: CGRect(x: 125, y: 420, width: 150, height: 50))
        button.backgroundColor = .systemBlue
        button.setTitle("NextVC", for: .normal)
        button.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    func setupUI() {
        self.view.addSubview(textFiled)
        self.view.addSubview(button)
        self.view.backgroundColor = .gray
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.title = "FirstVC"
    }
    
    @objc func buttonPressed(_ sender: UIButton) {
        let secondVC = SecondViewController()
        // 대리자를 FirstViewController로 설정해줌
        secondVC.delegate = self
    
        self.navigationController?.pushViewController(secondVC, animated: true)
    }
}

extension FirstViewController: SecondVCLabelDelegate {
    // 할 일을 처리해준다.
    // 나는야 SecondVC "SecondVC의 레이블을 FirstVC 텍스트필드로 업데이트 시켜 줘" 라고 일을 지시
    func addString(_ viewController: SecondViewController, strData: String) {
        viewController.lable.text = textFiled.text
    }
}
