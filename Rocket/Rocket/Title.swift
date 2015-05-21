//
//  Title.swift
//  Rocket
//
//  Created by Andre Lucas Ota on 21/05/15.
//  Copyright (c) 2015 Andre Lucas Ota. All rights reserved.
//

import SpriteKit

class Title: SKLabelNode {
    
    
    init(text:String, pos:CGPoint, fntSize: CGFloat) {
        super.init()
        self.text = text
        self.position = pos
        self.fontName = "Chalkduster"
        self.fontColor = UIColor.whiteColor()
        self.zPosition = 1
        self.fontSize = fntSize
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

