//
//  Stage3.swift
//  Rocket
//
//  Created by Andre Lucas Ota on 19/05/15.
//  Copyright (c) 2015 Andre Lucas Ota. All rights reserved.
//

import SpriteKit

class Stage3: SKScene, TimerDelegate{
    //    MARK: Variables
    let equations = Equations.sharedInstance
    let redirect = Redirect.sharedInstance
    var rocket = SKSpriteNode(imageNamed: "rocketStage3")
    var lifes = 2
    var fireBoost = SKSpriteNode(imageNamed:"fireBoost1")
    var arrayChoices: [SKLabelNode] = []
    var arrayQuestions: [Question] = []
    var questionLabel: SKLabelNode = SKLabelNode()
    var timer: Timer?
    var timerCloud: NSTimer?
    var timerRocket: NSTimer?
    var count = 0
    var toggleFire = Bool()
    
    override func didMoveToView(view: SKView) {
        self.configureView()
        self.createLifes(lifes)
        self.createNodes()
        self.createQuestions()
        self.createQuestionLabel()
        self.createChoices()
        self.createTimer(60)
        self.createPause()
        self.setChoicePosition()
        timerRocket = NSTimer.scheduledTimerWithTimeInterval(0.4, target: self, selector: Selector("changeTexture"), userInfo: nil, repeats: true)
        NSTimer.scheduledTimerWithTimeInterval(2.5, target: self, selector: Selector("movingScene"), userInfo: nil, repeats: false)
    }
    
//    MARK: Create
    func configureView(){
        self.view!.userInteractionEnabled = true
        self.view!.multipleTouchEnabled = false
    }
    
    func createPause(){
        let pauseButton = PauseButton(newX: size.width * 0.13, newY: size.height * 0.035)
        pauseButton.zPosition = 2
        addChild(pauseButton)
    }
    
    func createTimer(time: Int) {
        self.timer = Timer(time: time)
        timer!.fontColor = UIColor.whiteColor()
        timer!.fontName = "Chalkduster"
        timer!.fontSize = 30
        timer!.position = CGPoint(x: self.frame.minX + 280, y: self.frame.minY + 17)
        timer!.zPosition = 2
        addChild(timer!)
        
        timer?.delegate = self
    }
    
    func createCloud(kind: Int, newX: CGFloat){
        let newCloud = SKSpriteNode(imageNamed: "nuvem\(kind).png")
        newCloud.position = CGPointMake(newX, frame.minY)
        newCloud.zPosition = 1
        addChild(newCloud)
        
        moveCloud(newCloud)
    }
    
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
    
    func movingScene(){
        let kind = Int(arc4random_uniform(2))
        let newX = random(min: self.frame.minX + 120, max: self.frame.maxX - 120)
        
        createCloud(kind, newX: newX)
        
        resetCloudTimer()
    }
    
    func moveCloud(cloud: SKSpriteNode){
        let action1 = SKAction.moveToY(frame.maxY+30, duration: 3.3)
        cloud.runAction(action1, completion:{
            cloud.removeFromParent()
        })
    }
    
    //Cria vidas
    func createLifes(qtd: Int){
        var incX: CGFloat = 0.85
        let newY = size.height * 0.05
        var newName = 0
        for index in 0...qtd{
            let newX = size.width * incX
            let life = Life(name: "life.\(newName)", newX: newX, newY: newY)
            incX += 0.03
            newName++
            
            life.zPosition = 2
            
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
        let bg = SKSpriteNode(imageNamed:"bgSky.png" )
        bg.size = size
        bg.position = CGPointMake(self.size.width/2, self.size.height/2)
        bg.zPosition = 0
        addChild(bg)

        rocket.position = CGPoint(x: self.size.width / 2, y: self.size.height * 0.8)
        rocket.zPosition = 2
        addChild(rocket)
        
        fireBoost.position = CGPoint(x: self.size.width / 2, y: self.size.height * 0.7050)
        fireBoost.zPosition = 4
        fireBoost.size = CGSize(width: 50, height: 50)
        addChild(fireBoost)
    }
    
    //Cria label da questão
    func createQuestionLabel(){
        questionLabel = SKLabelNode(text: arrayQuestions[0].equation)
        questionLabel.name = "question"
        questionLabel.fontName = "Chalkduster"
        questionLabel.fontSize = 50
        questionLabel.fontColor = UIColor.redColor()
        questionLabel.position = CGPointMake(self.frame.midX, self.frame.midY + 50)
        questionLabel.zPosition = 2
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
        newChoice.name = "choice.\(newAnswer)"
        newChoice.fontName = "Chalkduster"
        newChoice.fontColor = UIColor.blackColor()
        newChoice.fontSize = 40
        newChoice.zPosition = 2
        return newChoice
    }
    
    //mark criar posiçoes label
    
    func setChoicePosition() {
        var ammountX: CGFloat = 0.2
        var ammountY: CGFloat = 0.4
        var index = 0
        for column in 0 ... 1 {
            for line in 0 ... 1 {
                ammountX += 0.20
                let newX = (size.width ) * ammountX
                let newY = size.height * ammountY
                arrayChoices[index].position = CGPointMake(newX, newY)
                //addChild(arrayChoices[index])
                index++
            }
            ammountX = 0.2
            ammountY -= 0.25
        }
    }
    
    
    //    MARK: NextQuestion
    //Cria próxima questão e alternativas
    func nextQuestion(){
        self.createQuestionLabel()
        self.arrayChoices.removeAll(keepCapacity: false)
        self.createChoices()
        self.setChoicePosition()
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
        if (clickName != "" && clickName != nil){
            println(clickName)
            switchClick(clicked)
        }
    }
    
    func switchClick(clicked: SKNode){
        let name = clicked.name?.componentsSeparatedByString(".")
        let firstName = name!.first!
        
        if(self.scene?.paused == false){
            switch firstName{
            case "choice":
                let secondName = name!.last!
                checkRight(secondName)
                break
            case "pause":
                pauseAction()
                break
            default:
                break
            }
        }
        else{
            switch firstName{
            case "resume":
                resumeAction()
                break
            case "back":
                redirect.stageSelection()
                break
            default:
                break
            }
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
            self.removeNodeWithName("life.\(lifes)")
            println("life.\(lifes)")
            lifes--
            
            if(lifes == -1){
                self.loseAction()
            }
            else{
                self.nextQuestion()
            }
        }
    }
    
//    MARK: Other
    func removeQuestion(){
        self.removeNodeWithName("question")
    }
    
    func removeChoices(){
        for choice in arrayChoices{
            self.removeNodeWithName(choice.name!)
        }
    }
    
    func resetCloudTimer(){
        timerCloud?.invalidate()
        let cloudDelay = Double(random(min: 0.5, max: 1.3))
        timerCloud = NSTimer.scheduledTimerWithTimeInterval(cloudDelay, target: self, selector: Selector("movingScene"), userInfo: nil, repeats: false)
    }
    
    func random() -> CGFloat {
        return CGFloat(Float(arc4random()) / 0xFFFFFFFF)
    }
    
    func random(#min: CGFloat, max: CGFloat) -> CGFloat {
        return random() * (max - min) + min
    }
    
    //metodo que remove o node
    func removeNodeWithName(name: String){
        self.childNodeWithName(name)?.removeFromParent()
    }
    
//    MARK: Pause Resume
    func resumeAction(){
        self.scene?.paused = false
        timerRocket = NSTimer.scheduledTimerWithTimeInterval(0.4, target: self, selector: Selector("changeTexture"), userInfo: nil, repeats: true)
        timerCloud = NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: Selector("movingScene"), userInfo: nil, repeats: false)
        self.removeNodeWithName("PauseBox")
        self.timer!.resume()
    }
    
    func pauseAction(){
        timerRocket?.invalidate()
        timerCloud?.invalidate()
        let pauseNode = PauseNode(newX: self.frame.midX, newY: self.frame.midY)
        addChild(pauseNode)
        self.timer!.pause()
        self.scene?.paused = true
    }
    
//    MARK: Win or Lose
    func winAction(){
        //Ação de ganhar
        println("win")
        self.redirect.stageSelection()
    }
    
    func loseAction(){
        self.timer!.timer?.invalidate()
        let fadeOut = SKTransition.fadeWithColor(UIColor.blackColor(), duration: 3.0)
        
        let reveal = SKTransition.doorsCloseHorizontalWithDuration(1.5)
        let resetScene = Stage3(size: self.size)
        
        self.view?.presentScene(resetScene, transition: fadeOut)
    }
    
    func timeEnd(timer: Timer) {
        self.loseAction()
    }
}
