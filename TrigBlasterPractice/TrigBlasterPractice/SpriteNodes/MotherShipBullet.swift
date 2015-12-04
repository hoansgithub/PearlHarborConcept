//
//  MotherShipBullet.swift
//  TrigBlasterPractice
//
//  Created by Admin on 10/29/15.
//  Copyright © 2015 Admin. All rights reserved.
//

import SpriteKit
class MotherShipBullet : SKSpriteNode {
    init() {
        let texture = SKTexture(imageNamed: "CannonMissile")
        super.init(texture: texture, color: UIColor.clearColor(), size: texture.size())
        //bullet physicsbody
        self.physicsBody?.dynamic = true
        self.physicsBody = SKPhysicsBody(rectangleOfSize: texture.size())
        self.physicsBody?.usesPreciseCollisionDetection = true
        self.physicsBody?.categoryBitMask = PhysicsCategory.baseBulletCategory
        self.physicsBody?.collisionBitMask = PhysicsCategory.enemyCategory|PhysicsCategory.aeroliteCategory
        self.physicsBody?.contactTestBitMask = PhysicsCategory.enemyCategory|PhysicsCategory.aeroliteCategory
        self.physicsBody?.restitution = 0
        
        
    }
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: UIColor.clearColor(), size: texture!.size())
        //mothership physicsbody
        //bullet physicsbody
        self.physicsBody?.dynamic = true
        self.physicsBody = SKPhysicsBody(rectangleOfSize: texture!.size())
        self.physicsBody?.usesPreciseCollisionDetection = true
        self.physicsBody?.categoryBitMask = PhysicsCategory.baseBulletCategory
        self.physicsBody?.collisionBitMask = PhysicsCategory.enemyCategory|PhysicsCategory.aeroliteCategory
        self.physicsBody?.contactTestBitMask = PhysicsCategory.enemyCategory|PhysicsCategory.aeroliteCategory
        self.physicsBody?.restitution = 0
        
        
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}