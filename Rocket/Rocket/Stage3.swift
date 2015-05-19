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
    
    override func didMoveToView(view: SKView) {
        self.createLifes()
        self.createQuestions()
    }
    
//    MARK: Create
    func configureView(){
        
    }
    
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
    
    func createQuestions(){
        for index in 0...4{
//            Sortear entre 1 e 2
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
    
    func createQuestionLabel(){
        questionLabel = SKLabelNode(text: arrayQuestions[0].equation)
        addChild(questionLabel)
    }
    
    func createChoices(){
        //Alternativa correta (não sorteada)
        let rightAnswer = self.arrayQuestions[0].answer
        let rightChoice = self.createChoice(rightAnswer)
        
        //Append no arrayChoices, que é um array de Labels
        arrayChoices.append(rightChoice)
        
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
    
    func randomChoices(){
        
    }
    
    func createChoice(newAnswer: Int) -> SKLabelNode{
        var newChoice = SKLabelNode(text: "\(newAnswer)")
        newChoice.name = "\(newAnswer)"
        newChoice.fontName = "Chalkduster"
        newChoice.fontSize = 20
        newChoice.fontColor = UIColor.whiteColor()
        
        return newChoice
    }
    
//    MARK: Touches
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        /* Called when a touch begins */
        
        let touch = touches.first as! UITouch
        let location = touch.locationInNode(self)
        let clicked = self.nodeAtPoint(location)
        var isRight = false
        
        if (clicked.name != "" && clicked.name != nil){
            if (clicked.name == arrayQuestions[0]){
                //Açao de acertar
            }
            else{
                //Açao de errar
            }
            self.view?.userInteractionEnabled = false
        }
        println(clicked.name)
    }
}
