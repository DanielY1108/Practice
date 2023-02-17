//
//  ViewController.swift
//  MemoryLeaks
//
//  Created by JINSEOK on 2023/02/17.
//

import UIKit

class FisrtVC: UIViewController {
    
    lazy var button: UIButton = {
       let btn = UIButton()
        btn.setTitle("Tap Me", for: .normal)
        btn.frame = CGRect(x: 0, y: 0, width: 200, height: 50)
        btn.center = self.view.center
        btn.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
        return btn
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(button)
    }

    @objc func didTapButton() {
        let secondVC = SecondVC()
        present(secondVC, animated: true)
    }
}


class AClass {
    var aProperty: BClass?
}

class BClass {
    var bProperty: AClass?
}

class SecondVC: UIViewController {
    
    var a = AClass()
    var b = BClass()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .red
    
        a.aProperty = b
        b.bProperty = a
    }
}


