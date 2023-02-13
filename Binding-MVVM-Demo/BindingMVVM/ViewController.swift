//
//  ViewController.swift
//  BindingMVVM
//
//  Created by JINSEOK on 2023/02/13.
//

import UIKit

class ViewController: UIViewController {
    
    private var loginVM = LoginViewModel()
    
    lazy var nameTextfield: UITextField = {
        let nameTextfield = BindingTextfield()
        nameTextfield.placeholder = "이름을 입력하세요"
        nameTextfield.backgroundColor = .lightGray
        nameTextfield.borderStyle = .roundedRect
        // 입력되고 있는 실제 텍스트를 제공시킴
        nameTextfield.bind { [weak self] text in
            self?.loginVM.name.value = text
        }
        return nameTextfield
    }()
    
    lazy var passwordTextfield: UITextField = {
        let passwordTextfield = BindingTextfield()
        passwordTextfield.placeholder = "비밀번호를 입력하세요"
        passwordTextfield.backgroundColor = .lightGray
        passwordTextfield.borderStyle = .roundedRect
        passwordTextfield.bind { [weak self] text in
            self?.loginVM.password.value = text
        }
        return passwordTextfield
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        
        loginVM.name.bind { [weak self] text in
            self?.nameTextfield.text = text
        }
        loginVM.password.bind { [weak self] text in
            self?.passwordTextfield.text = text
        }
    }
    
    @objc func login() {
        print(loginVM.name.value)
        print(loginVM.password.value)
    }
    
    @objc func fetchLoginInfo() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) { [weak self] in
            self?.loginVM.name.value = "Daniel"
            self?.loginVM.password.value = "12345"
        }
    }
    
    private func setupUI() {
        
        
        let loginButton = UIButton()
        loginButton.setTitle("로그인", for: .normal)
        loginButton.backgroundColor = .gray
        loginButton.addTarget(self, action: #selector(login), for: .touchUpInside)
        
        let fetchLoginInfoButton = UIButton()
        fetchLoginInfoButton.setTitle("로그인 정보 입력", for: .normal)
        fetchLoginInfoButton.backgroundColor = .red
        fetchLoginInfoButton.addTarget(self, action: #selector(fetchLoginInfo), for: .touchUpInside)
        
        let stackView = UIStackView(arrangedSubviews: [nameTextfield, passwordTextfield, loginButton, fetchLoginInfoButton])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 20
        
        self.view.addSubview(stackView)
    
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor)
        ])        
    }
    
}

