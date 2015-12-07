//
//  GameScene.swift
//  TrigBlasterPractice
//
//  Created by Admin on 10/13/15.
//  Copyright (c) 2015 Admin. All rights reserved.
//

import SpriteKit


class GameScene: SKScene, SKPhysicsContactDelegate, GameOverPopupDelegate {
    
    //node names
    let btnPauseName = "pauseBtn"
    let btnResumeName = "playBtn"
    //------
    var gamePause = false
    var lastAeroliteSpawnTimeInterval:CFTimeInterval = 0
    var lastEnemySpawnTimeInterval:CFTimeInterval = 0
    var lastFrameUpdateTimeInterval:CFTimeInterval = 0
//    var motherShipStartingHead:CGPoint = CGPoint()
    var motherShip = MotherShip()
    
    var btnPause  = SKSpriteNode()
    var btnResume = SKSpriteNode()
    
    
    
    override func didMoveToView(view: SKView) {
        
        //world
        backgroundColor = SKColor.darkGrayColor()
        physicsWorld.gravity = CGVectorMake(0, 0)
        physicsWorld.contactDelegate = self
        view.allowsTransparency = true
        
        //contents
        self.createGameContents()

        
    }
    
    func createGameContents() {
    
        //mothership 
        
        self.motherShip = MotherShip()
        motherShip.position = CGPoint(x: size.width * 0.5, y: size.height * 0.5)
        motherShip.zPosition = -1;
        
        addChild(motherShip)
        
        //btnPause + resume
        btnPause = SKSpriteNode(imageNamed: btnPauseName)
        btnPause.position = CGPoint(x: btnPause.size.width / 2 + size.width / 50, y: size.height - btnPause.size.height / 2 - size.height / 50)
        btnPause.name = btnPauseName
        btnPause.zPosition = 10
        
        btnResume = SKSpriteNode(imageNamed: btnResumeName)
        btnResume.position = btnPause.position
        btnResume.name = btnResumeName
        btnResume.zPosition = 10
        
        
        //pause game
        self.resumeGame()
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        // Capture the touch event.
        if let touch = touches.first as UITouch? {
            let location = touch.locationInNode(self)
            
            //check if btn
            let node = self.nodeAtPoint(location);
            //if pause button touched
            if (node.name == btnPauseName) {
                self.pauseGame()
            }
            else if (node.name == btnResumeName) {
                self.resumeGame()
            }
            else {
            
            // if not btn = touched screen
            didTouchToScreen(location)
                
            }
            
        }

        
    }
    
    //game's actions
    
    func restart() {
    
        self.removeAllChildren();
        self.removeAllActions();
        self.createGameContents();
    }
    
    func pauseGame() {
        self.btnPause.removeFromParent()
        self.addChild(self.btnResume)
        gamePause = true
//        Vendors.delay(1/60, closure: { () -> () in
//            self.scene?.paused = true
//        })
    }
    func resumeGame() {
        self.btnResume.removeFromParent()
        self.addChild(self.btnPause)
        gamePause = false
        self.paused = false

//        Vendors.delay(1/60, closure: { () -> () in
//            self.scene?.paused = false
//        })
    }
    
    func didTouchToScreen(location:CGPoint) {
        if (self.scene?.paused == true) {
        return
        }
        motherShip.fireAtPoint(location)
    }
    
    func spawnAerolite() {
        //0: top , 1: right , 2: btm, 3: left
        let randStart = arc4random_uniform(4)
        var randX = CGFloat(arc4random_uniform(UInt32(size.width)))
        var randY = CGFloat(arc4random_uniform(UInt32(size.height)))
        switch randStart {
            
        case 0:
            randY = 0;
            break;
        case 1:
            randX = size.width
            break;
        case 2:
            randY = size.height;
            break;
        case 3:
            randX = 0
            break;
        default:break;
            
        }
        let rangeX : UInt32 = UInt32(size.width) / 5
        let rangeY : UInt32 = UInt32(size.height) / 5
        
        let randomDirectionX = BasicMath.randomNumberInRange(rangeX, max: UInt32(size.width) - rangeX)
        let randomDirectionY = BasicMath.randomNumberInRange(rangeY, max: UInt32(size.height) - rangeY)
        
        let randomDirection =  CGPointMake(CGFloat(randomDirectionX),CGFloat(randomDirectionY))
        
        
        //spawn aerolite
        let aerolite = Aerolite()
        aerolite.position = CGPointMake(randX, randY)
        
        addChild(aerolite)
        
        //aerolite actions

        var vectToRandomDirection = randomDirection - aerolite.position
        vectToRandomDirection = vectToRandomDirection.normalized()
        let maxRandomDirection  = randomDirection + vectToRandomDirection * 1000
        aerolite.moveToPoint(maxRandomDirection)
    }
    
    func spawnEnemy() {
        //0: top , 1: right , 2: btm, 3: left
        let randDirection = arc4random_uniform(4)
        var randX = CGFloat(arc4random_uniform(UInt32(size.width)))
        var randY = CGFloat(arc4random_uniform(UInt32(size.height)))
        
        switch randDirection {
        
        case 0:
            randY = 0;
            break;
        case 1:
            randX = size.width
            break;
        case 2:
            randY = size.height;
            break;
        case 3:
            randX = 0
            break;
        default:break;
        
        }
        
        //spawn enemy
        let enemy = EnemyAircraft()
        enemy.position = CGPointMake(randX, randY)
        addChild(enemy)
        //enemy actions
        enemy.moveToPoint(self.motherShip.position)
    }
    
    
    func updateWithTimeSinceLastUpdate(timeSinceLast:CFTimeInterval) {
        self.lastEnemySpawnTimeInterval += timeSinceLast
        self.lastAeroliteSpawnTimeInterval += timeSinceLast
        if (self.lastEnemySpawnTimeInterval > 2) {
            self.lastEnemySpawnTimeInterval = 0
            //spawn enemy
            self.spawnEnemy()
        }
        
        if (self.lastAeroliteSpawnTimeInterval > 3) {
            self.lastAeroliteSpawnTimeInterval = 0
            self.spawnAerolite()
        }
    
    }
    
    override func update(currentTime: CFTimeInterval) {
        
        if gamePause { self.paused = true }
        
        var timeSinceLast = currentTime - self.lastFrameUpdateTimeInterval
        self.lastFrameUpdateTimeInterval = currentTime
        if timeSinceLast > 1 {
            timeSinceLast = 1 / 60
        }
        self.updateWithTimeSinceLastUpdate(timeSinceLast)
    }
    
    
    
    //SKPhysicsContactDelegate
    func didBeginContact(contact: SKPhysicsContact) {
        // enemy - mothership
        if ((contact.bodyA.categoryBitMask == PhysicsCategory.enemyCategory) &&
            (contact.bodyB.categoryBitMask == PhysicsCategory.motherShipCategory) ||
            (contact.bodyA.categoryBitMask == PhysicsCategory.motherShipCategory) &&
            (contact.bodyB.categoryBitMask == PhysicsCategory.enemyCategory)) {
            
                
            if let toBeRemoved:SKNode? =
                (contact.bodyA.categoryBitMask > contact.bodyB.categoryBitMask) ?
                    contact.bodyA.node : contact.bodyB.node {
                toBeRemoved?.removeFromParent()
                        var latestHP = motherShip.healthPoint - 10
                        if (latestHP < 0) { latestHP = 0 }
                motherShip.healthPoint = latestHP
                motherShip.drawHealthBar()
                        
            }
            
        }
        // enemy - bullet
        else if ((contact.bodyA.categoryBitMask == PhysicsCategory.enemyCategory) &&
            (contact.bodyB.categoryBitMask == PhysicsCategory.baseBulletCategory) ||
            (contact.bodyA.categoryBitMask == PhysicsCategory.baseBulletCategory) &&
            (contact.bodyB.categoryBitMask == PhysicsCategory.enemyCategory)) {
                
                let currentEnemy : EnemyAircraft = ((contact.bodyA.categoryBitMask == PhysicsCategory.enemyCategory) ? contact.bodyA.node : contact.bodyB.node) as! EnemyAircraft
                let currentBullet : MotherShipBullet = ((contact.bodyA.categoryBitMask == PhysicsCategory.baseBulletCategory) ? contact.bodyA.node : contact.bodyB.node) as! MotherShipBullet
                
                let enemyHealth  = currentEnemy.healthPoint - 50
                if (enemyHealth <= 0) {
                    currentEnemy.removeFromParent()
                    var latestHP = motherShip.healthPoint + 10
                    if (latestHP > 100) { latestHP = 100 }
                    motherShip.healthPoint = latestHP
                    motherShip.drawHealthBar()
                }
                else {
                    currentEnemy.healthPoint = enemyHealth
                    currentEnemy.drawHealthBar()
                }
                
                currentBullet.removeFromParent()
                
        }
        
        //aerolite - mothership
        if ((contact.bodyA.categoryBitMask == PhysicsCategory.aeroliteCategory) &&
            (contact.bodyB.categoryBitMask == PhysicsCategory.motherShipCategory) ||
            (contact.bodyA.categoryBitMask == PhysicsCategory.motherShipCategory) &&
            (contact.bodyB.categoryBitMask == PhysicsCategory.aeroliteCategory)) {
                
                if let toBeRemoved:SKNode? =
                    (contact.bodyA.categoryBitMask > contact.bodyB.categoryBitMask) ?
                        contact.bodyA.node : contact.bodyB.node {
                            toBeRemoved?.removeFromParent()
                            
                            var latestHP = motherShip.healthPoint - 10
                            if (latestHP < 0) { latestHP = 0 }
                            motherShip.healthPoint = latestHP
                            motherShip.drawHealthBar()
                            
                            
                            
                }
                
        }
        //aerolite - bullet
        else if ((contact.bodyA.categoryBitMask == PhysicsCategory.aeroliteCategory) &&
            (contact.bodyB.categoryBitMask == PhysicsCategory.baseBulletCategory) ||
            (contact.bodyA.categoryBitMask == PhysicsCategory.baseBulletCategory) &&
            (contact.bodyB.categoryBitMask == PhysicsCategory.aeroliteCategory)) {
                contact.bodyA.node?.removeFromParent()
                contact.bodyB.node?.removeFromParent()
                var latestHP = motherShip.healthPoint + 10
                if (latestHP > 100) { latestHP = 100 }
                motherShip.healthPoint = latestHP
                motherShip.drawHealthBar()
                
                
        }
        print(motherShip.healthPoint)
        if(motherShip.healthPoint <= 0)
        {

            
            runAction(SKAction.sequence([
                SKAction.waitForDuration(0.3),
                SKAction.runBlock() {
                    self.pauseGame()

                    
                    let gop = GameOverPopup(size: self.size, score: 100)
                    gop.delegate = self
                    self.addChild(gop)
                }
                ]))
            
        }
    }
    
    
    // MARK:  GameOverPopupDelegate
    func didTouchRestartGame(popup: SKSpriteNode) {
        popup.removeFromParent()
        self.restart()
    }
    
    func didTouchBackMenu(popup: SKSpriteNode) {
        popup.removeFromParent()
        let reveal = SKTransition.fadeWithDuration(1);
        
        let scene = GameMenuScene(size: self.view!.bounds.size)
        scene.scaleMode = .ResizeFill;
        self.view?.presentScene(scene, transition: reveal)
    }
    
    
}

