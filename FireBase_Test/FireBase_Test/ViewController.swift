//
//  ViewController.swift
//  FireBase test
//
//  Created by JINSEOK on 2022/12/20.
//

import UIKit
import SnapKit
import FirebaseAuth


class ViewController: UIViewController {
    
    let emailTextField = UITextField()
    let passwordTextField = UITextField()
    let registerButton = UIButton()
    
    lazy var stackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [emailTextField, passwordTextField, registerButton])
        stack.axis = .vertical
        stack.spacing = 10
        stack.distribution = .fillEqually
        return stack
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        
    }
    
    func configureUI() {
        registerButton.setTitle("Register", for: .normal)
        view.addSubview(stackView)
        registerButton.addTarget(self, action: #selector(loginPressed), for: .touchUpInside)
        registerButton.backgroundColor = .blue
        emailTextField.backgroundColor = .gray
        passwordTextField.backgroundColor = .gray
        emailTextField.text = "A@B.com"
        passwordTextField.text = "123456"
        stackView.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.width.equalToSuperview().inset(20)
            $0.height.equalTo(150)
        }
    }
    
    @objc func registerPressed(_ sender: UIButton) {
        guard let emailText = emailTextField.text, let passwordText = passwordTextField.text else { return }
        
        Auth.auth().createUser(withEmail: emailText, password: passwordText) { authResult, error in
            guard error == nil else {
                print("Error: \(error!)")
                return
            }
            self.present(ChatViewController(), animated: true)
        }
    }

    @IBAction func loginPressed(_ sender: UIButton) {
        guard let emailText = emailTextField.text, let passwordText = passwordTextField.text else { return }
        
        Auth.auth().signIn(withEmail: emailText, password: passwordText) { [weak self] authResult, error in
            guard let self = self else { return }
            guard error == nil else {
                print("Error: \(error!)")
                return
            }
            self.present(ChatViewController(), animated: true)
        }
    }
}


