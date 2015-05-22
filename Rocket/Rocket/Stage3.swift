//
//  Stage3.swift
//  Rocket
//
//  Created by Andre Lucas Ota on 19/05/15.
//  Copyright (c) 2015 Andre Lucas Ota. All rights reserved.
//

import SpriteKit

class Stage3: SKScene{
//    MARK: Variables
    let equations = Equations.sharedInstance
    var rocket = SKSpriteNode(imageNamed: "rocketStage3")
    var arrayLifes: [Life] = []
    var fireBoost = SKSpriteNode(imageNamed:"fireBoost")
    var arrayChoices: [SKLabelNode] = []
    var arrayQuestions: [Question] = []
    var questionLabel: SKLabelNode = SKLabelNode()
    var bgScene = SKSpriteNode(imageNamed:"bgStage3.jpg" )
    var count = 0
    var toggleFire = Bool()
    
    override func didMoveToView(view: SKView) {
        self.createLifes()
        self.createNodes()
        self.createQuestions()
        self.createQuestionLabel()
        self.createChoices()
//        self.movingScene()
        NSTimer.scheduledTimerWithTimeInterval(0.4, target: self, selector: Selector("changeTexture"), userInfo: nil, repeats: true)
    }
    
//    MARK: Create
//    func configureView(){
    
//        
//    }
    
// MARK: Change fireboost texture
    
    //troca textura do fogo do foguete
    func changeTexture(){
     
        if(toggleFire == true){
            fireBoost.texture = SKTexture(imageNamed:"fireBoost1")
            toggleFire = false
        }else{
            fireBoost.texture = SKTexture(imageNamed:"fireBoost2" )
            toggleFire = true
        }
    }
    
//    func movingScene(){
//        var ff: Float = Float(bgScene.position.y)
//        var zz:Int = Int(ff)
//        
//        
//        for i in zz...zz * 2{
//            bgScene.position.y = CGFloat(i)
//        }
//            
//        
//    }
    
    //Cria vidas
    func createLifes(){
        var incX: CGFloat = 0.68
        let newY = size.height * 0.05
        var newName = 0
        for index in 0...2{
            let newX = size.width * incX
            let life = Life(name: "\(newName)", newX: newX, newY: newY)
            arrayLifes.append(life)
            incX += 0.03
            newName++
            
            addChild(life)
        }
    }
    
//    MARK: Create Questions
    //Cria o array de objetos questões (equações)
    func createQuestions(){
        for index in 0...7{
//            Sortear entre equation 1 e 2
            var newData = equations.equationTypeOne()
            var newQuestion = Question(equation: newData.equation, answer: newData.answer)
            
            for question in arrayQuestions{
                while (newQuestion.equation == question.equation){
                    var newQuestion = Question(equation: newData.equation, answer: newData.answer)
                }
            }
            
            arrayQuestions.append(newQuestion)
        }
    }
    
    
//  MARK: Create Nodes 
    //Cria nodes da scene
    
    func createNodes(){
        bgScene.size = CGSize(width: 580, height:800)
//        bgScene.size = self.size
        bgScene.position = CGPointMake(self.size.width/2, self.size.height/2)
        addChild(bgScene)
        
        rocket.position = CGPoint(x: self.size.width / 2, y: self.size.height * 0.8)
        rocket.zPosition = 1
        addChild(rocket)
        
        fireBoost.position = CGPoint(x: self.size.width / 2, y: self.size.height * 0.7050)
        fireBoost.zPosition = 4
        fireBoost.size = CGSize(width: 50, height: 50)
        addChild(fireBoost)
    }
    
    //Cria label da questão
    func createQuestionLabel(){
        questionLabel = SKLabelNode(text: arrayQuestions[0].equation)
        questionLabel.name = "Question"
        addChild(questionLabel)
    }
    
//    MARK: Create Choices
    //Cria alternativas
    func createChoices(){
        self.createRightChoice()
        self.createWrongChoices()
        self.randomChoices()
        
        for choice in arrayChoices{
            addChild(choice)
        }
    }
    
    //Cria alternativa correta
    func createRightChoice(){
        //Alternativa correta (não sorteada)
        let rightAnswer = self.arrayQuestions[0].answer
        let rightChoice = self.createChoice(rightAnswer)
        
        //Append no arrayChoices, que é um array de Labels
        arrayChoices.append(rightChoice)
    }
    
    //Cria alternativas incorretas
    func createWrongChoices(){
        //Randomiza 3 alternativas erradas
        for index in 0...2{
            var newAnswer = equations.randomNumberGenerator()
            
            //Compara para garantir que todas as alternativas são diferentes
            for choice in arrayChoices{
                while ("\(newAnswer)" == choice.name){
                    newAnswer = equations.randomNumberGenerator()
                }
            }
            
            let newChoice = self.createChoice(newAnswer)
            arrayChoices.append(newChoice)
        }
    }
    
    //Randomiza as alternativas
    func randomChoices(){
        var auxArray = NSMutableArray(array: arrayChoices)
        var randomizedArray = [SKLabelNode]()
        var randomIndex:Int
        while auxArray.count > 0 {
            randomIndex = Int(arc4random_uniform(UInt32(auxArray.count)))
            randomizedArray.append(auxArray.objectAtIndex(randomIndex) as! SKLabelNode)
            auxArray.removeObjectAtIndex(randomIndex)
        }
        
        arrayChoices = randomizedArray as [SKLabelNode]
    }
    
    //Cria label de alternativas
    func createChoice(newAnswer: Int) -> SKLabelNode{
        var newChoice = SKLabelNode(text: "\(newAnswer)")
        newChoice.name = "\(newAnswer)"
        newChoice.fontName = "Chalkduster"
        newChoice.fontSize = 20
        newChoice.fontColor = UIColor.whiteColor()
        
        return newChoice
    }
    
//    MARK: NextQuestion
    //Cria próxima questão e alternativas
    func nextQuestion(){
        self.createQuestionLabel()
        self.arrayChoices.removeAll(keepCapacity: false)
        self.createChoices()
    }
    
//    MARK: Touches
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        /* Called when a touch begins */
        
        let touch = touches.first as! UITouch
        let location = touch.locationInNode(self)
        let clicked = self.nodeAtPoint(location)
        let clickName = clicked.name
        var isRight = false
        
        //Se clicar em uma alternativa
        if (clickName != "" && clickName != nil && clickName != "Question"){
            self.checkRight(clickName!)
        }
    }
    
    //Checa se a alternativa está correta
    func checkRight(name: String){
        let intToCompare = arrayQuestions[0].answer
        self.arrayQuestions.removeAtIndex(0)
        self.removeQuestion()
        self.removeChoices()
        
        if (name == "\(intToCompare)"){
            count++
            if(count == 5){
                self.winAction()
            }
            else{
                self.nextQuestion()
            }
        }
        else{
            self.arrayLifes.removeLast()
            if(self.arrayLifes.isEmpty){
                self.loseAction()
            }
            else{
                self.nextQuestion()
            }
        }
    }
    
//    MARK: Other
    func removeQuestion(){
        self.removeNodeWithName("Question")
    }
    
    func removeChoices(){
        for choice in arrayChoices{
            self.removeNodeWithName(choice.name!)
        }
    }
    
    func removeNodeWithName(name: String){
        self.childNodeWithName(name)?.removeFromParent()
    }
    
//    MARK: Win or Lose
    func winAction(){
        //Ação de ganhar
    }
    
    func loseAction(){
        let fadeOut = SKTransition.fadeWithColor(UIColor.blackColor(), duration: 3.0)
        
        let reveal = SKTransition.doorsCloseHorizontalWithDuration(1.5)
        let resetScene = Stage3(size: self.size)
        
        self.view?.presentScene(resetScene, transition: fadeOut)
    }
}
