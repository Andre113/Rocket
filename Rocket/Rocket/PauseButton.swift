//
//  Pause.swift
//  Rocket
//
//  Created by Andre Lucas Ota on 22/05/15.
//  Copyright (c) 2015 Andre Lucas Ota. All rights reserved.
//

import SpriteKit

class PauseButton: SKSpriteNode{
    
    init(newX: CGFloat, newY: CGFloat){
        let texture = SKTexture(imageNamed: "Pause1")
        super.init(texture: texture, color: UIColor.clearColor(), size: texture.size())
        self.position = CGPointMake(newX, newY)
        self.zPosition = 1
        self.name = "pause"
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
