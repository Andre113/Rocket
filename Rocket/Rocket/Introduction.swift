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
    
    override func didMoveToView(view: SKView) {
        self.createBG()
        self.createChar()
        self.createRocket()
        self.createStartLabel()
    }
    
//    MARK: Create
    func createBG(){
        let bg = SKSpriteNode(imageNamed: "")
        bg.zPosition = 0
    }
    
    func createStartLabel(){
        startLabel.fontColor = UIColor.redColor()
        startLabel.fontName = "Chalkduster"
        startLabel.fontSize = 20
        startLabel.name = "start"
        startLabel.position = CGPointMake(500, 500)
        startLabel.zPosition = 1
        addChild(startLabel)
        
        self.updateStart()
    }
    
    func createRocket(){
        
    }
    
    func createChar(){
        
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
        }
    }
    
//    MARK: Begin
    func beginGame(){
        
    }
}
