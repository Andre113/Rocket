//
//  GameScene.swift
//  Rocket
//
//  Created by Andre Lucas Ota on 14/05/15.
//  Copyright (c) 2015 Andre Lucas Ota. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
    
//    MARK: Variáveis
    var arrayBox: [SKSpriteNode] = []
    var arrayPos: [CGPoint] = []
    var nodes = SKNode()
//    var arrayNumbers: [SKLabelNode] = []
    var pauseBtn  = SKSpriteNode(imageNamed: "Pause1")
    var bg  = SKSpriteNode(imageNamed: "woodwall.jpg")
    
    
    override func didMoveToView(view: SKView) {
        
        pauseBtn.position = CGPointMake(size.width * 0.3,size.height * 0.08 )
        pauseBtn.zPosition = 3
        addChild(pauseBtn)
        
        bg.position = CGPointMake(self.size.width/2, self.size.height/2)
        bg.size = size
        addChild(bg)
        
        self.createBox()
        self.createPositions()
        
        var cont = 0
        for box in self.arrayBox{
            box.position = self.arrayPos[cont]
            cont++
            addChild(box)
        }
        
        self.createNumbers()
        
        self.view?.multipleTouchEnabled = false
    }
    
//    MARK:  Create
    func createBox(){
        for index in 0...11{
            let box = SKSpriteNode(imageNamed: "box")
            box.name = "\(index)"
            self.arrayBox.append(box)
        }
    }
    
    func createPositions(){
        var arrayX: [CGFloat] = []
        var arrayY: [CGFloat] = []
        var ammountX: CGFloat = 0.35
        var ammountY: CGFloat = 0.2
        
        for index in 0...2{
            let newX = (size.width ) * ammountX
            arrayX.append(newX)
            ammountX += 0.15
        }
        
        for index in 0...3{
            let newY = size.height * ammountY
            arrayY.append(newY)
            ammountY += 0.2
        }
        
        for i in 0...2{
            for j in 0...3{
                let newPos = CGPointMake(arrayX[i] , arrayY[j])
                self.arrayPos.append(newPos)
            }
        }
    }
    
    func createNumbers(){
        for index in 0...11{
            var newLabel = SKLabelNode(text: "\(index)")
            newLabel.fontName = "Chalkduster"
            newLabel.fontSize = 30
            newLabel.fontColor = UIColor.whiteColor()
            newLabel.name = self.arrayBox[index].name
            newLabel.position = self.arrayPos[index]
            newLabel.position.y = newLabel.position.y - 23
            newLabel.zPosition = 5
            addChild(newLabel)
        }
    }
    
//    MARK: Touches
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        /* Called when a touch begins */
        
        for touch in (touches as! Set<UITouch>) {
            let location = touch.locationInNode(self)
            
            nodes = self.nodeAtPoint(location)
            
            println(nodes.name)
        }
    }
    
//    MARK: Update
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
}
