//
//  GameScene.swift
//  BloodyPath
//
//  Created by Дмитрий on 25.04.2023.
//

import SpriteKit
import GameplayKit

class GameScene: ParentScene {
    
    fileprivate var player: Player!
    fileprivate let hud = HUD()
    fileprivate let screenSize = UIScreen.main.bounds.size
    fileprivate var scroller: InfiniteScrollingBackground?
    fileprivate var lives = 3 {
        didSet {
            switch lives {
            case 3:
                hud.life1.isHidden = false
                hud.life2.isHidden = false
                hud.life3.isHidden = false
            case 2:
                hud.life1.isHidden = false
                hud.life2.isHidden = false
                hud.life3.isHidden = true
            case 1:
                hud.life1.isHidden = false
                hud.life2.isHidden = true
                hud.life3.isHidden = true
            case 0:
                hud.life1.isHidden = true
                hud.life2.isHidden = true
                hud.life3.isHidden = true
            default:
                break
            }
        }
    }

    override func didMove(to view: SKView) {
        
        self.scene?.isPaused = false
        guard sceneManager.gameScene == nil else { return }
        
        sceneManager.gameScene = self
        
        physicsWorld.contactDelegate = self
        physicsWorld.gravity = CGVector.zero
        
        configureStartScene()
        spawnSmoke()
        spawnDecoration()
        player.performRun()
        
        spawnPowerUp()
        spawnEnemies()
        createHUD()
    }
    
    fileprivate func createHUD() {
        addChild(hud)
        hud.configureUI(screenSize: screenSize)
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
        
        let images = [UIImage(named: "background")!, UIImage(named: "background")!, UIImage(named: "background")!]
        scroller = InfiniteScrollingBackground(images: images, scene: self,
                                               scrollDirection: .bottom,
                                               transitionSpeed: 8)
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
        let location = touches.first!.location(in: self)
        let node = self.atPoint(location)
        
        if node.name == "pause" {
            let transition = SKTransition.doorway(withDuration: 1.0)
            let pauseScene = PauseScene(size: self.size)
            pauseScene.scaleMode = .aspectFill
            sceneManager.gameScene = self
            self.scene?.isPaused = true
            self.scene?.view?.presentScene(pauseScene, transition: transition)
        } else {
            playerFire()
        }
    }
    
    override func didSimulatePhysics() {
        super.didSimulatePhysics()
        
        player.checkPosition()
        
        enumerateChildNodes(withName: "sprite") { node, stop in
            if node.position.y <= -100 {
                node.removeFromParent()
            }
        }
        
        enumerateChildNodes(withName: "greenPowerUp") { node, stop in
            if node.position.y <= -100 {
                node.removeFromParent()
            }
        }
        
        enumerateChildNodes(withName: "bluePowerUp") { node, stop in
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
        
        let explosion = SKEmitterNode(fileNamed: "EnemyExplosion")
        let contactPoint = contact.contactPoint
        explosion?.position = contactPoint
        explosion?.zPosition = 6
        let waitForExplosionAction = SKAction.wait(forDuration: 1)
        
        let contactCategory: BitMaskCategory = [contact.bodyA.category,
                                                contact.bodyB.category]
        switch contactCategory {
        case [.enemy, .player]:
            if contact.bodyA.node?.name == "sprite" {
                if contact.bodyA.node?.parent != nil {
                    contact.bodyA.node?.removeFromParent()
                    lives -= 1
                }
            } else {
                if contact.bodyB.node?.parent != nil {
                    contact.bodyB.node?.removeFromParent()
                    lives -= 1
                }
            }
            addChild(explosion!)
            self.run(waitForExplosionAction) {
                explosion?.removeFromParent()
            }
            
            if lives == -1 {
                gameSettings.currentScore = hud.score
                gameSettings.saveScores()
                let transition = SKTransition.doorsCloseVertical(withDuration: 1)
                let gameOverScene = GameOverScene(size: self.size)
                gameOverScene.scaleMode = .aspectFill
                self.scene?.view?.presentScene(gameOverScene, transition: transition)
            }
            
        case [.powerUp, .player]:
            
            if contact.bodyA.node?.parent != nil && contact.bodyB.node?.parent != nil {
                if contact.bodyA.node?.name == "greenPowerUp" {
                    contact.bodyA.node?.removeFromParent()
                    if lives < 3 {
                        lives += 1
                    }
                    player.catchGreenPowerUp()
                } else if contact.bodyB.node?.name == "greenPowerUp" {
                    contact.bodyB.node?.removeFromParent()
                    if lives < 3 {
                        lives += 1
                    }
                    player.catchGreenPowerUp()
                }
                
                if contact.bodyA.node?.name == "bluePowerUp" {
                    contact.bodyA.node?.removeFromParent()
                    hud.score += 100
                    player.catchBluePowerUp()
                } else if contact.bodyB.node?.name == "bluePowerUp" {
                    contact.bodyB.node?.removeFromParent()
                    hud.score += 100
                    player.catchBluePowerUp()
                }
            }
            
        case [.enemy, .shot]:
          //  if contact.bodyA.node?.name == "shotSprite" {
                if contact.bodyA.node?.parent != nil {
                    contact.bodyA.node?.removeFromParent()
                    contact.bodyB.node?.removeFromParent()
                    hud.score += 1
                }
//            } else {
//                if contact.bodyB.node?.parent != nil {
//                    contact.bodyB.node?.removeFromParent()
//                    contact.bodyB.node?.removeFromParent()
//                    hud.score += 1
//                }
//            }

            addChild(explosion!)
            self.run(waitForExplosionAction) {
                explosion?.removeFromParent()
            }
        default: preconditionFailure("Error")
        }
    }
    
    func didEnd(_ contact: SKPhysicsContact) {
        
    }
}
