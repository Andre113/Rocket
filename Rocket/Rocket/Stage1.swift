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
    var arrayBox: [SKSpriteNode] = []
    var arrayPos: [CGPoint] = []
    var arrayLabels: [SKLabelNode] = []
    var arrayNumbers: [Int] = []
    var arrayAnswers: [Int] = []
    var lifes = 2
    let pauseBtn  = SKSpriteNode(imageNamed: "Pause1")
    let bg  = SKSpriteNode(imageNamed: "woodwall.jpg")
    let equations = Equations.sharedInstance
    let rightBoxSound = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("rightBox", ofType: "mp3")!)!
    let wrongBoxSound = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("wrongBox", ofType: "mp3")!)!
    let priority = DISPATCH_QUEUE_PRIORITY_DEFAULT
    let timer = Timer(time:10)

//    MARK: DidMoveToView
    override func didMoveToView(view: SKView) {
        self.scaleMode = .AspectFill
        self.view?.userInteractionEnabled = true
        
//        self.createTileLabels()
//        self.createBG()
//        self.createPause()
//        self.createLifes()
//        self.createRule()
//        
//        
//        self.createBox()
//        self.createLabels()
//        self.createPositions()
//        
//        for index in 0...11{
//            arrayBox[index].position = arrayPos[index]
//            arrayLabels[index].position = CGPoint(x: arrayPos[index].x , y: arrayPos[index].y  - 25)
//            
//            addChild(arrayBox[index])
//            addChild(arrayLabels[index])
//        }

        
        //bloco assincrono para carregar paralelamente os conteúdos da view e outro para criar as box, labels e as posições
       
        dispatch_async(dispatch_get_global_queue(priority, 0), {
            ()-> () in
            self.createRule()
            self.createTileLabels()
            self.createBox()
            self.createLabels()
            self.createPositions()
            self.setPositions()
            
            dispatch_async(dispatch_get_main_queue(), {
                self.createTimer()
                self.createBG()
                self.createLifes()
                self.createPause()
            })
        })
        
        
        self.view?.multipleTouchEnabled = false
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "loseAction", name: "TimeOverIdentifier", object: nil)
    }
    
//    MARK:  Create
    //ViewConfig
    
    func setPositions(){
        for index in 0...11{
            self.arrayBox[index].position = self.arrayPos[index]
            self.arrayLabels[index].position = CGPoint(x: self.arrayPos[index].x , y: self.arrayPos[index].y  - 25)
            
            self.addChild(self.arrayBox[index])
            self.addChild(self.arrayLabels[index])
        }
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
    
    func createBG(){
        bg.position = CGPointMake(self.size.width/2, self.size.height/2)
        bg.size = size
        addChild(bg)
    }
    
    func createPause(){
        pauseBtn.position = CGPointMake(size.width * 0.3,size.height * 0.08 )
        pauseBtn.zPosition = 3
        addChild(pauseBtn)
    }
    
    func createBox(){
        for number in arrayNumbers{
            let box = SKSpriteNode(imageNamed: "box")
            box.name = "box.\(number)"
            box.zPosition = 4
            self.arrayBox.append(box)
        }
    }
    
    func createLifes(){
        var incX: CGFloat = 0.68
        let newY = size.height * 0.05
        for index in 0...2{
            let newX = size.width * incX
            let life = Life(name: "life\(index)", newX: newX, newY: newY)
            arrayLifes.append(life)
            incX += 0.03
            
            addChild(life)
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
    
    func createLabels(){
        for number in arrayNumbers{
            let newLabel = SKLabelNode(text: "\(number)")
            newLabel.fontName = "Chalkduster"
            newLabel.fontSize = 30
            newLabel.fontColor = UIColor.whiteColor()
            newLabel.name = "label.\(number)"
            newLabel.zPosition = 5
            
            self.arrayLabels.append(newLabel)
        }
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
        
        println(clicked.name)
        if (clicked.name != "" && clicked.name != nil){
            let fullName = clicked.name?.componentsSeparatedByString(".")
            let name: String? = fullName?.last
            self.checkRight(name!)
        }
    }
    
    //Checa se a caixa está correta
    func checkRight(name: String){
        var isRight = false
        for number in arrayAnswers{
            if (name == "\(number)"){
                isRight = true
            }
        }
        self.view?.userInteractionEnabled = false
        self.makeSoundAnswer(isRight)
        self.animateBoxes(name, isRight: isRight)
    }
    
//    MARK: Animation
    func animateBoxes(name: String, isRight: Bool){
        let boxToMove = self.childNodeWithName("box.\(name)")!
        let labelToMove = self.childNodeWithName("label.\(name)")!
        
        let saved = getAnswerIndex(name)
        
        if(isRight){
            arrayAnswers.removeAtIndex(saved)
            animateRight(boxToMove, label: labelToMove)
        }else{
            animateWrong(boxToMove, label: labelToMove)
        }
    }
    
    func animateRight(box: SKNode, label: SKNode){
        let action1 = SKAction.fadeOutWithDuration(0.5)
        let action2 = SKAction.removeFromParent()
        
        box.runAction(SKAction.sequence([action1, action2]))
        label.runAction(SKAction.sequence([action1, action2]), completion:{
            self.view?.userInteractionEnabled = true
        })
        
        if(arrayAnswers.isEmpty){
            self.winAction()
        }
    }
    
    func animateWrong(box: SKNode, label: SKNode){
        removeLife()
        
        let action1 = SKAction.moveByX(4.0, y: 0.0, duration: 0.025)
        let action2 = SKAction.moveByX(-8.0, y: 0.0, duration: 0.04)
        let action3 = SKAction.moveByX(4.0, y: 0.0, duration: 0.025)
        let action4 = SKAction.sequence([action1, action2, action3])
        let action5 = SKAction.repeatAction(action4, count: 5)
        
        box.runAction(action5)
        label.runAction(action5, completion:{
            self.view?.userInteractionEnabled = true
        })
        
        if(arrayLifes.isEmpty){
            label.runAction(action5, completion:{
                self.timer.timer?.invalidate()
                self.loseAction()
            })
        }
    }
    
//    MARK: WIN or Lose
    func winAction(){
        //Ação quando o cara ganhar
        println("Win")
    }
    
    func loseAction(){
        self.view?.userInteractionEnabled = false
        let fadeOut = SKTransition.fadeWithColor(UIColor.blackColor(), duration: 2.0)
        NSNotificationCenter.defaultCenter().removeObserver(self, name: "TimeOverIdentifier", object: nil)

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
    
    func getAnswerIndex(name: String) ->Int{
        var saved = -1
        var i = 0
        
        for i = 0; i<arrayAnswers.count && saved == -1; i+=1{
            if("\(arrayAnswers[i])" == name){
                saved = i
            }
        }
        return saved
    }
    
    func removeLife(){
        arrayLifes.removeAtIndex(lifes)
        removeNodeWithName("life\(lifes)")
        lifes--
    }
    
    func removeNodeWithName(name: String){
        self.childNodeWithName(name)?.removeFromParent()
    }
}
