//
//  Smoke.swift
//  BloodyPath
//
//  Created by Дмитрий on 25.04.2023.
//

import SpriteKit
import GameplayKit


final class Smoke: SKSpriteNode, GameBackgroundSpriteableProtocol {

    static func populate(at point: CGPoint?) -> Smoke {
        let smokeName = configureSmokeName()
        let smoke = Smoke(imageNamed: smokeName)
        smoke.position = point ?? randomPoint()
        smoke.setScale(0.5)
        smoke.zPosition = 10
        smoke.name = "sprite"
        smoke.anchorPoint = CGPoint(x: 0.5, y: 1.0)
        smoke.run(move(from: smoke.position))
        return smoke
    }
    
    fileprivate static func configureSmokeName() -> String {
        let smoke = GKRandomDistribution(lowestValue: 1, highestValue: 1)
        let randomNumber = smoke.nextInt()
        let imageName = "s" + "\(randomNumber)"
        return imageName
    }
    
    fileprivate static func move(from point: CGPoint) -> SKAction {
        let movePoint = CGPoint(x: point.x, y: -200)
        let moveDistance = point.y + 200
        let movementSpeed: CGFloat = 150.0
        let duration = moveDistance / movementSpeed
        return SKAction.move(to: movePoint, duration: duration)
    }
}
