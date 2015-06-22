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
    var arrowsPath = [SKSpriteNode]()
    
    init(bgImage: String, deltaTime: Int, deltaDistance: Int, deltaSpeed: Int){
        let bg = UIImage(named: bgImage)
        let texture = SKTexture(image: bg!)
        
        super.init(texture: texture, color: UIColor.clearColor(), size: CGSizeMake(450 * 1.1, 180 ))
        
        self.deltaTime = deltaTime
        self.deltaDistance = deltaDistance
        self.deltaSpeed = deltaSpeed
        
        println("time: \(self.deltaTime)")
        println("distance: \(self.deltaDistance)")
        println("speed: \(self.deltaSpeed)")
        self.name = "Route"
        self.printMe()

        
    }
    
    func randomPath(){
        
    }
    
    func printMe(){
        
        var arrow_x = CGFloat()
        var arrow_y = CGFloat()
        arrow_x = -100
        arrow_y = 0
        var count = 0

        
        for index in 0...8{
           var arrow = SKSpriteNode(imageNamed: "arrow.png")
            arrow.size = CGSize(width: 25, height:25 )
            if(arrowsPath.isEmpty){
                arrow.position = CGPoint(x:arrow_x , y:self.randomY(self.frame.midY) )
            }else{
                arrow.position = CGPoint(x:arrow_x , y:self.randomY(self.arrowsPath[count].position.y) )
                count++

            }
            arrow_x = arrow_x + 30
    
            arrowsPath.append(arrow)
            self.addChild(arrow)
//            println(self.frame.midY)
        }
        
    
        
        
    }
    
    func randomY(y:CGFloat)->CGFloat{
        
        var newY = CGFloat()
        
        if(y % 2 == 0){
            
             newY = y + (CGFloat( arc4random_uniform(15)))
        
        }else{
            
             newY = y - (CGFloat( arc4random_uniform(15)))

        }
        
        return newY
    
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func setInfoLabels() {
        var deltaTimeLabel = SKLabelNode(text: "?")
        
        var deltaDistanceLabel = SKLabelNode(text: "∆S: \(deltaDistance) m")
        //        deltaDistanceLabel.position = CGPointMake(self.frame.midX * 1.2, self.frame.maxY * 0.7)
        deltaDistanceLabel.position = CGPointMake(self.frame.minX * 0.4, self.frame.maxY * 0.69)

        
        var deltaSpeedLabel = SKLabelNode(text: "∆V: \(deltaSpeed) m/s")
//        deltaSpeedLabel.position = CGPointMake(self.frame.midX * 1.2, self.frame.minY * 0.9)
                deltaSpeedLabel.position = CGPointMake(self.frame.maxX * 0.5, self.frame.minY * 0.85)

        self.addChild(deltaDistanceLabel)
        self.addChild(deltaSpeedLabel)
    }
}
