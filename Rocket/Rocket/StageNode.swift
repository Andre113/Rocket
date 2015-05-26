//
//  Stage.swift
//  Rocket
//
//  Created by Rafael  Hieda on 25/05/15.
//  Copyright (c) 2015 Andre Lucas Ota. All rights reserved.
//

import SpriteKit

class StageNode: SKSpriteNode {
    var label:SKLabelNode = SKLabelNode()
    var stageNumber: Int = 0
    
    init(texture:String, stageNumber:Int) {
        let newTexture:SKTexture = SKTexture(imageNamed: texture)
        
        super.init(texture: newTexture, color: UIColor.clearColor(), size: CGSizeMake(200, 150))
        
        self.stageNumber = stageNumber
        self.name = "stage.\(stageNumber)"
        
        label = SKLabelNode(text: "\(stageNumber)")
        label.fontName = "Chalkduster"
        label.name = "label.\(stageNumber)"
        label.fontSize = 50
        label.verticalAlignmentMode = SKLabelVerticalAlignmentMode.Center
        label.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.Center
        label.zPosition = CGFloat(1)
        addChild(label)
    }
    
    func setPosition(x:CGFloat, y:CGFloat) {
        self.position.x = x
        self.position.y = y
        
    }
    
    func getPosition()->(x:CGFloat, y:CGFloat) {
        return (self.position.x,self.position.y)
    }
    
   
    

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
