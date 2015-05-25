//
//  Stage1.swift
//  Rocket
//
//  Created by Andre Lucas Ota on 14/05/15.
//  Copyright (c) 2015 Andre Lucas Ota. All rights reserved.
//

import SpriteKit
import AVFoundation

class Stage1: SKScene {
//    MARK: Variables
    var audioPlayer = AVAudioPlayer()
    var arrayLifes:[Life] = []
    var key = 0
    var arrayNumbers: [Int] = []
    var arrayAnswers: [Int] = []
    var lifes = 2
    let equations = Equations.sharedInstance
    let rightBoxSound = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("rightBox", ofType: "mp3")!)!
    let wrongBoxSound = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("wrongBox", ofType: "mp3")!)!
    let priority = DISPATCH_QUEUE_PRIORITY_DEFAULT
    let timer = Timer(time:10)

//    MARK: DidMoveToView
    override func didMoveToView(view: SKView) {
        self.viewConfig()
        self.createRule()
        self.createTileLabels()
        self.createBG()
        self.createLifes()
        self.createBoxes()
        self.createTimer()
        self.createPause()
        
        //bloco assincrono para carregar paralelamente os conteúdos da view e outro para criar as box, labels e as posições
       
//        dispatch_async(dispatch_get_global_queue(priority, 0), {
//            ()-> () in
//            self.createRule()
//            self.createTileLabels()
//            self.createBox()
//            self.createLabels()
//            self.createPositions()
//            self.setPositions()
//            
//            dispatch_async(dispatch_get_main_queue(), {
//                self.createTimer()
//                self.createBG()
//                self.createLifes()
//                self.createPause()
//            })
//        })
    }
    
//    MARK:  Create
    func viewConfig(){
        self.scaleMode = .AspectFill
        self.view?.userInteractionEnabled = true
        self.view?.multipleTouchEnabled = false
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "loseAction", name: "TimeOverIdentifier", object: nil)
    }
    
    func createBG(){
        let bg  = SKSpriteNode(imageNamed: "woodwall.jpg")
        bg.position = CGPointMake(self.size.width/2, self.size.height/2)
        bg.size = size
        bg.zPosition = 0
        addChild(bg)
    }
    
    func createTimer() {
        self.timer.position = CGPoint(x: self.frame.midX, y: self.frame.midY)
        self.timer.zPosition = 2
        self.timer.fontName = "Chalkduster"
        self.timer.fontSize = 20
        self.timer.fontColor = UIColor.whiteColor()
        self.addChild(self.timer)
    }
    
    func createTileLabels(){
        let pos1 = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMaxY(self.frame) - 35)
        let titleLabel1 = Title(text: "Marque as caixas cujos", pos: pos1, fntSize: 20)
        addChild(titleLabel1)
        
        let pos2 = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMaxY(self.frame) - 55)
        let titleLabel2 = Title(text: "Números são divisores de \(key)", pos: pos2, fntSize: 20)
        addChild(titleLabel2)
    }
    
    func createPause(){
        let pauseButton = PauseButton(newX: size.width * 0.3, newY: size.height * 0.035)
        pauseButton.zPosition = 1
        addChild(pauseButton)
    }
    
    func createLifes(){
        var incX: CGFloat = 0.68
        let newY = size.height * 0.05
        for index in 0...2{
            let newX = size.width * incX
            let life = Life(name: "life.\(index)", newX: newX, newY: newY)
            arrayLifes.append(life)
            incX += 0.03
            
            addChild(life)
        }
    }
    
    func createBoxes(){
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
        
        var index = 0
        for i in 0...2{
            for j in 0...3{
                let newPos = CGPointMake(arrayX[i] , arrayY[j])
                let newNumber = arrayNumbers[index]
                createBox(newNumber, pos: newPos)
                index++
            }
        }
    }
    
    func createBox(number: Int, pos: CGPoint){
        println("box")
        let box = Box(number: number, pos: pos)
        self.addChild(box)
    }
    
    //Cria a regra
    func createRule(){
        //Objetos que irão compor a regra
        let rule = self.equations.allDividers()
        
        //Array de números para comparar
        let arrayToCompare = rule.arrayToCompare
        
        //Array de números certos
        arrayAnswers = rule.newArray
        
        //Adiciona números certos ao ArrayNumbers
        arrayNumbers = arrayAnswers
        
        //Número multiplo de todos
        self.key = rule.newNumber
        
        self.createNumbers(arrayToCompare)
    }
    
    //Cria valores aleatórios para o arrayNumbers
    func createNumbers(arrayToCompare: [Int]){
        var isValid: Bool
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
        
        self.randomArray()
    }
    
//    MARK: Touches
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        let touch = touches.first as! UITouch
        let location = touch.locationInNode(self)
        let clicked = self.nodeAtPoint(location)
        
        if(clicked.name != "" && clicked.name != nil){
            println(clicked.name)
            self.getClicked(clicked)
        }
    }
    
    func getClicked(clicked: SKNode){
        let name = clicked.name?.componentsSeparatedByString(".")
        let firstName = name!.first!
        
        switch firstName{
            case "box":
                self.checkRight(clicked as! Box)
                break
            case "pause":
                //pauseAction
                break
            default:
                break
        }
    }
    
    //Checa se a caixa está correta
    func checkRight(box: Box){
        var isRight = false
        var i = 0
        
        for i = 0; i<arrayAnswers.count && isRight == false; i+=1{
            if(arrayAnswers[i] == box.number){
                arrayAnswers.removeAtIndex(i)
                isRight = true
            }
        }
        self.view?.userInteractionEnabled = false
        self.makeSoundAnswer(isRight)
        self.animateBoxes(box, isRight: isRight)
    }
    
//    MARK: Animation
    func animateBoxes(box: Box, isRight: Bool){
        if(isRight){
            animateRight(box)
        }else{
            removeLife()
            animateWrong(box)
        }
    }
    
    func animateRight(box: Box){
        let action1 = SKAction.fadeOutWithDuration(0.5)
        let action2 = SKAction.removeFromParent()
        
        box.runAction(SKAction.sequence([action1, action2]), completion:{
            self.view?.userInteractionEnabled = true
        })
        
        if(arrayAnswers.isEmpty){
            self.winAction()
        }
    }
    
    func animateWrong(box: Box){
        
        let action1 = SKAction.moveByX(4.0, y: 0.0, duration: 0.025)
        let action2 = SKAction.moveByX(-8.0, y: 0.0, duration: 0.04)
        let action3 = SKAction.moveByX(4.0, y: 0.0, duration: 0.025)
        let action4 = SKAction.sequence([action1, action2, action3])
        let action5 = SKAction.repeatAction(action4, count: 5)
        
        box.runAction(action5, completion:{
            if(self.arrayLifes.isEmpty){
                    NSNotificationCenter.defaultCenter().postNotificationName("LifeEndIdentifier", object: nil)
                    NSNotificationCenter.defaultCenter().removeObserver(self, name: "LifeEndIdentifier", object: nil)
                    self.loseAction()
                }
            else{
                self.view?.userInteractionEnabled = true
            }
        })
    }
    
//    MARK: WIN or Lose
    func winAction(){
        //Ação quando o cara ganhar
        println("Win")
    }
    
    func loseAction(){
        self.view?.userInteractionEnabled = false
        
        if (!arrayLifes.isEmpty){
            removeLifes()
        }
        
        NSNotificationCenter.defaultCenter().removeObserver(self, name: "TimeOverIdentifier", object: nil)
        let fadeOut = SKTransition.fadeWithColor(UIColor.blackColor(), duration: 2.5)

        let resetScene = Stage1(size: self.size)
        
        self.view?.presentScene(resetScene, transition: fadeOut)
    }
    
//    MARK: Music
    func makeSoundAnswer(boxChosenBool:Bool){
        AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayback, error: nil)
        AVAudioSession.sharedInstance().setActive(true, error: nil)
        
        var error:NSError?
        
        if(boxChosenBool){
            audioPlayer = AVAudioPlayer(contentsOfURL: rightBoxSound, error: &error)
        }else{
            audioPlayer = AVAudioPlayer(contentsOfURL: wrongBoxSound, error: &error)
        }
        audioPlayer.prepareToPlay()
        audioPlayer.play()
    }
    
//    MARK: Other
    func randomArray(){
        var auxArray = NSMutableArray(array: arrayNumbers)
        var randomizedArray = [Int]()
        var randomIndex:Int
        while auxArray.count > 0 {
            randomIndex = Int(arc4random_uniform(UInt32(auxArray.count)))
            randomizedArray.append(auxArray.objectAtIndex(randomIndex) as! Int)
            auxArray.removeObjectAtIndex(randomIndex)
        }
        
        arrayNumbers = randomizedArray as [Int]
        println(arrayNumbers)
    }
    
    func removeLifes(){
        arrayLifes.removeAll(keepCapacity: false)
    }
    
    func removeLife(){
        arrayLifes.removeAtIndex(lifes)
        removeNodeWithName("life.\(lifes)")
        lifes--
    }
    
    func removeNodeWithName(name: String){
        self.childNodeWithName(name)?.removeFromParent()
    }
}
