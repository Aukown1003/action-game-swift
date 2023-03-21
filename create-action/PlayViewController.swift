//
//  PlayViewController.swift
//  action-game-swift
//
//  Created by 桑野友輔 on 2023/03/21.
//

import UIKit

class PlayViewController: UIViewController {
    var screenWidth: CGFloat!
    var screenHeight: CGFloat!
    
    var frameTimer: Timer!
    
    var score = 0
    var scoreCount = 0
    
    var enemyCount = 0
    let enemyInterval = 60
    var enemyArray = [Enemy]()
    
    @IBOutlet var scoreLabel: UILabel!
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
        
        screenWidth = self.view.frame.size.width
        screenHeight = self.view.frame.size.height
        
        frameTimer = Timer.scheduledTimer(withTimeInterval: 1.0/60, repeats: true, block: {(timer) in
            self.frameAction()
        })
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
    
    func frameAction(){
        for i in (0..<enemyArray.count).reversed(){
            let enemy = enemyArray[i]
            enemy.move()
            // 衝突判定
            if abs(character.center.x - enemy.center.x) < 50 && abs(character.center.y - enemy.center.y) < 50 { // 絶対値で判定
                //finishGame()
                return
            }
        }
        // 敵の発生
        if enemyCount >= enemyInterval {
            let size:CGFloat = 60
            let enemy = Enemy()
            enemy.frame = CGRect(x: 0, y: 0, width: size, height: size)
            let randY = arc4random_uniform(500)
            enemy.center = CGPoint(x: screenWidth + size/2, y: CGFloat(randY))
            enemy.bottom = self.view.frame.size.height - 40
            self.view.addSubview(enemy)
            enemyArray.append(enemy)
            enemyCount = 0
        }else{
            enemyCount += 1
        }
        
    }
}
