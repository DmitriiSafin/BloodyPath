//
//  Background.swift
//  BloodyPath
//
//  Created by Дмитрий on 25.04.2023.
//

import SpriteKit

class Background: SKSpriteNode {
    
    static func populateBackground(at point: CGPoint) -> Background {
        let background = Background(imageNamed: "background")
        background.position = point
        background.zPosition = 0
        return background
    }
    
    func makeBackground() {

        var backgroundTexture = SKTexture(imageNamed: "background")

        var shiftBackground = SKAction.moveBy(x: -backgroundTexture.size().width, y: 0, duration: 9)
        var replaceBackground = SKAction.moveBy(x: backgroundTexture.size().width, y: 0, duration: 0)
        var movingAndReplacingBackground = SKAction.repeatForever(SKAction.sequence([shiftBackground,replaceBackground]))

        for i in 1...3 {
            var background = SKSpriteNode(texture: backgroundTexture)
            background.position = CGPoint(x: backgroundTexture.size().width/2.0 + (backgroundTexture.size().width * CGFloat(i)), y: CGRectGetMidY(self.frame))
            background.size.height = self.frame.height
            background.run(movingAndReplacingBackground)

            self.addChild(background)
        }
    }
}
