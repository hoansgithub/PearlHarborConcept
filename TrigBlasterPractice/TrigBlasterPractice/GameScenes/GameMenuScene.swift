//
//  GameMenuScene.swift
//  TrigBlasterPractice
//
//  Created by Admin on 12/7/15.
//  Copyright © 2015 Admin. All rights reserved.
//

import SpriteKit

class GameMenuScene: SKScene,SKPhysicsContactDelegate {
    
    private let lblStartName = "lblStartName"
    override func didMoveToView(view: SKView) {
        //lbl score
        let lblStart = SKLabelNode(text: "START")
        //anchor point of parent will be point 0 of child
        lblStart.position = CGPoint(x: size.width/2 , y: size.height/2)
        lblStart.fontColor = UIColor.redColor()
        lblStart.color = UIColor.blueColor()
        lblStart.name = lblStartName
        lblStart.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.Center
        self.addChild(lblStart)

    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        if let touch = touches.first as UITouch? {
            let location = touch.locationInNode(self)
            
            //check if btn
            let node = self.nodeAtPoint(location)
            if let nodeName = node.name {
                switch (nodeName) {
                case lblStartName:
                    let reveal = SKTransition.fadeWithDuration(1);
                    
                    let scene = GameScene(size: self.view!.bounds.size)
                    scene.scaleMode = .ResizeFill;
                    self.view?.presentScene(scene, transition: reveal)
                    break
                    
                default:break
                }
            }
            
        }
    }
}
