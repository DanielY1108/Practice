//
//  ViewController.swift
//  Deleagte
//
//  Created by JINSEOK on 2022/12/23.
//

import UIKit
import SnapKit

class FirstViewController: UIViewController {
    
    let addButton = UIButton()
    let pesentButton = UIButton()
    var setNumber = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    func configureUI() {
        self.view.addSubview(addButton)
        addButton.backgroundColor = .systemBlue
        addButton.setTitle("Add & Present", for: .normal)
        addButton.addTarget(self, action: #selector(addButtonPressed), for: .touchUpInside)
        addButton.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview().offset(30)
            $0.width.equalTo(200)
            $0.height.equalTo(50)
        }
    }
    
    @objc func addButtonPressed(_ sender: UIButton) {
        let secondVC = SecondViewController()
        secondVC.delegate = self
        self.present(secondVC, animated: true)
        
        sender.blink()
    }
}

extension FirstViewController: CustomDelegate {
    func updateNumber(_ viewController: SecondViewController, num: Int) {
        setNumber += 1
        viewController.getNumber = setNumber
    }
}




extension UIView {
    func blink(duration: TimeInterval = 0.2, delay: TimeInterval = 0.0, alpha: CGFloat = 0.5) {
        UIView.animate(withDuration: duration, delay: delay, options: .curveEaseOut) {
            self.alpha = alpha
        } completion: { _ in
            self.alpha = 1
        }
        
    }
}
