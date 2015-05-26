//
//  PauseNode.swift
//  Rocket
//
//  Created by Andre Lucas Ota on 26/05/15.
//  Copyright (c) 2015 Andre Lucas Ota. All rights reserved.
//

import SpriteKit

class PauseNode: SKSpriteNode{
    init(newX: CGFloat, newY: CGFloat){
        let texture = SKTexture(imageNamed: "PauseBox.png")
        super.init(texture: texture, color: UIColor.clearColor(), size: CGSizeMake(300, 150))
        
        self.name = "PauseBox"
        self.position = CGPointMake(newX, newY)
        self.zPosition = 4
        
        self.createResume()
        self.createBack()
    }
    
    func createResume(){
        let pos = CGPointMake(0, 20)
        let resume = createNewLabel("Continuar", name: "resume", pos: pos)
        addChild(resume)
    }
    
    func createBack(){
        let pos = CGPointMake(0, -30)
        let back = createNewLabel("Menu", name: "back", pos: pos)
        addChild(back)
    }
    
    func createNewLabel(text: String, name: String, pos: CGPoint) -> SKLabelNode{
        let newLabel = SKLabelNode(text: text)
        newLabel.fontName = "Chalkduster"
        newLabel.fontColor = UIColor.blackColor()
        newLabel.fontSize = 18
        newLabel.name = name
        newLabel.position = pos
        newLabel.zPosition = 5
        return newLabel
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
