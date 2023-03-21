//
//  Enemy.swift
//  action-game-swift
//
//  Created by 桑野友輔 on 2023/03/20.
//

import UIKit
import SwiftyGif

class Enemy: UIImageView {
    var bottom: CGFloat = 0 //表示位置の下減
    var hSpeed: CGFloat = 0 // 水平方向の速度
    override func didMoveToSuperview() {
        let enemy = try! UIImage(gifName: "enemy-1.gif")
        hSpeed = 2.0
    }
    
    
    func move(){
        self.center = CGPoint(x: self.center.x - hSpeed, y: self.center.y)
    }
}
