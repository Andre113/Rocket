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
    var arrayLifes: [Life] = []
    let deltaT = SKLabelNode(text: "∆T")
    let deltaV = SKLabelNode(text: "∆V")
    let deltaS = SKLabelNode(text: "∆S")
    var questionLabel = ""
    let bar = SKSpriteNode()
    var arrayRoutes: [Route] = []
    var answer = Route?()
    
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        self.scaleMode = .AspectFill
        self.view?.userInteractionEnabled = true
        
        self.createRoutes()
        self.setPositions()
    }
    
//    MARK: Create
    func configureView(){
        deltaT.position = CGPoint()
        deltaV.position = CGPoint()
        deltaS.position = CGPoint()
        bar.position = CGPoint()
    }
    
    func createLifes(){
        var incX: CGFloat = 0.68
        let newY = size.height * 0.05
        var newName = 0
        for index in 0...1{
            let newX = size.width * incX
            let life = Life(name: "\(newName)", newX: newX, newY: newY)
            arrayLifes.append(life)
            incX += 0.03
            newName++
            
            addChild(life)
        }
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
        
        self.rightQuestion()
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
        var newX:CGFloat = 400
        var newY = CGFloat()
        
        for route in arrayRoutes{
            let newSpeed = SKLabelNode(text: "\(route.deltaSpeed)")
            let newDistance = SKLabelNode(text: "\(route.deltaDistance)")
            
            newSpeed.position = CGPoint()
            newDistance.position = CGPoint()
            
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
        
        self.questionLabel = "Rocket precisa escolher uma rota para levar as encomendas para o planeta \(novoNome). Qual delas rotas possui o menor tempo de viagem?"
    }
    
    func rightQuestion(){
        var rightRoute = arrayRoutes[0]
        for route in arrayRoutes{
            if(route.deltaTime < rightRoute.deltaTime){
                rightRoute = route
            }
        }
        self.answer = rightRoute
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
        if (clickName == "Route"){
            self.checkRight(clicked as! Route)
        }
    }
    
    func checkRight(route: Route){
        if(route.deltaTime == self.answer?.deltaTime){
            
        }
    }
}
