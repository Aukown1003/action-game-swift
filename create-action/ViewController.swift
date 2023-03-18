//
//  ViewController.swift
//  create-action
//
//  Created by 桑野友輔 on 2023/03/12.
//

import UIKit
import SwiftyGif

let soundPlayer = SoundPlayer()

class ViewController: UIViewController {
    // 画面の回転を許可するかどうか
    override var shouldAutorotate: Bool {
        // 回転を許可しない
        return false
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        // 横（左）表示
        return .landscapeLeft
    }
    
    @IBOutlet weak var character: UIImageView!
    @IBOutlet weak var enemy: UIImageView!
    var idleImage: UIImage!
    var attackImage: UIImage!
    var enemyImage: UIImage!

    override func viewDidLoad() {
        super.viewDidLoad()
        let gif1Image = try! UIImage(gifName: "idle_animation.gif")
        idleImage = gif1Image
        character.setGifImage(idleImage)
        let gif2Image = try! UIImage(gifName: "attack_animation.gif")
        attackImage = gif2Image
        let gif3Image = try! UIImage(gifName: "enemy-1.gif")
        enemyImage = gif3Image
        enemy.setGifImage(enemyImage)
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
        //音楽の再生
        soundPlayer.attackPlay()
    }


}

