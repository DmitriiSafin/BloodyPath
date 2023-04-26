//
//  Player.swift
//  BloodyPath
//
//  Created by Дмитрий on 25.04.2023.
//

import SpriteKit
import CoreMotion

class Player: SKSpriteNode {
    
    let motionManager = CMMotionManager()
    var xAcceleration: CGFloat = 0
    let screenSize = CGSize(width: UIScreen.main.bounds.width,
                            height: UIScreen.main.bounds.height)

    static func populate(at point: CGPoint) -> Player {
        let playerTexture = SKTexture(imageNamed: "character")
        let playerBody = Player(texture: playerTexture)
        playerBody.setScale(0.8)
        playerBody.position = point
        playerBody.zPosition = 5
        return playerBody
    }
    
    func checkPosition() {
        self.position.x += xAcceleration * 50
        
        if self.position.x < -50 {
            self.position.x = screenSize.width + 50
        } else if self.position.x > screenSize.width + 50 {
            self.position.x = -50
        }
    }
    
    func performRun() {
        motionManager.accelerometerUpdateInterval = 0.2
        motionManager.startAccelerometerUpdates(to: OperationQueue.current!) { data, error in
            if let data = data {
                let acceleration = data.acceleration
                self.xAcceleration = CGFloat(acceleration.x) * 0.7 + self.xAcceleration * 0.3
            }
        }
    }
}
