//
//  ViewController.swift
//  MusicPlayer
//
//  Created by JinSeok Yang on 2022/08/26.
//

import UIKit
import AVFoundation

class ViewController: UIViewController, AVAudioPlayerDelegate {
    
    //MARK: Properties
    var player: AVAudioPlayer!
    var timer: Timer!
    
    //MARK: IBOutlets
    @IBOutlet var playPauseBtn: UIButton!
    @IBOutlet var timeLbl: UILabel!
    @IBOutlet var progressSli: UISlider!
    
    // Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.initializePlayer()
        
    }
    // Custom Method
    // player를 초기화 하는 메서드
    func initializePlayer() {
        
        guard let soundAsset: NSDataAsset = NSDataAsset(name: "sound") else {
            print("음원 파일 에셋을 가져올 수 없습니다.")
            return
        }
        
        do {
            try self.player = AVAudioPlayer(data: soundAsset.data)
            self.player.delegate = self
        } catch let error as NSError {
            print("플레이어 초기화 실패")
            print("코드 : \(error.code), 메세지 : \(error.localizedDescription)")
        }
        
        self.progressSli.maximumValue = Float(self.player.duration)
        self.progressSli.minimumValue = 0
        self.progressSli.value = Float(self.player.currentTime)
    }
    
    // Label을 매 초마다 업데이트 해주는 메서드
    func updateTimeLblTxt(time: TimeInterval) {
        let minute: Int = Int(time / 60)
        let second: Int = Int(time.truncatingRemainder(dividingBy: 60))
        let milisecond: Int = Int(time.truncatingRemainder(dividingBy: 1) * 100)
        
        let timeTxt: String = String(format: "%02ld:%02ld:%02ld", minute, second, milisecond)
        
        self.timeLbl.text = timeTxt
    }
    
    // 타이머를 만들고 수행
    func makeAndFireTimer() {
        self.timer = Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true, block: { [unowned self] (timer: Timer) in
            
            if self.progressSli.isTracking { return }
            
            self.updateTimeLblTxt(time: self.player.currentTime)
            self.progressSli.value = Float(self.player.currentTime)
        })
        self.timer.fire()
    }
    
    // 타이머를 해제
    func invalidateTimer() {
        self.timer.invalidate()
        self.timer = nil
    }

    @IBAction func touchUpPlayPauseBtn(_ sender: UIButton) {
        
        sender.isSelected = !sender.isSelected
        //getter 부분 =  setter 부분
        if sender.isSelected {
            self.player?.play()
        } else {
            self.player?.pause()
        }
        
        if sender.isSelected {
            self.makeAndFireTimer()
        } else {
            self.invalidateTimer()
        }
    }

    @IBAction func sliderValueChanged(_ sender: UISlider) {
        self.updateTimeLblTxt(time: TimeInterval(sender.value))
        if sender.isTracking {return}
        self.player.currentTime = TimeInterval(sender.value)
        
        print("slider value changed")
    }
    
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        self.playPauseBtn.isSelected = false
        self.progressSli.value = 0
        self.updateTimeLblTxt(time: 0)
        self.invalidateTimer()
    }
    
}

