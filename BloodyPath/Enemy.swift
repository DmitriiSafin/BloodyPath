//
//  Enemy.swift
//  BloodyPath
//
//  Created by Дмитрий on 28.04.2023.
//

import SpriteKit

class Enemy: SKSpriteNode {
    
    static var textureAtlas: SKTextureAtlas?
    
    init() {
        let texture = Enemy.textureAtlas?.textureNamed("enemy1")
        super.init(texture: texture, color: .clear, size: CGSize(width: 180, height: 133))
        self.xScale = 0.7
        self.yScale = 0.7
        self.zPosition = 5
        self.name = "sprite"
    }
    
    func flySpiral() {
        let screenSize = UIScreen.main.bounds
        let timeHorizontal: Double = 3
        let timeVertical: Double = 10
        let moveLeft = SKAction.moveTo(x: 50, duration: timeHorizontal)
        moveLeft.timingMode = .easeInEaseOut
        let moveRight = SKAction.moveTo(x: screenSize.width - 50, duration: timeHorizontal)
        moveRight.timingMode = .easeInEaseOut
        let asideMovementSequence = SKAction.sequence([moveLeft, moveRight])
        let foreverAsideMovement = SKAction.repeatForever(asideMovementSequence)
        
        let forvardMovement = SKAction.moveTo(y: -250 , duration: timeVertical)
        let groupMovement = SKAction.group([foreverAsideMovement, forvardMovement])
        self.run(groupMovement)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
