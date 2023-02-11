//
//  SecondViewController.swift
//  Deleagte
//
//  Created by JINSEOK on 2022/12/23.
//

import UIKit

// AnyObject 오직 클래스타입 인스턴스를 나타낸다.
protocol SecondVCLabelDelegate: AnyObject {
    // ⭐️ 델리게이트 만들 때 규칙 ⭐️
    // 보통 파라미터의 첫번째 항목은 이 대리자(delegate)를 발생시킨 개체를 사용한다.
    // 여기선(SecondViewController)를 채택
    func addString(_ viewController: SecondViewController, strData: String)
}

class SecondViewController: UIViewController {
    
    let lable: UILabel = {
        let lable = UILabel(frame: CGRect(x: 50, y: 350, width: 300, height: 40))
        lable.font = .systemFont(ofSize: 24, weight: .bold)
        lable.textAlignment = .center
        return lable
    }()

    let defaultStr = ""
    
    weak var delegate: SecondVCLabelDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        
        // 적용하고자하는 위치에서 사용!
        self.delegate?.addString(self, strData: defaultStr)
    }
    
    func setupUI() {
        self.view.addSubview(lable)
        self.view.backgroundColor = .gray
        self.title = "SecondVC"
    }
}
