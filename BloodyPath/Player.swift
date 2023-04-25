//
//  Player.swift
//  BloodyPath
//
//  Created by Дмитрий on 25.04.2023.
//

import SpriteKit

class Player: SKSpriteNode {

    static func populate(at point: CGPoint) -> SKSpriteNode {
        let playerTexture = SKTexture(imageNamed: "character")
        let playerBody = SKSpriteNode(texture: playerTexture)
        playerBody.setScale(0.8)
        playerBody.position = point
        playerBody.zPosition = 5
        return playerBody
    }
}
