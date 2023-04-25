//
//  GameScene.swift
//  BloodyPath
//
//  Created by Дмитрий on 25.04.2023.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {

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
    }
}
