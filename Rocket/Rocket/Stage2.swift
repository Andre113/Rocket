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
    var deltaV = SKLabelNode(text: "∆V")
    var deltaS = SKLabelNode(text: "∆S")
    let bar = SKSpriteNode()
    var arrayRoutes: [Route] = []
    
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
    
    func createRoutes(){
        for index in 0...2{
            let newOption = timeProblem()
            let newSpeed = newOption.speed
            let newDistance = newOption.distance
            let newAnswer = newOption.answer
            let newRoute = Route(bgImage: "rocket5.png", deltaTime: newAnswer, deltaDistance: newDistance, deltaSpeed: newSpeed)
            self.arrayRoutes.append(newRoute)
        }
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
    
//    MARK: Other
    func timeProblem() -> (speed: Int, distance: Int, answer: Int) {
        var questionLabel = "Rocket precisa levar as encomendas para o planeta (nome do planeta temporário), mas existem duas rotas, A e B. Qual das duas rotas o tempo da viagem será o menor?"
        var speed = equations.randomSpeed()
        var distance = equations.randomDistance()
        var answer = equations.calculateTime(speed, distance: distance)
        
        return (speed, distance, answer)
    }
    
//    func compareAnswers(){
//        if(answer1 < answer2 && answer1 < answer3) {
//            println("Menor tempo é a rota 1!")
//            return answer1
//        }
//        else {
//            if (answer2 < answer1 && answer2 < answer3){
//                println("Menor tempo é a rota 2!")
//                return answer2
//            }
//            else{
//                println("Menor tempo é a rota 3!")
//                return answer3
//            }
//        }
//    }
}
