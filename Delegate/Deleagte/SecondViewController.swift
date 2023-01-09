//
//  SecondViewController.swift
//  Deleagte
//
//  Created by JINSEOK on 2022/12/23.
//

import UIKit

// AnyObject 오직 클래스타입 인스턴스를 나타낸다.
protocol CustomDelegate: AnyObject {
    // ⭐️델리게이트 만들 때 규칙⭐️
    // 이와같이 파라미터의 첫번째 항목은 이 대리자(delegate)를 발생시킨 개체, 여기선(SecondViewController)를 채택
    func updateNumber(_ viewController: SecondViewController, num: Int)
}

class SecondViewController: UIViewController {
    weak var delegate: CustomDelegate?
    
    let numberLabel = UILabel()
    //  전달받을 숫자 정의
    var getNumber = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .gray
        configureUI()
        configureDelegate()
    }
    
    func configureUI() {
        self.view.addSubview(numberLabel)
        numberLabel.font = .systemFont(ofSize: 30, weight: .bold)
        numberLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }
    
    //  일을 받아서 업데이트
    func configureDelegate() {
        
        self.delegate?.updateNumber(self, num: getNumber)
        
        numberLabel.text = String(getNumber)
    }
}

