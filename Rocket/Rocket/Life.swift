//
//  Life.swift
//  Rocket
//
//  Created by Andre Lucas Ota on 20/05/15.
//  Copyright (c) 2015 Andre Lucas Ota. All rights reserved.
//

import SpriteKit

func getImage(imgName: String) -> UIImage{
    let imageToSet = UIImage(contentsOfFile: (NSBundle .mainBundle()) .pathForResource(imgName, ofType: nil)!)!
    return imageToSet
}

class Life: SKSpriteNode{
    init(name: String, newX: CGFloat, newY: CGFloat){
        let img = UIImage(named: "rocket5")
        let texture = SKTexture(image: img!)
        
        super.init(texture: texture, color: UIColor.clearColor(), size: texture.size())
        self.name = name
        self.position = CGPointMake(newX, newY)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
