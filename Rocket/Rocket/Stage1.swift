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
    var arrayLifes = [SKSpriteNode]()
    var countHits = Int8() //contador de acertos
    let titleLabel1 = SKLabelNode(text:"Marque as caixas cujos" )
    var titleLabel2 = SKLabelNode()
    var arrayBox: [SKSpriteNode] = []
    var arrayPos: [CGPoint] = []
    var arrayLabels: [SKLabelNode] = []
    var arrayNumbers: [Int] = []
    var arrayAnswers: [Int] = []
    var lifeToRemove = 2
    let pauseBtn  = SKSpriteNode(imageNamed: "Pause1")
    let bg  = SKSpriteNode(imageNamed: "woodwall.jpg")
    let equations = Equations.sharedInstance
    let rightBoxSound = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("rightBox", ofType: "mp3")!)!
    let wrongBoxSound = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("wrongBox", ofType: "mp3")!)!

//    MARK: DidMoveToView
    override func didMoveToView(view: SKView) {
        self.scaleMode = .AspectFill
        self.view?.userInteractionEnabled = true
        
        self.createTileLabels()
        self.createBG()
        self.createPause()
        self.createLifes()
        self.createRule()
        
        self.createBox()
        self.createLabels()
        self.createPositions()
        
        for index in 0...11{
            arrayBox[index].position = arrayPos[index]
            arrayLabels[index].position = CGPoint(x: arrayPos[index].x , y: arrayPos[index].y  - 25)
            
            addChild(arrayBox[index])
            addChild(arrayLabels[index])
        }
        
        self.view?.multipleTouchEnabled = false
    }
    
//    MARK:  Create
    //ViewConfig
    func createTileLabels(){
        createTitleLabel(titleLabel1, newY: 35)
        createTitleLabel(titleLabel2, newY: 55)
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
    
    func createTitleLabel(titleLabel: SKLabelNode, newY: CGFloat){
        titleLabel.fontName = "Chalkduster"
        titleLabel.fontSize = 20
        titleLabel.position = CGPoint(x:CGRectGetMidX(self.frame), y:CGRectGetMaxY(self.frame) - newY);
        titleLabel.zPosition = 2
        addChild(titleLabel)
    }
    
    func createBox(){
        for number in arrayNumbers{
            let box = SKSpriteNode(imageNamed: "box")
            box.name = "\(number)"
            self.arrayBox.append(box)
        }
    }
    
    func createLifes(){
        var newX: CGFloat = 0.68
        var newName = 0
        for index in 0...2{
            let life = SKSpriteNode(imageNamed:"rocket5")
            life.name = "\(newName)"
            life.position = CGPointMake(size.width * newX ,size.height * 0.05)
            newX += 0.03
            newName++
            
            arrayLifes.append(life)
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
            var newLabel = SKLabelNode(text: "\(number)")
            newLabel.fontName = "Chalkduster"
            newLabel.fontSize = 30
            newLabel.fontColor = UIColor.whiteColor()
            newLabel.name = "\(number)"
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
        let key = rule.newNumber
        
        self.titleLabel2.text = "números sao divisores de \(key)"
        
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
        /* Called when a touch begins */
        
        let touch = touches.first as! UITouch
        let location = touch.locationInNode(self)
        let clicked = self.nodeAtPoint(location)
        
        if (clicked.name != "" && clicked.name != nil){
            self.checkRight(clicked.name!)
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
        self.animateBoxes(name, isRight: isRight)
    }
    
//    MARK: Animation
    func animateBoxes(name: String, isRight: Bool){
        var boxToMove = SKNode()
        var labelToMove = SKLabelNode()
        var saved = 0
        
        for index in 0...arrayBox.count-1{
            if (arrayBox[index].name == name){
                boxToMove = arrayBox[index]
                labelToMove = arrayLabels[index]
                saved = index
            }
        }
        
        self.makeSoundAnswer(isRight)
        
        if(isRight){
            let action1 = SKAction.fadeOutWithDuration(0.5)
            let action2 = SKAction.removeFromParent()
            
            boxToMove.runAction(SKAction.sequence([action1, action2]))
            labelToMove.runAction(SKAction.sequence([action1, action2]), completion:{
                self.view?.userInteractionEnabled = true
            })
            
            arrayBox.removeAtIndex(saved)
            arrayLabels.removeAtIndex(saved)
            
            countHits++
            
            if(countHits > 3){
                self.winAction()
            }
           
            
//            if(arrayBox.isEmpty){
//                self.winAction()
//            }
            
        }else{
            arrayLifes.removeLast()
            removeNodeWithName("\(lifeToRemove)")
            lifeToRemove--
            let action1 = SKAction.moveByX(4.0, y: 0.0, duration: 0.025)
            let action2 = SKAction.moveByX(-8.0, y: 0.0, duration: 0.04)
            let action3 = SKAction.moveByX(4.0, y: 0.0, duration: 0.025)
            let action4 = SKAction.sequence([action1, action2, action3])
            let action5 = SKAction.repeatAction(action4, count: 5)
            
            boxToMove.runAction(action5)
            labelToMove.runAction(action5, completion:{
                self.view?.userInteractionEnabled = true
            })
            
            if(arrayLifes.isEmpty){
                labelToMove.runAction(action5, completion:{
                    self.loseAction()
                })
            }
            
            
        }
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
    
//    MARK: WIN or Lose
    func winAction(){
        //Ação quando o cara ganhar
        println("Win")
    }
    
    func loseAction(){
        let fadeOut = SKTransition.fadeWithColor(UIColor.blackColor(), duration: 3.0)

        let reveal = SKTransition.doorsCloseHorizontalWithDuration(1.5)
        let resetScene = Stage1(size: self.size)
        
        self.view?.presentScene(resetScene, transition: fadeOut)
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
    
    func removeNodeWithName(name: String){
        self.childNodeWithName(name)?.removeFromParent()
    }
    
//    MARK: Update
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
}
