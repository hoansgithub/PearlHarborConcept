//
//  Aerolite.swift
//  TrigBlasterPractice
//
//  Created by Admin on 10/30/15.
//  Copyright © 2015 Admin. All rights reserved.
//

import SpriteKit
class Aerolite : SKSpriteNode {
    init() {
        let texture = SKTexture(imageNamed: "Asteroid")

        super.init(texture: texture, color: UIColor.clearColor(), size: texture.size())
        //aerolite physicsbody
        self.physicsBody = SKPhysicsBody(rectangleOfSize: texture.size())
        self.physicsBody?.usesPreciseCollisionDetection = true
        self.physicsBody?.categoryBitMask = PhysicsCategory.aeroliteCategory
        self.physicsBody?.collisionBitMask = PhysicsCategory.None
        self.physicsBody?.contactTestBitMask = PhysicsCategory.baseBulletCategory |
            PhysicsCategory.motherShipCategory
        self.physicsBody?.restitution = 0
        
        
        
        
    }
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {

        super.init(texture: texture, color: UIColor.clearColor(), size: texture!.size())
        
        //aerolite physicsbody
        self.physicsBody?.dynamic = true
        self.physicsBody = SKPhysicsBody(rectangleOfSize: texture!.size())
        self.physicsBody?.usesPreciseCollisionDetection = true
        self.physicsBody?.categoryBitMask = PhysicsCategory.enemyCategory
        self.physicsBody?.collisionBitMask = PhysicsCategory.None
        self.physicsBody?.contactTestBitMask = PhysicsCategory.baseBulletCategory |
            PhysicsCategory.motherShipCategory
        self.physicsBody?.restitution = 0
        
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //action 
    func moveToPoint(point : CGPoint){
        //moving
        let aeroliteMoving = SKAction.moveTo(point, duration: 10)
        
        //spinning
        let aeroliteSpinning = SKAction.rotateByAngle(CGFloat( M_PI ), duration: 1)
        let aeroliteSpinningRepeater = SKAction.repeatActionForever(aeroliteSpinning)
        
        //action group
        let aeroliteActionGroup = SKAction.group([aeroliteMoving , aeroliteSpinningRepeater])
        
        
        
        self.runAction(aeroliteActionGroup)

    }
}