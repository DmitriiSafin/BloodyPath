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
        smoke.setScale(randomScaleFactor)
        smoke.zPosition = 10
        smoke.name = "sprite"
        smoke.anchorPoint = CGPoint(x: 0.5, y: 1.0)
        smoke.run(rotateForRandomAngle())
        smoke.run(move(from: smoke.position))
        return smoke
    }
    
    fileprivate static func configureSmokeName() -> String {
        let smoke = GKRandomDistribution(lowestValue: 1, highestValue: 1)
        let randomNumber = smoke.nextInt()
        let imageName = "s" + "\(randomNumber)"
        return imageName
    }
    
    fileprivate static var randomScaleFactor: CGFloat {
        let distribution = GKRandomDistribution(lowestValue: 5,
                                                highestValue: 13)
        let randomNumber = CGFloat(distribution.nextInt()) / 10
        return randomNumber
    }
    
    fileprivate static func rotateForRandomAngle() -> SKAction {
        let distribution = GKRandomDistribution(lowestValue: 0, highestValue: 360)
        let randomNumber = CGFloat(distribution.nextInt())
        return SKAction.rotate(toAngle: randomNumber * CGFloat(Double.pi / 180),
                               duration: 0)
    }
    
    fileprivate static func move(from point: CGPoint) -> SKAction {
        let movePoint = CGPoint(x: point.x, y: -200)
        let moveDistance = point.y + 200
        let movementSpeed: CGFloat = 200.0
        let duration = moveDistance / movementSpeed
        return SKAction.move(to: movePoint, duration: duration)
    }
}
