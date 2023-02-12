//
//  SecondViewController.swift
//  Deleagte
//
//  Created by JINSEOK on 2022/12/23.
//

import UIKit

import UIKit

// AnyObject 오직 클래스타입 인스턴스를 나타냅니다.
protocol SecondVCImageDelegate: AnyObject {
    // 델리게이트 만들 때 규칙이 존재한다. (안 써도 무방하지만 애플이 만든 모든 델리게이트에 적용돼 있어요.)
    // 보통 파라미터의 첫번째 항목은 이 대리자(delegate)를 발생시킨 개체를 사용한다.
    // 여기선(SecondViewController)를 채택
    func updateImage(_ viewController: SecondViewController, emotion: String)
}

class SecondViewController: UIViewController {
    
    private let lable: UILabel = {
        let lable = UILabel(frame: CGRect(x: 50, y: 250, width: 300, height: 40))
        lable.font = .systemFont(ofSize: 24, weight: .bold)
        lable.textAlignment = .center
        lable.text = "How are you feeling now?"
        return lable
    }()
    
    private lazy var happyButton: UIButton = {
        let button = UIButton(frame: CGRect(x: 80, y: 350, width: 80, height: 80))
        button.setImage(UIImage(named: "happy"), for: .normal)
        button.addTarget(self, action: #selector(happyButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var sadButton: UIButton = {
        let button = UIButton(frame: CGRect(x: 240, y: 350, width: 80, height: 80))
        button.setImage(UIImage(named: "sad"), for: .normal)
        button.addTarget(self, action: #selector(sadButtonTapped), for: .touchUpInside)
        return button
    }()
    
    // waek키워드는 오직 클래스에서 사용한다. (힙영역 메모리는 클래스의 인스턴스가 생성하기 때문이다)
    weak var delegate: SecondVCImageDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        self.view.addSubview(lable)
        self.view.addSubview(happyButton)
        self.view.addSubview(sadButton)
        self.view.backgroundColor = .systemBlue
        self.title = "SecondVC"
    }
    

    @objc func happyButtonTapped(_ sender: UIButton) {
        // 버튼을 누르면 "데이터 happy를 갖고 updateImage 이미지를 동작해"라고 대리자에게 지시
        self.delegate?.updateImage(self, emotion: "happy")
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func sadButtonTapped(_ sender: UIButton) {
        // 버튼을 누르면 "데이터 sad를 갖고 updateImage 이미지를 동작해"라고 대리자에게 지시
        self.delegate?.updateImage(self, emotion: "sad")
        self.navigationController?.popViewController(animated: true)
    }
}
