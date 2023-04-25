//
//  Smoke.swift
//  BloodyPath
//
//  Created by Дмитрий on 25.04.2023.
//

import SpriteKit
import GameplayKit

final class Smoke: SKSpriteNode {

    static func populateSmoke(at point: CGPoint) -> Smoke {
        let smokeName = configureSmokeName()
        let smoke = Smoke(imageNamed: smokeName)
        smoke.position = point
        smoke.setScale(0.5)
        smoke.zPosition = 10
        smoke.run(move(from: point))
        return smoke
    }
    
    fileprivate static func configureSmokeName() -> String {
        let smoke = GKRandomDistribution(lowestValue: 1, highestValue: 2)
        let randomNumber = smoke.nextInt()
        let imageName = "s" + "\(randomNumber)"
        return imageName
    }
    
    fileprivate static func move(from point: CGPoint) -> SKAction {
        let movePoint = CGPoint(x: point.x, y: -200)
        let moveDistance = point.y + 200
        let movementSpeed: CGFloat = 15.0
        let duration = moveDistance / movementSpeed
        return SKAction.move(to: movePoint, duration: duration)
    }
}
