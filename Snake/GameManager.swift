//
//  GameManager.swift
//  Snake
//
//  This game was implements using Gavin Shrader's tutorial on Medium.com/@gavin9
//  Created by Michael Czarnecki on 2/26/19.
//  Copyright © 2019 Michael Czarnecki. All rights reserved.
//

import SpriteKit

class GameManager {     // GameManager class can communicate to the GameScene
    
    weak var scene: GameScene?
    
    var nextTime: Double?
    var timeExtension: Double = 0.15
    
    var playerDirection: Int = 1
    
    init(scene: GameScene) {
        self.scene = scene
    }
    
    func update(time: Double) {
        if nextTime == nil {
            nextTime = time + timeExtension
        } else {
            if time >= nextTime! {
                nextTime = time + timeExtension
                updatePlayerPosition()
            }
        }
    }
    
    func initGame() {
            // Starting Player Position
        scene?.playerPositions.append((10, 10))
        scene?.playerPositions.append((10, 11))
        scene?.playerPositions.append((10, 12))
        renderChange()
    }
    
    func renderChange() {
        for (node, x, y) in scene!.gameArray {
            if contains(a: scene!.playerPositions, v: (x, y)) {
                node.fillColor = SKColor.cyan
            } else {
                node.fillColor = SKColor.clear
            }
        }
    }
    
    func contains(a: [(Int, Int)], v: (Int, Int)) -> Bool {
        let (c1, c2) = v
        for (v1, v2) in a { if v1 == c1 && v2 == c2 { return true }  }
        return false
    }
    
    private func updatePlayerPosition() {
        
        var xChange = 1
        var yChange = 0
        
        switch playerDirection {
        case 1:
            //Left
            xChange = -1
            yChange = 0
            break
        case 2:
            //Up
            xChange = 0
            yChange = -1
            break
        case 3:
            //Right
            xChange = 1
            yChange = 0
            break
        case 4:
            //Down
            xChange = 0
            yChange = 1
            break
        default:
            break
        }
        
        if scene!.playerPositions.count > 0 {
            var start = scene!.playerPositions.count - 1
            while start > 0 {
                scene!.playerPositions[start] = scene!.playerPositions[start - 1]
                start -= 1
            }
            scene!.playerPositions[0] = (scene!.playerPositions[0].0 + yChange, scene!.playerPositions[0].1 + xChange)
        }
        
        if scene!.playerPositions.count > 0 {
            let x = scene!.playerPositions[0].1
            let y = scene!.playerPositions[0].0
            if y > 38 {
                scene!.playerPositions[0].0 = 0
            } else if y < 0 {
                scene!.playerPositions[0].0 = 38
            } else if x > 20 {
                scene!.playerPositions[0].1 = 0
            } else if x < 0 {
                scene!.playerPositions[0].1 = 20
            }
        }
        
        renderChange()
    }
    
    func swipe(ID: Int) {
        if !(ID == 2 && playerDirection == 4) && !(ID == 4 && playerDirection == 2) {
            if !(ID == 1 && playerDirection == 3) && !(ID == 3 && playerDirection == 1) {
                playerDirection = ID
            }
        }
    }
    
}

