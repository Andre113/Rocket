//
//  Box.swift
//  Rocket
//
//  Created by Andre Lucas Ota on 25/05/15.
//  Copyright (c) 2015 Andre Lucas Ota. All rights reserved.
//

import SpriteKit

class Box: SKSpriteNode{
    var number: Int = 0
    
    init(number: Int, pos: CGPoint){
        let texture = SKTexture(imageNamed: "box")
        super.init(texture: texture, color: UIColor.clearColor(), size: texture.size())
        
        self.name = "box.\(number)"
        self.number = number
        self.position = pos
        self.zPosition = 1
        
        createLabel()
    }
    
    func createLabel(){
        let label = SKLabelNode(text: "\(number)")
        label.fontColor = UIColor.whiteColor()
        label.fontName = "Chalkduster"
        label.fontSize = 30
        label.name = "label.\(number)"
        label.position = CGPointMake(0,-25)
        label.zPosition = 2
        addChild(label)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
