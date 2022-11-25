//
//  ViewController.swift
//  lottieTest
//
//  Created by JinSeok Yang on 2022/10/14.
//

import UIKit
import Lottie


class ViewController: UIViewController {
    
    var mainText: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.font = .systemFont(ofSize: 60, weight: .bold)
        label.textAlignment = .center
        label.text = "Hello"
        return label
    }()
    
    var animationView: LottieAnimationView = {
        let aniView = LottieAnimationView(name: "119717-crazy-hipster")
        aniView.frame = CGRect(x: 0, y: 0, width: 400, height: 400)
        
        aniView.contentMode = .scaleAspectFill
        
        return aniView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addAnimation()
        view.backgroundColor = .white

    }
    
    func addAnimation() {
        view.addSubview(animationView)
        animationView.center = view.center
        animationView.play { finish in
            print("애니 끝")
            self.layoutLabel()
            self.animationView.removeFromSuperview()
        }
    }
    
    
    
    func layoutLabel() {
        view.addSubview(mainText)
        NSLayoutConstraint.activate([
            mainText.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            mainText.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    
}

