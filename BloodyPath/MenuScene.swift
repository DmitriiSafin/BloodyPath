//
//  MenuScene.swift
//  BloodyPath
//
//  Created by Дмитрий on 29.04.2023.
//

import SpriteKit

class MenuScene: SKScene {

    override func didMove(to view: SKView) {
        Assets.shared.preloadAssets()
        self.backgroundColor = SKColor(red: 0.15, green: 0.15, blue: 0.3, alpha: 1.0)
        let texture = SKTexture(imageNamed: "play")
        let button = SKSpriteNode(texture: texture)
        button.position = CGPoint(x: self.frame.midX,
                                  y: self.frame.midY)
        button.name = "runButton"
        self.addChild(button)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let location = touches.first!.location(in: self)
        let node = self.atPoint(location)
        
        if node.name == "runButton" {
            let transition = SKTransition.crossFade(withDuration: 1.0)
            let gameScene = GameScene(size: self.size)
            gameScene.scaleMode = .aspectFill
            self.scene?.view?.presentScene(gameScene, transition: transition)
        }
    }
}
