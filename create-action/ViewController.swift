//
//  ViewController.swift
//  create-action
//
//  Created by 桑野友輔 on 2023/03/12.
//

import UIKit
import SwiftyGif

class ViewController: UIViewController {
    @IBOutlet weak var character: UIImageView!
    var idleImage: UIImage!
    var attackImage: UIImage!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
//        let gifImage = try! UIImage(gifName: "idle_animation.gif")
//        self.character.setGifImage(gifImage, loopCount: -1)
        let gif1Image = try! UIImage(gifName: "idle_animation.gif")
        idleImage = gif1Image
        character.setGifImage(idleImage)
        let gif2Image = try! UIImage(gifName: "attack_animation.gif")
        attackImage = gif2Image
    }
    
    private func resetGif() {
        character.setGifImage(idleImage)
        
    }
//    DispatchSourceTimerを格納するプロパティtimerを定義。optional型
    private var timer: DispatchSourceTimer?
    
    @IBAction func toggleButtonTapped(_ sender: UIButton) {
        character.setGifImage(attackImage)
//      timerがnilでなければ、キャンセル
        timer?.cancel()
//      タイマーを生成。メインスレッドで動作するようにメインキューを指定
        timer = DispatchSource.makeTimerSource(queue: DispatchQueue.main)
//      タイマーの時間を1秒後に設定
        timer?.schedule(deadline: .now() + 1 )
//      時間切れになった際に実行する処理をクロージャーで設定。
//      キャラクターに通常時のGIF画像をセットするメソッドを呼び出し
        timer?.setEventHandler { [weak self] in
            self?.resetGif()
            
        }
//      タイマーを開始
        timer?.resume()
    }


}

