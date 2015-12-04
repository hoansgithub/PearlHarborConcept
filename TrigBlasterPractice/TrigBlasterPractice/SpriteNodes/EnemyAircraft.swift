//
//  EnemyAircraft.swift
//  TrigBlasterPractice
//
//  Created by Admin on 10/29/15.
//  Copyright © 2015 Admin. All rights reserved.
//

import SpriteKit
class EnemyAircraft: SKSpriteNode {
    var healthPoint : CGFloat = 100
    var healthBar : SKSpriteNode
    var airCraft : SKSpriteNode
    init() {
        let texture = SKTexture(imageNamed: "Player")
        self.healthPoint = 100
        self.healthBar = SKSpriteNode()
        self.airCraft = SKSpriteNode(texture: texture, color: UIColor.clearColor(), size: texture.size())
        super.init(texture: nil, color: UIColor.clearColor(), size: texture.size())
        //enemy physicsbody
        self.physicsBody?.dynamic = true
        self.physicsBody = SKPhysicsBody(rectangleOfSize: texture.size())
        self.physicsBody?.usesPreciseCollisionDetection = true
        self.physicsBody?.categoryBitMask = PhysicsCategory.enemyCategory
        self.physicsBody?.collisionBitMask = PhysicsCategory.baseBulletCategory |
            PhysicsCategory.motherShipCategory
        self.physicsBody?.contactTestBitMask = PhysicsCategory.baseBulletCategory |
            PhysicsCategory.motherShipCategory
        self.physicsBody?.restitution = 0
        self.addChild(self.airCraft)
        self.drawHealthBar()
        
        
    }
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        self.healthPoint = 100
        self.healthBar = SKSpriteNode()
        self.airCraft = SKSpriteNode(texture: texture, color: UIColor.clearColor(), size: texture!.size())
        super.init(texture: nil, color: UIColor.clearColor(), size: texture!.size())

        //enemy physicsbody
        self.physicsBody?.dynamic = true
        self.physicsBody = SKPhysicsBody(rectangleOfSize: texture!.size())
        self.physicsBody?.usesPreciseCollisionDetection = true
        self.physicsBody?.categoryBitMask = PhysicsCategory.enemyCategory
        self.physicsBody?.collisionBitMask = PhysicsCategory.baseBulletCategory |
            PhysicsCategory.motherShipCategory
        self.physicsBody?.contactTestBitMask = PhysicsCategory.baseBulletCategory |
            PhysicsCategory.motherShipCategory
        self.physicsBody?.restitution = 0
        self.addChild(self.airCraft)
        self.drawHealthBar()
        
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //actions
    func moveToPoint(point:CGPoint) {
        let angle = atan2(point.x - self.position.x,
            point.y - self.position.y)
        
        self.airCraft.zRotation = -angle
        
        let enemyAction = SKAction.moveTo(point, duration: 4)
        
        self.runAction(enemyAction)
    }
    //draw
    func drawHealthBar() {
        
        self.removeChildrenInArray([healthBar])
        let healthBarWidth = self.size.width
        let healthBarHeight = self.size.height / 10
        
        let widthOfHealth = (self.size.width - 2.0) * self.healthPoint / 100
        let clearColor = UIColor.clearColor()
        let fillColor = UIColor(red: 113/255, green: 202/255, blue: 53/255, alpha: 1.0)
        let borderColor = UIColor(red: 35/255, green: 28/255, blue: 40/255, alpha: 1.0)
        
        //outline
        let outlineRectSize = CGSizeMake(healthBarWidth - 1, healthBarHeight - 1)
        UIGraphicsBeginImageContextWithOptions(outlineRectSize, false, 0)
        let healthBarContext = UIGraphicsGetCurrentContext()
        
        //drawing outline
        let spriteOutlineRect = CGRectMake(0, 0, healthBarWidth - 1, healthBarHeight - 1)
        CGContextSetStrokeColorWithColor(healthBarContext, borderColor.CGColor)
        CGContextSetLineWidth(healthBarContext, 1)
        CGContextAddRect(healthBarContext, spriteOutlineRect)
        CGContextStrokePath(healthBarContext)
        
        //fill health bar
        var spriteFillRect = CGRectMake(0.5, 0.5, outlineRectSize.width - 1, outlineRectSize.height - 1)
        spriteFillRect.size.width = widthOfHealth
        CGContextSetFillColorWithColor(healthBarContext, fillColor.CGColor)
        CGContextSetStrokeColorWithColor(healthBarContext, clearColor.CGColor)
        CGContextSetLineWidth(healthBarContext, 1)
        CGContextFillRect(healthBarContext, spriteFillRect)
        
        //generate a spite image of 2 pieces for display
        let spriteImg = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        let spriteCGImageRef = spriteImg.CGImage
        let spriteTexture = SKTexture(CGImage: spriteCGImageRef!)
        spriteTexture.filteringMode = SKTextureFilteringMode.Linear
        healthBar = SKSpriteNode(texture: spriteTexture, size: outlineRectSize)
        healthBar.position = CGPointMake(0 , -1 * ( self.size.height / 2) - 5)
        healthBar.name = "enemyHealthBar"
        healthBar.zPosition = 2
        self.addChild(healthBar)
    }
    
}
