//
//  Stage2.swift
//  Rocket
//
//  Created by Andre Lucas Ota on 18/05/15.
//  Copyright (c) 2015 Andre Lucas Ota. All rights reserved.
//

import SpriteKit

class Stage2: SKScene {
//    MARK: Variables
    let equations = Equations.sharedInstance
    let deltaT = SKLabelNode(text: "∆T")
    let deltaV = SKLabelNode(text: "∆V")
    let deltaS = SKLabelNode(text: "∆S")
    let bar = SKSpriteNode()
    var questionLabel = ""
    var arrayRoutes: [Route] = []
    var rightRoute = Route?()
    
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        self.scaleMode = .AspectFill
        self.view?.userInteractionEnabled = true
        
        self.createRoutes()
        self.setPositions()
        self.setLabels()
    }
    
//    MARK: Create
    func configureView(){
        deltaT.position = CGPoint()
        deltaV.position = CGPoint()
        deltaS.position = CGPoint()
        bar.position = CGPoint()
    }
    
//    MARK: Create Routes
    func createRoutes(){
        for index in 0...2{
            let newOption = timeProblem()
            let newSpeed = newOption.speed
            let newDistance = newOption.distance
            let newAnswer = newOption.answer
            let newRoute = Route(bgImage: "rocket5.png", deltaTime: newAnswer, deltaDistance: newDistance, deltaSpeed: newSpeed)
            self.arrayRoutes.append(newRoute)
        }
        
        self.selectRightQuestion()
    }
    
    func setPositions(){
        var newX = self.frame.midX
        var newY:CGFloat = 160
        for route in arrayRoutes{
            route.position = CGPointMake(newX, newY)
            newY += 150
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
            
//            addChild(newSpeed)
//            addChild(newDistance)
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
        var novoNome = ""
        
        self.questionLabel = "Rocket precisa escolher uma rota para levar as encomendas para o planeta \(novoNome). Qual delas possui o menor tempo de viagem?"
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
        /* Called when a touch begins */
        
        let touch = touches.first as! UITouch
        let location = touch.locationInNode(self)
        let clicked = self.nodeAtPoint(location)
        let clickName = clicked.name
        
        //Se clicar em uma rota
        if (clickName == "Route"){
            self.view?.userInteractionEnabled = false
            self.checkRight(clicked as! Route)
        }
    }
    
    func checkRight(route: Route){
        self.animateRoute(route)
        if(route.deltaTime == self.rightRoute?.deltaTime){
            self.winAction()
        }
        else{
            self.loseAction()
        }
    }
    
//    MARK: Win or Lose
    func winAction(){
        
    }
    
    func loseAction(){
        let fadeOut = SKTransition.fadeWithColor(UIColor.blackColor(), duration: 3.0)
        
        let reveal = SKTransition.doorsCloseHorizontalWithDuration(1.5)
        let resetScene = Stage2(size: self.size)
        
        self.view?.presentScene(resetScene, transition: fadeOut)
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
}
