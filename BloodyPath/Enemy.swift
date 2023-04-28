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
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
