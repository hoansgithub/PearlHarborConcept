//
//  GameOverPopup.swift
//  TrigBlasterPractice
//
//  Created by Admin on 12/4/15.
//  Copyright © 2015 Admin. All rights reserved.
//

import SpriteKit

class GameOverPopup: SKSpriteNode {
    private(set) var score:Int;
    private let lblScoreName = "lblScoreName"
    init(size: CGSize , score: Int) {
        self.score = score
        super.init(texture: nil, color: UIColor(red: 121/255, green: 146/255, blue: 248/255, alpha: 0.5), size: size)
        self.userInteractionEnabled = true
        self.position = CGPointMake(size.width / 2, size.height/2)
        self.zPosition = 50
        
        //lbl score
        let labelScore = SKLabelNode(text: String(score))
        //anchor point of parent will be point 0 of child
        labelScore.position = CGPoint(x: 0, y: 0)
        labelScore.fontColor = UIColor.redColor()
        labelScore.color = UIColor.blueColor()
        labelScore.name = lblScoreName
        labelScore.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.Center
        self.addChild(labelScore)
        
        //btn
        
        
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        if let touch = touches.first as UITouch? {
            let location = touch.locationInNode(self)
            
            //check if btn
            let node = self.nodeAtPoint(location)
            if let nodeName = node.name {
                switch (nodeName) {
                case lblScoreName:
                    self.removeFromParent()
                    break
                    
                default:break
                }
            }
            
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
