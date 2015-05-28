//
//  Stage2.swift
//  Rocket
//
//  Created by Andre Lucas Ota on 18/05/15.
//  Copyright (c) 2015 Andre Lucas Ota. All rights reserved.
//

import SpriteKit

class Stage2: SKScene, TimerDelegate {
//    MARK: Variables
    let equations = Equations.sharedInstance
    let redirect = Redirect.sharedInstance
    var timer: Timer?
    var arrayRoutes: [Route] = []
    var rightRoute = Route?()
    var equation = Equations.sharedInstance
    
    override func didMoveToView(view: SKView) {
        self.configureView()
        self.createBG("testebg2.jpg")
        self.createPlanetName()
        self.createRoutes()
        self.setPositions()
        self.createTimer(20)
//        self.setLabels()
        self.createPause()
    }
    
//    MARK: Create
    func configureView(){
        self.scaleMode = .AspectFill
        self.view?.userInteractionEnabled = true
        self.view?.multipleTouchEnabled = false
    }
    
    func createBG(bgName: String){
        let bgRoute = SKSpriteNode(imageNamed: bgName)
        bgRoute.size = size
        bgRoute.position = CGPointMake(self.frame.midX, self.frame.midY)
        bgRoute.zPosition = 0
        addChild(bgRoute)
    }
    
    func createTimer(time: Int) {
        self.timer = Timer(time: time)
        timer!.fontColor = UIColor.whiteColor()
        timer!.fontName = "Chalkduster"
        timer!.fontSize = 20
        timer!.position = CGPoint(x: frame.minX + 400, y: self.frame.minY + 17)
        timer!.zPosition = 2
        addChild(timer!)
        
        timer?.delegate = self
    }
    
    func createPause(){
        let pauseButton = PauseButton(newX: frame.width * 0.3, newY: frame.height * 0.035)
        pauseButton.zPosition = 1
        addChild(pauseButton)
    }
    
//    MARK: Create Routes
    func createRoutes(){
        for index in 1...3{
            let newOption = timeProblem()
            let newSpeed = newOption.speed
            let newDistance = newOption.distance
            let newAnswer = newOption.answer
            let newRoute = Route(bgImage: "route\(index).png", deltaTime: newAnswer, deltaDistance: newDistance, deltaSpeed: newSpeed)
            newRoute.zPosition = 1
            newRoute.name = "route.\(index)"
            
            self.arrayRoutes.append(newRoute)
        }
        
        self.selectRightQuestion()
    }
    
    func setPositions(){
        var newX = self.frame.midX
        var newY:CGFloat = 140
        for route in arrayRoutes{
            route.position = CGPointMake(newX, newY)
            newY += 185
            addChild(route)
        }
    }
    
    func setLabels(){
        let speedX:CGFloat = 400
        var speedY = CGFloat()
        
        let distanceX = CGFloat()
        var distanceY = CGFloat()
        
        for route in arrayRoutes{
            
            let newSpeed = SKLabelNode(text: "\(route.deltaSpeed)")
            let newDistance = SKLabelNode(text: "\(route.deltaDistance)")
            
            newSpeed.position = CGPointMake(speedX, speedY)
            newDistance.position = CGPointMake(distanceX, distanceY)
            
            speedY += 0
            distanceY += 0
            
//           addChild(newSpeed)
//           addChild(newDistance)
        }
    }
    
//    MARK: Create Question
    func timeProblem() -> (speed: Int, distance: Int, answer: Int) {
        var speed = equations.randomSpeed()
        var distance = equations.randomDistance()
        var answer = equations.calculateTime(speed, distance: distance)
        
        return (speed, distance, answer)
    }
    
    func createPlanetName(){
        var novoNome = "Urano"
        
        let questionLabel1 = Title(text: "Rocket precisa escolher uma rota para", pos: CGPointMake(500, 730), fntSize: 20)
        let questionLabel2 = Title(text:  "levar as encomendas para o planeta \(novoNome).", pos: CGPointMake(500, 700), fntSize: 20)
        let questionLabel3 = Title(text: "Qual delas possui o menor tempo de viagem?", pos: CGPointMake(500, 670), fntSize: 20)

        addChild(questionLabel1)
        addChild(questionLabel2)
        addChild(questionLabel3)
    }
    
    func selectRightQuestion(){
        var select = arrayRoutes[0]
        for route in arrayRoutes{
            if(route.deltaTime < select.deltaTime){
                select = route
            }
        }
        self.rightRoute = select
    }
    
//    MARK: Touches
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        let touch = touches.first as! UITouch
        let location = touch.locationInNode(self)
        let clicked = self.nodeAtPoint(location)
        let clickName = clicked.name
        
        if(clickName != ""  && clickName != nil){
            println(clickName)
            self.switchTouch(clicked)
        }
    }
    
//    MARK: Switch Touch
    
    func switchTouch(clicked: SKNode){
        let name = clicked.name?.componentsSeparatedByString(".")
        let firstName = name!.first!
        let secondName = name!.last!
        
        if(self.scene?.paused == false){
            switch firstName{
            case "pause":
                pauseAction()
                break
            case "route":
                self.view?.userInteractionEnabled = false
                checkRight(clicked as! Route)
                break
            default:
                break
            }
        }
        else{
            switch firstName{
            case "back":
                redirect.stageSelection()
                break
            case "resume":
                resumeAction()
                break
            default:
                break
            }
        }
    }
    
    func checkRight(route: Route){
        if(route.deltaTime == self.rightRoute?.deltaTime){
            self.winAction()
        }
        else{
            self.animateRoute(route)
            NSTimer.scheduledTimerWithTimeInterval(0.7, target: self, selector: "loseAction", userInfo: nil, repeats: false)
        }
    }
    
//    MARK: Win or Lose
    func winAction(){
        redirect.newStage(3)
    }

    func loseAction(){
        redirect.newStage(2)
    }
    
    func timeEnd(timer: Timer) {
        self.loseAction()
    }
    
//    MARK: Animation
    func animateRoute(routeToMove: Route){
        let action1 = SKAction.moveByX(4.0, y: 0.0, duration: 0.025)
        let action2 = SKAction.moveByX(-8.0, y: 0.0, duration: 0.04)
        let action3 = SKAction.moveByX(4.0, y: 0.0, duration: 0.025)
        let action4 = SKAction.sequence([action1, action2, action3])
        let action5 = SKAction.repeatAction(action4, count: 5)
        
        routeToMove.runAction(action5)
        routeToMove.runAction(action5, completion:{
            self.view?.userInteractionEnabled = true
        })
    }
    
    //    MARK: Other
    func resumeAction(){
        self.scene?.paused = false
        self.removeNodeWithName("PauseBox")
        self.timer!.resume()
    }
    
    func pauseAction(){
        let pauseNode = PauseNode(newX: self.frame.midX, newY: self.frame.midY)
        addChild(pauseNode)
        self.timer!.pause()
        self.scene?.paused = true
    }
    
    func removeNodeWithName(name: String){
        self.childNodeWithName(name)?.removeFromParent()
    }

}
