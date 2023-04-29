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
        
        physicsWorld.contactDelegate = self
        physicsWorld.gravity = CGVector.zero
        
        configureStartScene()
        spawnSmoke()
        spawnDecoration()
        player.performRun()
        
        spawnPowerUp()
        spawnEnemies()
    }
    
    fileprivate func spawnPowerUp() {
        
        let spawnAction = SKAction.run {
            let randomNumber = Int(arc4random_uniform(2))
            let powerUp = randomNumber == 1 ? BluePowerUp() : GreenPowerUp()
            let randomPositionX = arc4random_uniform(UInt32(self.size.width - 40))
            
            powerUp.position = CGPoint(x: CGFloat(randomPositionX),
                                       y: self.size.height + 150)
            powerUp.startMovement()
            self.addChild(powerUp)
        }
        let randomTimeSpawn = Double(arc4random_uniform(20) + 15)
        let waitAction = SKAction.wait(forDuration: randomTimeSpawn)
        
        self.run(SKAction.repeatForever(SKAction.sequence([spawnAction, waitAction])))
    }
    
    fileprivate func spawnEnemies() {
        let waitAction = SKAction.wait(forDuration: 3.0)
        let spawnSpiralAction = SKAction.run { [unowned self] in
            self.spawnSpiralOfEnemies()
        }
        self.run(SKAction.repeatForever(SKAction.sequence([waitAction, spawnSpiralAction])))
    }
    
    fileprivate func spawnSpiralOfEnemies() {
        let enemyTextureAtlas1 = Assets.shared.enemy_1Atlas
        let enemyTextureAtlas2 = Assets.shared.enemy_2Atlas
        SKTextureAtlas.preloadTextureAtlases([enemyTextureAtlas1, enemyTextureAtlas2]) {
            [unowned self] in
            
            let randomNumber = Int(arc4random_uniform(2))
            let arrayOfAtlasses = [enemyTextureAtlas1, enemyTextureAtlas2]
            let textureAtlas = arrayOfAtlasses[randomNumber]
            
            let waitAction = SKAction.wait(forDuration: 0.7)
            let spawnEnemy = SKAction.run { [unowned self] in
                let textureNames = textureAtlas.textureNames.sorted()
                let texture = textureAtlas.textureNamed(textureNames[0])
                let enemy = Enemy(enemyTexture: texture)
                enemy.position = CGPoint(x: self.size.width / 2,
                                         y: self.size.height + 200)
                self.addChild(enemy)
                enemy.flySpiral()
            }
            
            let spawnAction = SKAction.sequence([waitAction, spawnEnemy])
            let repeatAction = SKAction.repeat(spawnAction, count: 3)
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
        let spawnSmokeWait = SKAction.wait(forDuration: 8)
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
    
    fileprivate func playerFire() {
        let shot = YellowShot()
        shot.position = CGPoint(x: self.player.position.x + 30,
                                y: self.player.position.y + 40)
        shot.startMovement()
        self.addChild(shot)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        playerFire()
    }
    
    override func didSimulatePhysics() {
        super.didSimulatePhysics()
        
        player.checkPosition()
        
        enumerateChildNodes(withName: "sprite") { node, stop in
            if node.position.y <= -100 {
                node.removeFromParent()
            }
        }
        
        enumerateChildNodes(withName: "shotSprite") { node, stop in
            if node.position.y >= self.size.height + 100 {
                node.removeFromParent()
            }
        }
    }
}

extension GameScene: SKPhysicsContactDelegate {
    func didBegin(_ contact: SKPhysicsContact) {
        
        let contactCategory: BitMaskCategory = [contact.bodyA.category,
                                                contact.bodyB.category]
        
        switch contactCategory {
        case [.enemy, .player]: print("enemy vs player")
        case [.powerUp, .player]: print("powerUp vs player")
        case [.enemy, .shot]: print("enemy vs shot")
        default: preconditionFailure("Error")
        }
    }
    
    func didEnd(_ contact: SKPhysicsContact) {
        
    }
}
