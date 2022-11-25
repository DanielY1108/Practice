//
//  ViewController.swift
//  SuperView
//
//  Created by JinSeok Yang on 2022/08/27.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //서브뷰 생성
        let frame = CGRect(x: 200 , y: 100, width: 200, height: 200)
        let subView = UIView(frame: frame)
        
        //서브뷰에 색상
        subView.backgroundColor = UIColor.green
        
        //서브뷰 추가하기
        view.addSubview(subView)
        
        //서브뷰 제거하기
        //subView.removeFromSuperview()
        
        
    }


}

