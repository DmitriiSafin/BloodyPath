//
//  HUD.swift
//  BloodyPath
//
//  Created by Дмитрий on 30.04.2023.
//

import SpriteKit

class HUD: SKScene {

    let scoreBackground = SKSpriteNode(imageNamed: "scores")
    let scoreLabel = SKLabelNode(text: "10000")
    let menuButton = SKSpriteNode(imageNamed: "menu")
    let life1 = SKSpriteNode(imageNamed: "life")
    let life2 = SKSpriteNode(imageNamed: "life")
    let life3 = SKSpriteNode(imageNamed: "life")
    
    func configureUI(screenSize: CGSize) {
        scoreBackground.position = CGPoint(
            x: scoreBackground.size.width + 10,
            y: screenSize.height - scoreBackground.size.height / 2 - 26
        )
        scoreBackground.anchorPoint = CGPoint(x: 1.0, y: 0.5)
        scoreBackground.zPosition = 99
        addChild(scoreBackground)
        
        scoreLabel.horizontalAlignmentMode = .right
        scoreLabel.verticalAlignmentMode = .center
        scoreLabel.position = CGPoint(x: -10, y: 3)
        scoreLabel.zPosition = 100
        scoreLabel.fontName = "AmericanTypewriter-Bold"
        scoreLabel.fontSize = 30
        scoreBackground.addChild(scoreLabel)
        
        menuButton.position = CGPoint(x: 20, y: 20)
        menuButton.anchorPoint = CGPoint(x: 0, y: 0)
        menuButton.zPosition = 100
        addChild(menuButton)
        
        let lifes = [life1, life2, life3]
        for (index, life) in lifes.enumerated() {
            let sizeWidth1 = screenSize.width
            let sizeWidth2 = (CGFloat((index + 1)) * (life.size.width + 3))
            let x = sizeWidth1 - sizeWidth2
            life.position = CGPoint(x: x, y: 20)
            life.zPosition = 100
            life.anchorPoint = CGPoint(x: 0, y: 0)
            addChild(life)
        }
    }
}
