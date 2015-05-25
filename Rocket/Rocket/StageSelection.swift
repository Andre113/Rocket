//
//  StageSelection.swift
//  Rocket
//
//  Created by Rafael  Hieda on 25/05/15.
//  Copyright (c) 2015 Andre Lucas Ota. All rights reserved.
//

import SpriteKit

class StageSelection: SKScene {
    
    var stageNodeArray:[StageNode] = []
    var title:SKLabelNode!
    let priority = DISPATCH_QUEUE_PRIORITY_DEFAULT


    override func  didMoveToView(view: SKView) {
        
//        dispatch_async(dispatch_get_global_queue(priority, 0), { () -> Void in
//            self.createStages()
//            self.stageSetPosition()
//            dispatch_async(dispatch_get_main_queue(), { () -> Void in
//                self.setBackground()
//                self.setTitle()
//            })
//        })

//rodando síncrono!
        self.setBackground()
        self.setTitle()
        self.createStages()
        self.stageSetPosition()
    }
    
    func createStages() {
        for index in 0 ... 9 {
            stageNodeArray.append(StageNode(texture: "planet", stageNumber: index+1))
            stageNodeArray[index].name = "stage\(index)"
        }
    }
    
    func stageSetPosition() {
        var ammountX: CGFloat = 0.2
        var ammountY: CGFloat = 0.7
        var index = 0
        for column in 0 ... 2 {
            for line in 0 ... 2 {
                ammountX += 0.15
                let newX = (size.width ) * ammountX
                let newY = size.height * ammountY
                stageNodeArray[index].setPosition(newX, y: newY)
                addChild(stageNodeArray[index])
                index++
            }
            ammountX = 0.2
            ammountY -= 0.25
        }
    }
        func setTitle() {
            title = SKLabelNode(text: "Selecione a fase desejada!")
            title.fontName = "Chalkduster"
            title.position = CGPointMake(self.frame.midX, self.frame.maxY * 0.85)
            title.color = UIColor.whiteColor()
            title.zPosition = 1
            self.addChild(title)
        }
        
        func setBackground() {
            let backgroundImage = SKSpriteNode(imageNamed: "testebg12")
            backgroundImage.position = CGPointMake(self.size.width/2, self.size.height/2)
            self.addChild(backgroundImage)
        }
    
    func playBackgroundTheme() {
        
    }
    
}