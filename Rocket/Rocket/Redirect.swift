//
//  Redirect.swift
//  Rocket
//
//  Created by Andre Lucas Ota on 25/05/15.
//  Copyright (c) 2015 Andre Lucas Ota. All rights reserved.
//

import SpriteKit

class Redirect: NSObject{
    static let sharedInstance = Redirect()
    var skView = SKView()
    
    override init(){
        super.init()
    }
    
    //chama a new scene
    func stageSelection(){
        skView.userInteractionEnabled = false
        
        let newScene = StageSelection(size: skView.scene!.size)
        
        showScene(newScene)
    }
    
    //repete a scene de acordo com qual está rodando
    func newStage(number: Int){
        self.skView.userInteractionEnabled = false
        var resetScene = SKScene()
        var flag = true
        
        switch number{
        case 1:
            resetScene = Stage1(size: skView.scene!.size)
            break
        case 2:
            resetScene = Stage2(size: skView.scene!.size)
            break
        case 3:
            resetScene = Stage3(size: skView.scene!.size)
            break
        default:
            self.skView.userInteractionEnabled = true
            flag = false
            break
        }
        
        if(flag){
            showScene(resetScene)
        }
    }
    
    func showScene(newScene: SKScene){
        let fadeOut = SKTransition.fadeWithColor(UIColor.blackColor(), duration: 2.5)
        
        skView.presentScene(newScene, transition: fadeOut)
    }
}
