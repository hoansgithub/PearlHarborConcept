//
//  MotherShip.swift
//  TrigBlasterPractice
//
//  Created by Admin on 10/27/15.
//  Copyright © 2015 Admin. All rights reserved.
//

import SpriteKit

class MotherShip : SKSpriteNode {
    var healthPoint : CGFloat = 0
    var turret : SKSpriteNode
    var healthBar : SKSpriteNode
    init() {
        self.turret = SKSpriteNode(imageNamed: "Turret")
        let texture = SKTexture(imageNamed: "Cannon")
        self.healthPoint = 100
        self.healthBar = SKSpriteNode()
        super.init(texture: texture, color: UIColor.clearColor(), size: texture.size())
        //mothership physicsbody
        self.physicsBody?.dynamic = true
        self.physicsBody = SKPhysicsBody(rectangleOfSize: CGSizeMake(self.turret.size.width / 2, self.turret.size.height / 2))
        self.physicsBody?.usesPreciseCollisionDetection = true
        self.physicsBody?.categoryBitMask = PhysicsCategory.motherShipCategory
        self.physicsBody?.collisionBitMask = PhysicsCategory.None
        self.physicsBody?.contactTestBitMask = PhysicsCategory.enemyCategory |
            PhysicsCategory.aeroliteCategory
        self.physicsBody?.restitution = 0
        turret.position = CGPointMake(0, 0)
        turret.zPosition = 1
        self.addChild(turret)
        self.drawHealthBar()
        
    }
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        self.healthPoint = 100
        self.turret = SKSpriteNode(imageNamed: "Turret")
        self.healthBar = SKSpriteNode()
        super.init(texture: texture, color: UIColor.clearColor(), size: texture!.size())
        //mothership physicsbody
        self.physicsBody?.dynamic = true
        self.physicsBody = SKPhysicsBody(rectangleOfSize: CGSizeMake(self.turret.size.width / 2, self.turret.size.height / 2))
        self.physicsBody?.usesPreciseCollisionDetection = true
        self.physicsBody?.categoryBitMask = PhysicsCategory.motherShipCategory
        self.physicsBody?.collisionBitMask = PhysicsCategory.None
        self.physicsBody?.contactTestBitMask = PhysicsCategory.enemyCategory |
            PhysicsCategory.aeroliteCategory
        self.physicsBody?.restitution = 0
        turret.position = CGPointMake(0, 0)
        turret.zPosition = 1
        self.addChild(turret)
        self.drawHealthBar()
        
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    //action
    func fireAtPoint(destination : CGPoint) {
        //nomaliez vect
        var vectToTouch = destination - self.position
        vectToTouch = vectToTouch.normalized()
        
        //angle
        let angle = atan2( destination.x - self.position.x  ,
            destination.y - self.position.y)
        let rotateAction = SKAction.rotateToAngle(-angle, duration: 0.1, shortestUnitArc: true)
        self.turret.runAction(rotateAction, completion: { () -> Void in
            //add bullet
            let bullet = MotherShipBullet()
            bullet.position =  self.position + vectToTouch *
                (self.size.height / 2)
            bullet.zRotation = -angle
            self.parent!.addChild(bullet)
            
            //shot the bullet
            let bulletMaxPos  = bullet.position + vectToTouch * 1000
            let lengthToMax = CGPoint.getLength(bulletMaxPos, right: bullet.position)
            let duration = lengthToMax / 400
            let shotAction = SKAction.moveTo(bulletMaxPos, duration: NSTimeInterval(duration))
            bullet.runAction(shotAction)
        })
    }
    
    //draw
    func drawHealthBar() {
        
        self.removeChildrenInArray([healthBar])
        let healthBarWidth = self.size.width
        let healthBarHeight = self.size.height / 10
        
        let widthOfHealth = healthBarWidth * self.healthPoint / 100
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
        healthBar.position = CGPointMake(0 , -1 * ( self.size.height / 2))
        healthBar.name = "motherShipHealthBar"
        healthBar.zPosition = 2
        
        self.addChild(healthBar)
    }
}
