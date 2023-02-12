//
//  ViewController.swift
//  Deleagte
//
//  Created by JINSEOK on 2022/12/23.
//

import UIKit
import SnapKit

class FirstViewController: UIViewController {
    
    var emotionImageView: UIImageView = {
        let view = UIImageView(frame: CGRect(x: 50, y: 270, width: 300, height: 300))
        view.contentMode = .scaleAspectFill
        return view
    }()
    
    lazy var startButton: UIButton = {
        let button = UIButton(frame: CGRect(x: 125, y: 400, width: 150, height: 50))
        button.setTitle("Start", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 30)
        button.addTarget(self, action: #selector(startButtonTapped), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        self.view.addSubview(emotionImageView)
        self.view.addSubview(startButton)
        self.view.backgroundColor = .systemGreen
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        self.title = "FisrtVC"
    }

    @objc func startButtonTapped(_ sender: UIButton) {
        let secondVC = SecondViewController()
        // ⭐️ FirstVC를 대리자로 설정(SecondVC대신 일을 할꺼야!)
        secondVC.delegate = self
        self.navigationController?.pushViewController(secondVC, animated: true)
    }
}

// MARK: - 델리게이트 프로토콜 메서드 정의
extension FirstViewController: SecondVCImageDelegate {
    // 데이터를 SecondVC에서 받아와 FirstVC에서 작업
    func updateImage(_ viewController: SecondViewController, emotion: String) {
        startButton.isHidden = true
        emotionImageView.image = UIImage(named: emotion)
    }
}
