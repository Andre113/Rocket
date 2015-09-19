//
//  StageSelection.swift
//  Rocket
//
//  Created by Rafael  Hieda on 25/05/15.
//  Copyright (c) 2015 Andre Lucas Ota. All rights reserved.
//

import SpriteKit
import AVFoundation

class StageSelection: SKScene {
    
    var stageNodeArray:[StageNode] = []
    var title:SKLabelNode!
    let priority = DISPATCH_QUEUE_PRIORITY_DEFAULT
    var redirect = Redirect.sharedInstance
    var manager = Manager.sharedInstance
    
    
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
        
        self.scaleMode = .AspectFill
        
        self.setBackground()
        self.setTitle()
        self.createStages()
        self.stageSetPosition()
        self.playMusicTheme("rightBox", type: "mp3", numberOfLoops: 4, volume: 0.4)
        self.backButtonSetup()
        self.view!.userInteractionEnabled = true
    }
    
    func createStages() {
        for index in 0 ... 2 {
            var stageArray = manager.allLevelStatuses()
            if stageArray[index] == true {
                stageNodeArray.append(StageNode(texture: "planet4", stageNumber: index+1))
            }
            else {
                stageNodeArray.append(StageNode(texture: "planet", stageNumber: index+1))
                
            }
            //            stageNodeArray.append(StageNode(texture: "planet", stageNumber: index+1))
            
        }
    }
    
    
    
    
    
    func stageSetPosition() {
        var ammountX: CGFloat = 0.1
        var ammountY: CGFloat = 0.7
        var yDesc: CGFloat = 540
        var index = 0
        
        
        for line in 1 ... 3 {
            
            ammountX += 0.20
            
            let desc1 = SKSpriteNode(imageNamed: "descRocket\(line)")
            desc1.position = CGPoint(x: (size.width) * (ammountX + 0.27), y: yDesc)
            desc1.size = CGSize(width: 420, height: 100)
            
            let newX = (size.width ) * ammountX
            let newY = size.height * ammountY
            stageNodeArray[index].setPosition(newX, y: newY)
            stageNodeArray[index].zPosition = 90
            desc1.zPosition = 10
            addChild(desc1)
            addChild(stageNodeArray[index])
            index++
            
            yDesc -= 190
            ammountX = 0.1
            ammountY -= 0.25
        }
    }
    func setTitle() {
        title = SKLabelNode(text: "Selecione a fase desejada!")
        title.fontName = "Chalkduster"
        title.fontSize = 34
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
    
    func musicThemeSetup(audioFile:String, type:String) ->AVAudioPlayer {
        let path = NSBundle.mainBundle().pathForResource(audioFile, ofType:type)
        let url = NSURL.fileURLWithPath(path!)
        var error:NSError?
        var backgroundMusic = AVAudioPlayer()
        var audioPlayer: AVAudioPlayer!
        do {
            audioPlayer = try AVAudioPlayer(contentsOfURL: url)
        } catch let error1 as NSError {
            error = error1
            audioPlayer = nil
        }
        
        return audioPlayer
    }
    
    func playMusicTheme(audioFile:String, type:String, numberOfLoops:Int, volume:Float) {
        let backgroundMusic = musicThemeSetup("rightBox", type: "mp3")
        backgroundMusic.volume = 0.3
        backgroundMusic.numberOfLoops = 10
        backgroundMusic.prepareToPlay()
        backgroundMusic.play()
        
    }
    
    func backButtonSetup() {
        let backButton = SKSpriteNode(imageNamed: "backButton")
        backButton.position = CGPointMake(self.frame.midX - 225, self.frame.minY + 40)
        backButton.zPosition = 2
        backButton.name = "backButton"
        self.addChild(backButton)
    }
    
    //    MARK: Touches
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        let touch = touches.first as UITouch!
        let location = touch.locationInNode(self)
        let clicked = self.nodeAtPoint(location)
        
        if clicked.name != nil && clicked.name != "" {
            self.switchAction(clicked)
        }
    }
    
    //    MARK: Switch Touch
    func switchAction(clicked: SKNode){
        print(clicked.name)
        if clicked.name == "backButton" {
            //back
            redirect.newStage(0)
            
        }
        else{
            let fullName = clicked.name?.componentsSeparatedByString(".")
            let number = Int((fullName?.last)!)
            
            redirect.newStage(number!)
        }
    }
    
    func stageNodeAnimation() {
        //implementar no futuro...
    }
}


