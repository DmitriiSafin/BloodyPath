//
//  GameScene.swift
//  BloodyPath
//
//  Created by Дмитрий on 25.04.2023.
//

import SpriteKit
import GameplayKit
import CoreMotion

class GameScene: SKScene {
    
    let motionManager = CMMotionManager()
    var xAcceleration: CGFloat = 0
    var player: SKSpriteNode!
    
    override func didMove(to view: SKView) {
        
        let screenCenterPoint = CGPoint(
            x: self.size.width / 2,
            y: self.size.height / 2)
        let bacground = Background.populateBackground(at: screenCenterPoint)
        bacground.size = self.size
        self.addChild(bacground)
        
        let screen = UIScreen.main.bounds
        for _ in 1...5 {
            let x: CGFloat = CGFloat(GKRandomSource.sharedRandom()
                .nextInt(upperBound: Int(screen.size.width)))
            let y: CGFloat = CGFloat(GKRandomSource.sharedRandom()
                .nextInt(upperBound: Int(screen.size.height)))
            
            let decoration = Decoration.populateDecoration(at: CGPoint(x: x, y: y))
            self.addChild(decoration)
            
            let smoke = Smoke.populateSmoke(at: CGPoint(x: x, y: y))
            self.addChild(smoke)
        }
        
        player = Player.populate(at: CGPoint(
            x: screen.size.width / 2, y: 100)
        )
        self.addChild(player)
        
        motionManager.accelerometerUpdateInterval = 0.2
        motionManager.startAccelerometerUpdates(to: OperationQueue.current!) { data, error in
            if let data = data {
                let acceleration = data.acceleration
                self.xAcceleration = CGFloat(acceleration.x) * 0.7 + self.xAcceleration * 0.3
            }
        }
    }
    
    override func didSimulatePhysics() {
        super.didSimulatePhysics()
        
        player.position.x += xAcceleration * 50
        
        if player.position.x < -70 {
            player.position.x = self.size.width + 70
        } else if player.position.x > self.size.width + 70 {
            player.position.x = -70
        }
    }
}
