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
        playerAtlas.preload(completionHandler: {}) //{ print("playerAtlas preloaded")}
        yellowAmmoAtlas.preload(completionHandler: {}) //{ print("yellowAmmoAtlas preloaded") }
        greenPowerUpAtlas.preload(completionHandler: {}) //{ print("greenPowerUpAtlas preloaded") }
        bluePowerUpAtlas.preload(completionHandler: {}) //{ print("bluePowerUpAtlas preloaded") }
        enemy_1Atlas.preload(completionHandler: {}) //{ print("enemy_1Atlas preloaded") }
        enemy_2Atlas.preload(completionHandler: {}) //{ print("enemy_2Atlas preloaded") }
    }
}
