//
//  Decoration.swift
//  BloodyPath
//
//  Created by Дмитрий on 25.04.2023.
//

import SpriteKit
import GameplayKit

final class Decoration: SKSpriteNode {
    
    static func populateDecoration(at point: CGPoint) -> Decoration {
        let decorationName = configureDecorationName()
        let decoration = Decoration(imageNamed: decorationName)
        decoration.position = point
        decoration.setScale(0.5)
        decoration.zPosition = 1
        decoration.run(move(from: point))
        return decoration
    }
    
    fileprivate static func configureDecorationName() -> String {
        let distribution = GKRandomDistribution(lowestValue: 1, highestValue: 5)
        let randomNumber = distribution.nextInt()
        let imageName = "decoration" + "\(randomNumber)"
        return imageName
    }
    
    fileprivate static func move(from point: CGPoint) -> SKAction {
        let movePoint = CGPoint(x: point.x, y: -200)
        let moveDistance = point.y + 200
        let movementSpeed: CGFloat = 10.0
        let duration = moveDistance / movementSpeed
        return SKAction.move(to: movePoint, duration: duration)
    }
}
