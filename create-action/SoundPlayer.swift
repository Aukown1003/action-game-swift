//
//  SoundPlayer.swift
//  action-game-swift
//
//  Created by 桑野友輔 on 2023/03/15.
//

import UIKit
import AVFoundation

class SoundPlayer: NSObject {
    let attackData = NSDataAsset(name: "attackSound")!.data
    
    var attackPlayer: AVAudioPlayer!
    
    func attackPlay() {
        do {
            attackPlayer = try AVAudioPlayer(data: attackData)
            attackPlayer.play()
        } catch {
            print("攻撃音で、エラーが発生しました！")
        }
    }

}
