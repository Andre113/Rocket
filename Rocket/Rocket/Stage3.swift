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
    var rocket = SKSpriteNode()
    var arrayLifes: [SKSpriteNode] = []
    var arrayChoices: [SKLabelNode] = []
    var arrayQuestions: [Question] = []
    var questionLabel: SKLabelNode = SKLabelNode()
    var count = 0
    
    override func didMoveToView(view: SKView) {
        self.createLifes()
        self.createQuestions()
        self.createQuestionLabel()
        self.createChoices()
    }
    
//    MARK: Create
    func configureView(){
        
    }
    
    //Cria vidas
    func createLifes(){
        var newX: CGFloat = 0.68
        for index in 0...2{
            let life = SKSpriteNode(imageNamed:"rocket5")
            life.position = CGPointMake(size.width * newX ,size.height * 0.05)
            newX += 0.03
            
            arrayLifes.append(life)
            addChild(life)
        }
    }
    
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
    
    //Cria label da questão
    func createQuestionLabel(){
        questionLabel = SKLabelNode(text: arrayQuestions[0].equation)
        questionLabel.name = "Question"
        addChild(questionLabel)
    }
    
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
    //Cria próxima escolha
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
        
    }
    
    func loseAction(){
        
    }
}
