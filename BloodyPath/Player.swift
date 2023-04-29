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
        let atlas = Assets.shared.playerAtlas
        let playerTexture = atlas.textureNamed("character")
        let playerBody = Player(texture: playerTexture)
        playerBody.setScale(0.8)
        playerBody.position = point
        playerBody.zPosition = 5
        
        playerBody.physicsBody = SKPhysicsBody(texture: playerTexture, alphaThreshold: 0.5, size: playerBody.size)
        playerBody.physicsBody?.isDynamic = false
        playerBody.physicsBody?.categoryBitMask = BitMaskCategory.player.rawValue
        playerBody.physicsBody?.collisionBitMask = BitMaskCategory.enemy.rawValue | BitMaskCategory.powerUp.rawValue
        playerBody.physicsBody?.contactTestBitMask = BitMaskCategory.enemy.rawValue | BitMaskCategory.powerUp.rawValue
        
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
        motionManager.startAccelerometerUpdates(to: OperationQueue.current!) {
            [unowned self] data, error in
            if let data = data {
                let acceleration = data.acceleration
                self.xAcceleration = CGFloat(acceleration.x) * 0.7 + self.xAcceleration * 0.3
            }
        }
    }
}
