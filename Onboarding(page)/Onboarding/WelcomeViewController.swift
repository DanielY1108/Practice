//
//  WelcomeViewController.swift
//  Onboarding
//
//  Created by JinSeok Yang on 2022/10/14.
//

import UIKit

class WelcomeViewController: UIViewController {
    
    private var holderView = UIView()
    
    let scrollView = UIScrollView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupStyle()
        setupLayout()


    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        configure()

    }

    
}


extension WelcomeViewController {
    
    func configure() {
        
        scrollView.frame = holderView.bounds
        
        holderView.addSubview(scrollView)

        let titles = ["beer", "king", "ness", "pie"]
        for x in 0..<4 {
            let pageView = UIView(frame: CGRect(x: CGFloat(x) * holderView.frame.size.width, y: 0, width: holderView.frame.size.width, height: holderView.frame.size.height))
            scrollView.addSubview(pageView)
            
            // tile, image, button
            let label = UILabel(frame: CGRect(x: 10, y: 10, width: pageView.frame.size.width-20, height: 120))
            let imageView = UIImageView(frame: CGRect(x: 10, y: 10+120+10, width: pageView.frame.size.width-20, height: 120))
            let button = UIButton(frame: CGRect(x: 10, y: pageView.frame.size.height-100, width: pageView.frame.size.width-20, height: 50))

            label.textAlignment = .center
            label.font = .systemFont(ofSize: 32, weight: .bold)
            pageView.addSubview(label)
            label.text = titles[x]
            
            imageView.contentMode = .scaleAspectFit
            imageView.image = UIImage(named: "\(titles[x])")
            pageView.addSubview(imageView)
            
            button.setTitleColor(.white, for: .normal)
            button.backgroundColor = .black
            button.setTitle("Continue", for: .normal)
            if x == 3 {
                button.setTitle("Get Started", for: .normal)
            }
            button.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
            pageView.addSubview(button)
            button.tag = x + 1
        }
        
        scrollView.contentSize = CGSize(width: holderView.frame.size.width*4, height: 0)
        scrollView.isPagingEnabled = true
    }
    
    @objc func didTapButton(_ sender: UIButton) {
        print(sender.tag)

        guard sender.tag < 4 else {
            // dismiss
//            Core.shared.setIsNotNewUser()
//            dismiss(animated: true)
            return
        }
        // scroll connect page
        scrollView.setContentOffset(CGPoint(x: holderView.frame.size.width * CGFloat(sender.tag), y: 0), animated: true)
        
    }
    
    func setupStyle() {
        view.backgroundColor = .white
        
        holderView.translatesAutoresizingMaskIntoConstraints = false
        holderView.backgroundColor = .white
    }
    
    func setupLayout() {
        view.addSubview(holderView)

        NSLayoutConstraint.activate([
            holderView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 0),
            holderView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: 0),
            holderView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 0),
            holderView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: 0),
        ])
    }
}
