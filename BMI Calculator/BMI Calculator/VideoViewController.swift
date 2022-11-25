//
//  VideoViewController.swift
//  BMI Calculator
//
//  Created by JinSeok Yang on 2022/08/23.
//

import UIKit
import AVKit  //동영상 관련 툴킷

class VideoViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    @IBAction func playVideo(_ sender: UIButton) {
        let file: String? = Bundle.main.path(forResource: "11", ofType: "mp4")
        //현재 내부의 앱에서 파일 검색, 파일이 없을수도  있으니 자료형에 옵셔널 넣어둠
        let url = NSURL(fileURLWithPath: file!)
        //위의 파일을 NSURL의 인자에다가 넣어준다.
        let playerController = AVPlayerViewController()
        //AVPlayerViewController로 객체(playerController)를 만든다
        let player = AVPlayer(url: url as URL)
        //자동으로 고쳐주긴 한다.
        playerController.player = player
        //playerController에다가 AVPlayer(url: url as URL) 값을 넣어준 것이 player
        self.present(playerController, animated: true)
        //present는 동영상 재생(인스턴스 메소드),부모쪽의 함수다
        player.play()
    }
}
