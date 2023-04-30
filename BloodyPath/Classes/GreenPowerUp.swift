//
//  GreenPowerUp.swift
//  BloodyPath
//
//  Created by Дмитрий on 29.04.2023.
//

import SpriteKit

class GreenPowerUp: PowerUp {
    
    init() {
        let textureAtlas = Assets.shared.greenPowerUpAtlas
        super.init(textureAtlas: textureAtlas)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
