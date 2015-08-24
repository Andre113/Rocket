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
    var contSize = CGSize()
    override init(){
        super.init()
    }
    
    //chama a new scene
    func stageSelection(){
        skView.userInteractionEnabled = false
        
        let newScene = StageSelection(size:   CGSizeMake(1024, 768))
        
        showScene(newScene)
    }
    
    //repete a scene de acordo com qual está rodando
    func newStage(number: Int){
        self.skView.userInteractionEnabled = false
        var resetScene = SKScene()
        var flag = true
        
        switch number{
            
        case 0:
            skView.userInteractionEnabled = true

            resetScene = Introduction(size:  CGSizeMake(1024, 768))
            contSize = skView.scene!.size
            break
        case 1:
            resetScene = Stage1(size:CGSizeMake(1024, 768))
            break
        case 2:
            resetScene = Stage2(size: CGSizeMake(1000
                , 770
                )
)
            break
        case 3:
            resetScene = Stage3(size: CGSizeMake(799, 715)
)
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
        
        skView.scene?.removeFromParent()
        skView.presentScene(newScene, transition: fadeOut)
    }
}
