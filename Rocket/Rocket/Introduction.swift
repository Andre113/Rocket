//
//  Introduction.swift
//  Rocket
//
//  Created by Andre Lucas Ota on 22/05/15.
//  Copyright (c) 2015 Andre Lucas Ota. All rights reserved.
//
import SpriteKit
import CoreData

class Introduction: SKScene{
    let startLabel = SKLabelNode(text: "INICIAR CONTAGEM REGRESSIVA")
    var cont = 1
    var char = SKSpriteNode(imageNamed: "astronaut1")
    var up = true
    var timerCloud: NSTimer?
    var timerAstronaut: NSTimer?
    let managedObjectContext =
    (UIApplication.sharedApplication().delegate
        as! AppDelegate).managedObjectContext
    
    var dataManager = Manager.sharedInstance
    var a = Equations.sharedInstance

    
    let redirect = Redirect.sharedInstance
    
    let manager = Manager.sharedInstance
  
    
    
    override func didMoveToView(view: SKView) {
        self.createBG()
        self.createTitle()
        self.createGround()
        self.createChar()
        self.createRocket()
        self.scaleMode = .AspectFill

        
        manager.dataBaseChecker()
        manager.allLevelStatuses()

        self.createStartLabel()
        
        println(self.view?.scene?.size)
        
        
        
//        dataManager.setLevelBool("level1", boolLevel: true)
//        dataManager.checkDataBase()
    }
    
    //    MARK: Create
    func createBG(){
        let bg1 = SKSpriteNode(imageNamed: "bgSky.png")
        bg1.position = CGPointMake(frame.midX, frame.midY)
        bg1.zPosition = 0
        addChild(bg1)
        self.beginMove()
    }
    
    func beginMove(){
        timerCloud = NSTimer.scheduledTimerWithTimeInterval(0.1, target: self, selector: Selector("movingScene"), userInfo: nil, repeats: false)
        timerAstronaut = NSTimer.scheduledTimerWithTimeInterval(0.07, target: self, selector: Selector("movingAstronaut"), userInfo: nil, repeats: true)
    }
    
    func createTitle(){
        let title = SKSpriteNode(imageNamed: "RocketTitle")
        title.name = "title"
        title.position = CGPointMake(frame.midX, 600)
        title.zPosition = 2
        title.size = CGSize(width: 600, height:300)
        
        addChild(title)
    }
    
    func createStartLabel(){
        startLabel.fontColor = UIColor.redColor()
        startLabel.fontName = "Chalkduster"
        startLabel.fontSize = 25
        startLabel.name = "start"
        startLabel.position = CGPointMake(frame.midX, 500)
        startLabel.zPosition = 2
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
    
    func createCloud(kind: Int, newY: CGFloat){
        let newCloud = SKSpriteNode(imageNamed: "nuvem\(kind).png")
        newCloud.position = CGPointMake(self.frame.maxX, newY)
        newCloud.zPosition = 1
        addChild(newCloud)
        
        moveCloud(newCloud)
    }
    
//    MARK: Update
    func updateStart(){
        let speed = 0.25
        let fadeIn = SKAction.fadeInWithDuration(speed)
        let fadeOut = SKAction.fadeOutWithDuration(speed)
        
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
    
    func movingScene(){
        let kind = Int(arc4random_uniform(2))
        let newY = random(min: self.frame.minY + 400, max: self.frame.maxY-120)
        println("Move")
        
        createCloud(kind, newY: newY)
        
        resetCloudTimer()
    }
    
    func moveCloud(cloud: SKSpriteNode){
        let action1 = SKAction.moveToX(frame.minX, duration: 9.0)
        cloud.runAction(action1, completion:{
            cloud.removeFromParent()
        })
    }
    
    func movingAstronaut(){
        if(up == true){
            var texture  = SKTexture(imageNamed: "astronaut\(cont)")
            cont++
            char.texture = texture
            if(cont == 5){
                up = false
            }
        }else{
            var texture  = SKTexture(imageNamed: "astronaut\(cont)")
            cont--
            char.texture = texture
            if(cont == 1){
                up = true
            }
        }
    }
    
    //    MARK: Touch
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        let touch = touches.first as! UITouch
        let location = touch.locationInNode(self)
        
        self.timerAstronaut?.invalidate()
        self.timerCloud?.invalidate()
        self.goToSelectionGame()
        
//        let clicked = nodeAtPoint(location)
        
//        if(clicked.name == "start"){
//            self.goToSelectionGame()
//        }
    }
    
//    MARK: Begin
    func goToSelectionGame(){
        redirect.stageSelection()
    }
//    func saveData(){
//            let entityDescription =
//            NSEntityDescription.entityForName("Levels",
//                inManagedObjectContext: managedObjectContext!)
//            
//        let lvl = Levels(entity: entityDescription!,
//                insertIntoManagedObjectContext: managedObjectContext)
//            
//            lvl.level1 = false
//            
//            var error: NSError?
//            
//            managedObjectContext?.save(&error)
//            
//            if let err = error {
////                status.text = err.localizedFailureReason
//            } else {
//             
//            }
//    
//
//    }
    func retrievingData(){
        let entityDescription =
        NSEntityDescription.entityForName("Levels",
            inManagedObjectContext: self.managedObjectContext!)
        
        let request = NSFetchRequest()
        request.entity = entityDescription
        
        
        var error: NSError?
        
        var objects = managedObjectContext?.executeFetchRequest(request,
            error: &error)
        
        if let results = objects {
            
            if results.count > 0 {
                let match = results[0] as! NSManagedObject
                
                var a: AnyObject? = match.valueForKey("level1")
                println(111)

                println(a)
              
            }
        }
    }
    
//    MARK: Other
    func resetCloudTimer(){
        timerCloud?.invalidate()
        let cloudDelay = Double(random(min: 1.5, max: 5.5))
        timerCloud = NSTimer.scheduledTimerWithTimeInterval(cloudDelay, target: self, selector: Selector("movingScene"), userInfo: nil, repeats: false)
    }
    
    func random() -> CGFloat {
        return CGFloat(Float(arc4random()) / 0xFFFFFFFF)
    }
    
    func random(#min: CGFloat, max: CGFloat) -> CGFloat {
        return random() * (max - min) + min
    }
}