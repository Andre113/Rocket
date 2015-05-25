//
//  Introduction.swift
//  Rocket
//
//  Created by Andre Lucas Ota on 22/05/15.
//  Copyright (c) 2015 Andre Lucas Ota. All rights reserved.
//

import SpriteKit

class Introduction: SKScene{
    let startLabel = SKLabelNode(text: "INICIAR CONTAGEM REGRESSIVA")
    let bg = SKSpriteNode(imageNamed: "bgStage3.jpg")
    
    override func didMoveToView(view: SKView) {
        self.createBG()
        self.createTitle()
        self.createGround()
        self.createChar()
        self.createRocket()
        self.createStartLabel()
    }
    
//    MARK: Create
    func createBG(){
        bg.position = CGPointMake(frame.midX, frame.midY)
        bg.zPosition = 0
        addChild(bg)
    }
    
    func createTitle(){
        let title = SKSpriteNode(imageNamed: "")
        title.name = "title"
        title.position = CGPointMake(frame.midX, 600)
        title.zPosition = 1
    }
    
    func createStartLabel(){
        startLabel.fontColor = UIColor.redColor()
        startLabel.fontName = "Chalkduster"
        startLabel.fontSize = 25
        startLabel.name = "start"
        startLabel.position = CGPointMake(frame.midX, 560)
        startLabel.zPosition = 1
        addChild(startLabel)
        
        self.updateStart()
    }
    
    func createRocket(){
        let rocket = SKSpriteNode(imageNamed: "rocket")
        rocket.name = "rocket"
        rocket.position = CGPointMake(frame.midX-70, 270)
        rocket.size = CGSizeMake(180, 450)
        rocket.zPosition = 2
        addChild(rocket)
    }
    
    func createChar(){
        let char = SKSpriteNode(imageNamed: "astronaut")
        char.name = "char"
        char.position = CGPointMake(frame.midX+170, 110)
        char.size = CGSizeMake(120, 150)
        char.zPosition = 2
        addChild(char)
    }
    
    func createGround(){
        let ground = SKSpriteNode(imageNamed: "ground1")
        ground.name = "ground"
        ground.position = CGPointMake(frame.midX, 140)
        ground.size = CGSizeMake(frame.width, 300)
        ground.zPosition = 1
        addChild(ground)
    }
    
//    MARK: StartLabel
    func updateStart(){
        let fadeIn = SKAction.fadeInWithDuration(0.6)
        let fadeOut = SKAction.fadeOutWithDuration(0.6)
        let changeToRed = SKAction.runBlock{
            self.startLabel.fontColor = UIColor.redColor()
        }
        let changeToGreen = SKAction.runBlock{
            self.startLabel.fontColor = UIColor.greenColor()
        }
        let changeToBlue = SKAction.runBlock{
            self.startLabel.fontColor = UIColor.blueColor()
        }
        
        let runSequence = SKAction.sequence([fadeOut, changeToGreen, fadeIn, fadeOut, changeToBlue, fadeIn, fadeOut, changeToRed, fadeIn])
        
        let actionToRun = SKAction.repeatActionForever(runSequence)
        startLabel.runAction(actionToRun)
    }
    
//    MARK: Touch
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        let touch = touches.first as! UITouch
        let location = touch.locationInNode(self)
        let clicked = nodeAtPoint(location)
        
        if(clicked.name == "start"){
            self.beginGame()
        }
    }
    
//    MARK: Begin
    func beginGame(){
        
    }
}
