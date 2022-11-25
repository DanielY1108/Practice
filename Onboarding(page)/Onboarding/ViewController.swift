//
//  ViewController.swift
//  Onboarding
//
//  Created by JinSeok Yang on 2022/10/14.
//

import UIKit

class ViewController: UIViewController {
    
    private let wecomeVC = WelcomeViewController()

    override func viewDidLoad() {
        super.viewDidLoad()
        
    
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
      
        if Core.shared.isNewUser() {
            // show onboarding
            wecomeVC.modalPresentationStyle = .fullScreen
            DispatchQueue.main.async { [self] in
                present(wecomeVC, animated: false)

            }
        }
    }


}

class Core {
    
    static let shared = Core()
    
    // Welcome화면 처음 사용하는 사용자일 경우
    func isNewUser() -> Bool {
        return !UserDefaults.standard.bool(forKey: "isNewUser")
    }
    
    func setIsNotNewUser() {
        UserDefaults.standard.set(true, forKey: "isNewUser")
    }
}
