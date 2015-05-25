//
//  Route.swift
//  Rocket
//
//  Created by Andre Lucas Ota on 18/05/15.
//  Copyright (c) 2015 Andre Lucas Ota. All rights reserved.
//

import SpriteKit

func getImage(imgName: String) -> UIImage{
    let imageToSet = UIImage(contentsOfFile: (NSBundle .mainBundle()) .pathForResource(imgName, ofType: nil)!)!
    return imageToSet
}

class Route: SKSpriteNode{
    var deltaTime: Int = 0
    var deltaDistance: Int = 0
    var deltaSpeed: Int = 0
    
    init(bgImage: String, deltaTime: Int, deltaDistance: Int, deltaSpeed: Int){
        let bg = UIImage(named: bgImage)
        let texture = SKTexture(image: bg!)
        
        super.init(texture: texture, color: UIColor.clearColor(), size: CGSizeMake(450, 180))
        
        self.deltaTime = deltaTime
        self.deltaDistance = deltaDistance
        self.deltaSpeed = deltaSpeed
        self.name = "Route"
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
