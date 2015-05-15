//
//  GameScene.swift
//  Rocket
//
//  Created by Andre Lucas Ota on 14/05/15.
//  Copyright (c) 2015 Andre Lucas Ota. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
    
    var arrayBox: [SKSpriteNode] = []
    var arrayPos: [CGPoint] = []
    var arrayNumbers: [SKLabelNode] = []
    var pauseBtn  = SKSpriteNode(imageNamed: "Pause1")
    var bg  = SKSpriteNode(imageNamed: "woodwall.jpg")
    let equations = Equations.sharedInstance
//    
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        let myLabel = SKLabelNode(fontNamed:"Chalkduster")
        myLabel.text = String(equations.zeroToTwentyGenerator())
        myLabel.fontSize = 65;
        myLabel.position = CGPoint(x:CGRectGetMidX(self.frame), y:CGRectGetMidY(self.frame));
        
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
            
            self.arrayNumbers.append(newLabel)
            
            addChild(newLabel)
        }
    }
    
//    MARK: Touches
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        /* Called when a touch begins */
        
        let touch = touches.first as! UITouch
        let location = touch.locationInNode(self)
        let box = self.nodeAtPoint(location)
        
        if (box.name != "" && box.name != nil){
            let isRight = (box.name == "4")
            self.view?.userInteractionEnabled = false
            self.animateBoxes(box.name!, isRight: isRight)
        }
        println(box.name)
    }
    
//    MARK: Animation
    
    func animateBoxes(name: String, isRight: Bool){
        var boxToMove = SKNode()
        var labelToMove = SKLabelNode()
        
        for box in arrayBox{
            if (box.name == name){
                boxToMove = box
            }
        }
        
        for label in arrayNumbers{
            if (label.name == name){
                labelToMove = label
            }
        }
        
        if(isRight){
            let action1 = SKAction.fadeOutWithDuration(0.5)
            let action2 = SKAction.removeFromParent()
            
            boxToMove.runAction(SKAction.sequence([action1, action2]))
            labelToMove.runAction(SKAction.sequence([action1, action2]), completion:{
                self.view?.userInteractionEnabled = true
            })
        }
        else{
            let action1 = SKAction.moveByX(4.0, y: 0.0, duration: 0.008)
            let action2 = SKAction.moveByX(-8.0, y: 0.0, duration: 0.008)
            let action3 = SKAction.moveByX(4.0, y: 0.0, duration: 0.008)
            let action4 = SKAction.sequence([action1, action2, action3])
            let action5 = SKAction.repeatAction(action4, count: 5)
            
            boxToMove.runAction(action5)
            labelToMove.runAction(action5, completion:{
                self.view?.userInteractionEnabled = true
            })
        }
    }
    
//    MARK: Update
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
}
