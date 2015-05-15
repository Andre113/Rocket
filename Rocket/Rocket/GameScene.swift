//
//  GameScene.swift
//  Rocket
//
//  Created by Andre Lucas Ota on 14/05/15.
//  Copyright (c) 2015 Andre Lucas Ota. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
    
    var titleLabel1 = SKLabelNode(text:"Marque as caixas" )
    var titleLabel2 = SKLabelNode()
    var arrayBox: [SKSpriteNode] = []
    var arrayPos: [CGPoint] = []
    var arrayLabels: [SKLabelNode] = []
    var arrayNumbers: [Int] = []
    var arrayAnswers: [Int] = []
    var pauseBtn  = SKSpriteNode(imageNamed: "Pause1")
    var bg  = SKSpriteNode(imageNamed: "woodwall.jpg")
    let equations = Equations.sharedInstance
//    
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        
        titleLabel1.fontName = "Chalkduster"
        titleLabel1.fontSize = 20
        titleLabel1.position = CGPoint(x:CGRectGetMidX(self.frame), y:CGRectGetMaxY(self.frame) - 35);
        titleLabel1.zPosition = 2
        addChild(titleLabel1)
        
        titleLabel2.fontName = "Chalkduster"
        titleLabel2.fontSize = 20
        titleLabel2.position = CGPoint(x:CGRectGetMidX(self.frame), y:CGRectGetMaxY(self.frame) - 55);
        titleLabel2.zPosition = 3
        self.createRule()
        addChild(titleLabel2)
        
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
        
        self.randomArray()
        
        self.createBox()
        self.createPositions()
        
        var cont = 0
        for box in self.arrayBox{
            box.position = self.arrayPos[cont]
            cont++
            addChild(box)
        }
        
//        self.createNumbers()
        
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
    
//    func createNumbers(){
//        
//            var newLabel = SKLabelNode(text: "\(index)")
//            newLabel.fontName = "Chalkduster"
//            newLabel.fontSize = 30
//            newLabel.fontColor = UIColor.whiteColor()
//            newLabel.name = self.arrayBox[index].name
//            newLabel.position = self.arrayPos[index]
//            newLabel.position.y = newLabel.position.y - 23
//            newLabel.zPosition = 5
//            
//            self.arrayNumbers.append(newLabel)
//            
//            addChild(newLabel)
//    }
//    
    
    func createRule(){
        let rule = self.equations.allDividers()
        let arrayToCompare = rule.arrayToCompare
        arrayAnswers = rule.newArray
        let key = rule.newNumber
        var isValid: Bool
        self.titleLabel2.text = "que sao divisores de \(key)"
        arrayNumbers = arrayAnswers
        
        for index in 0...7{
            var numberToInsert: Int
            do{
                isValid = true
                numberToInsert = self.equations.randomNumberGenerator()
                
                for number in arrayNumbers{
                    if numberToInsert == number{
                        isValid = false
                    }
                }
                
                if(isValid){
                    for number in arrayToCompare{
                        if(number == numberToInsert){
                            isValid = false
                        }
                    }
                }
            } while (!isValid)
            arrayNumbers.append(numberToInsert)
        }
        println(arrayNumbers)
    }
    
//    MARK: Random
    func randomArray(){
        //Randomizar o array de números
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
        
        for label in arrayLabels{
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
        }else{
            let action1 = SKAction.moveByX(4.0, y: 0.0, duration: 0.025)
            let action2 = SKAction.moveByX(-8.0, y: 0.0, duration: 0.04)
            let action3 = SKAction.moveByX(4.0, y: 0.0, duration: 0.025)
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
