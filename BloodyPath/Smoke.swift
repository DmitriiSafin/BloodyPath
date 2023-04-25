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
        return smoke
    }
    
    fileprivate static func configureSmokeName() -> String {
        let smoke = GKRandomDistribution(lowestValue: 1, highestValue: 3)
        let randomNumber = smoke.nextInt()
        let imageName = "s" + "\(randomNumber)"
        return imageName
    }
}
