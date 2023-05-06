//
//  Decoration.swift
//  BloodyPath
//
//  Created by Дмитрий on 25.04.2023.
//

import SpriteKit
import GameplayKit

final class Decoration: SKSpriteNode, GameBackgroundSpriteableProtocol {
    
    static func populate(at point: CGPoint?) -> Decoration {
        let decorationName = configureDecorationName()
        let decoration = Decoration(imageNamed: decorationName)
        decoration.position = point ?? randomPoint()
        decoration.setScale(randomScaleFactor)
        decoration.zPosition = 1
        decoration.anchorPoint = CGPoint(x: 0.5, y: 1.0)
        decoration.name = "sprite"
        decoration.run(rotateForRandomAngle())
        decoration.run(move(from: decoration.position))
        return decoration
    }
    
    fileprivate static func configureDecorationName() -> String {
        let distribution = GKRandomDistribution(lowestValue: 1, highestValue: 8)
        let randomNumber = distribution.nextInt()
        let imageName = "decoration" + "\(randomNumber)"
        return imageName
    }
    
    fileprivate static var randomScaleFactor: CGFloat {
        let distribution = GKRandomDistribution(lowestValue: 3,
                                                highestValue: 7)
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
        let movementSpeed: CGFloat = 100.0
        let duration = moveDistance / movementSpeed
        return SKAction.move(to: movePoint, duration: duration)
    }
}
