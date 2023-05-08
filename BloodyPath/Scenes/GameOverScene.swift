//
//  GameOverScene.swift
//  BloodyPath
//
//  Created by Дмитрий on 06.05.2023.
//

import SpriteKit

class GameOverScene: ParentScene {
    
    override func didMove(to view: SKView) {
       
        setHeader(withName: "game over", andBackground: "header_background")
        
        let titles = ["restart", "options", "best"]
        setButtons(titles: titles)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let location = touches.first!.location(in: self)
        let node = self.atPoint(location)
        
        if node.name == "restart" {
            sceneManager.gameScene = nil
            let transition = SKTransition.crossFade(withDuration: 1.0)
            let gameScene = GameScene(size: self.size)
            gameScene.scaleMode = .aspectFill
            self.scene?.view?.presentScene(gameScene, transition: transition)
            
        } else if node.name == "options" {
            let transition = SKTransition.crossFade(withDuration: 1.0)
            let optionsScene = OptionsScene(size: self.size)
            optionsScene.backScene = self
            optionsScene.scaleMode = .aspectFill
            self.scene!.view?.presentScene(optionsScene, transition: transition)
            
        } else if node.name == "best" {
            let transition = SKTransition.crossFade(withDuration: 1.0)
            let bestScene = BestScene(size: self.size)
            bestScene.backScene = self
            bestScene.scaleMode = .aspectFill
            self.scene!.view?.presentScene(bestScene, transition: transition)
        }
    }
}
