//
//  GameScene.swift
//  BloodyPath
//
//  Created by Дмитрий on 25.04.2023.
//

import SpriteKit
import GameplayKit


class GameScene: SKScene {
    
    var player: Player!
    var scroller: InfiniteScrollingBackground?
    
    override func didMove(to view: SKView) {
        
        configureStartScene()
        spawnSmoke()
        spawnDecoration()
        player.performRun()
        
        spawnPowerUp()
        spawnEnemy(count: 5)
    }
    
    fileprivate func spawnPowerUp() {
        let powerUp = PowerUp()
        powerUp.position = CGPoint(x: self.size.width / 2, y: self.size.height / 2)
        powerUp.performRotation()
        self.addChild(powerUp)
    }
    
    fileprivate func spawnEnemy(count: Int) {
        let enemyTextureAtlas = SKTextureAtlas(named: "Enemy_1")
        SKTextureAtlas.preloadTextureAtlases([enemyTextureAtlas]) {
            Enemy.textureAtlas = enemyTextureAtlas
            let waitAction = SKAction.wait(forDuration: 1.0)
            let spawnEnemy = SKAction.run {
                let enemy = Enemy()
                enemy.position = CGPoint(x: self.size.width / 2,
                                         y: self.size.height + 200)
                self.addChild(enemy)
                enemy.flySpiral()
            }
            
            let spawnAction = SKAction.sequence([waitAction, spawnEnemy])
            let repeatAction = SKAction.repeat(spawnAction, count: count)
            self.run(repeatAction)
        }
    }
    
    fileprivate func configureStartScene() {
//        let screenCenterPoint = CGPoint(
//            x: self.size.width / 2,
//            y: self.size.height / 2)
//        let bacground = Background.populateBackground(at: screenCenterPoint)
//        bacground.size = self.size
//        self.addChild(bacground)
        
        let images = [UIImage(named: "background")!, UIImage(named: "background")!, UIImage(named: "background")!]
        scroller = InfiniteScrollingBackground(images: images, scene: self, scrollDirection: .bottom, transitionSpeed: 8)
        scroller?.scene.name = "sprite"
        scroller?.scroll()
        scroller?.zPosition = 1
        
        
        let screen = UIScreen.main.bounds
        
        let decoration1 = Decoration.populate(at: CGPoint(x: 100, y: 200))
        self.addChild(decoration1)
        
        let decoration2 = Decoration.populate(
            at: CGPoint(x: self.size.width - 100, y: self.size.height - 200)
        )
        self.addChild(decoration2)
        
        player = Player.populate(at: CGPoint(
            x: screen.size.width / 2, y: 100)
        )
        self.addChild(player)
    }
    
    fileprivate func spawnSmoke() {
        let spawnSmokeWait = SKAction.wait(forDuration: 2)
        let spawnSmokeAction = SKAction.run {
            let smoke = Smoke.populate(at: nil)
            self.addChild(smoke)
        }
        
        let spawnSmokeSequence = SKAction.sequence([spawnSmokeWait, spawnSmokeAction])
        let spawnSmokeForever = SKAction.repeatForever(spawnSmokeSequence)
        run(spawnSmokeForever)
    }
    
    fileprivate func spawnDecoration() {
        let spawnDecorationWait = SKAction.wait(forDuration: 1)
        let spawnDecorationAction = SKAction.run {
            let decoration = Decoration.populate(at: nil)
            self.addChild(decoration)
        }
        
        let spawnDecorationSequence = SKAction.sequence([spawnDecorationWait, spawnDecorationAction])
        let spawnDecorationForever = SKAction.repeatForever(spawnDecorationSequence)
        run(spawnDecorationForever)
    }
    
    override func didSimulatePhysics() {
        super.didSimulatePhysics()
        
        player.checkPosition()
        
        enumerateChildNodes(withName: "sprite") { node, stop in
            if node.position.y < UIScreen.main.bounds.height - 1000 {
                node.removeFromParent()
            }
        }
    }
}
