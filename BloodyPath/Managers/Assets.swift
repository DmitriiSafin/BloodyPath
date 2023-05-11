//
//  Assets.swift
//  BloodyPath
//
//  Created by Дмитрий on 29.04.2023.
//

import SpriteKit

class Assets {

    static let shared = Assets()
    var isLoaded = false
    let playerAtlas = SKTextureAtlas(named: "Player")
    let yellowAmmoAtlas = SKTextureAtlas(named: "YellowAmmo")
    let greenPowerUpAtlas = SKTextureAtlas(named: "GreenPowerUp")
    let bluePowerUpAtlas = SKTextureAtlas(named: "BluePowerUp")
    let enemy_1Atlas = SKTextureAtlas(named: "Enemy_1")
    let enemy_2Atlas = SKTextureAtlas(named: "Enemy_2")
    
    func preloadAssets() {
        playerAtlas.preload(completionHandler: {})
        yellowAmmoAtlas.preload(completionHandler: {})
        greenPowerUpAtlas.preload(completionHandler: {})
        bluePowerUpAtlas.preload(completionHandler: {})
        enemy_1Atlas.preload(completionHandler: {})
        enemy_2Atlas.preload(completionHandler: {})
    }
}
