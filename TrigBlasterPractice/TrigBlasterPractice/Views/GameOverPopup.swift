//
//  GameOverPopup.swift
//  TrigBlasterPractice
//
//  Created by Admin on 12/4/15.
//  Copyright © 2015 Admin. All rights reserved.
//

import SpriteKit

protocol GameOverPopupDelegate {

    func didTouchRestartGame(popup:SKSpriteNode)
    func didTouchBackMenu(popup:SKSpriteNode)
}

class GameOverPopup: SKSpriteNode {
    
    var delegate:GameOverPopupDelegate?
    private(set) var score:Int
    private let lblScoreName = "lblScoreName"
    private let lblBackHome = "lblBackHome"
    init(size: CGSize , score: Int) {
        self.score = score
        super.init(texture: nil, color: UIColor(red: 121/255, green: 146/255, blue: 248/255, alpha: 0.5), size: size)
        self.userInteractionEnabled = true
        self.position = CGPointMake(size.width / 2, size.height/2)
        self.zPosition = 50
        
        //lbl score
        let labelScore = SKLabelNode(text: String(score))
        //anchor point of parent will be point 0 of child
        labelScore.position = CGPoint(x: 0, y: size.height / 4)
        labelScore.fontColor = UIColor.redColor()
        labelScore.color = UIColor.blueColor()
        labelScore.name = lblScoreName
        labelScore.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.Center
        self.addChild(labelScore)
        
        //lbl home
        let labelHome = SKLabelNode(text: "HOME")
        //anchor point of parent will be point 0 of child
        labelHome.position = CGPoint(x: 0, y: -(size.height / 4))
        labelHome.fontColor = UIColor.redColor()
        labelHome.color = UIColor.blueColor()
        labelHome.name = lblBackHome
        labelHome.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.Center
        self.addChild(labelHome)
        
        
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        if let touch = touches.first as UITouch? {
            let location = touch.locationInNode(self)
            
            //check if btn
            let node = self.nodeAtPoint(location)
            if let nodeName = node.name {
                switch (nodeName) {
                case lblScoreName:
                    self.delegate?.didTouchRestartGame(self)
                    break
                case lblBackHome:
                    self.delegate?.didTouchBackMenu(self)
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
