//
//  Equations.swift
//  Rocket
//
//  Created by Rafael  Hieda on 14/05/15.
//  Copyright (c) 2015 Andre Lucas Ota. All rights reserved.
//

import UIKit

class Equations: NSObject {
    static let sharedInstance = Equations()
    
    override init() {
        
    }
    
    func randomNumberGenerator () ->Int {
        
        return Int(arc4random() % 100)
    }
    
    func zeroToTwentyGenerator() -> Int {
        return Int(arc4random() % 21)
    }
    
    //use a random number generated, calculates the random  multiples between 1 to 10
    func randomMultiples() -> [Int] {
        
        var multiplesArray:[Int] = [Int]()
        var aux = randomNumberGenerator()
        for index in 1 ... 10 {
            if aux % index == 0 {
                multiplesArray.append((aux / index))
            }
        }
        return multiplesArray
        
    }
    
    func equationTypeOne() -> (equation:String, answer:Int) {
        //ax + b =  c
        
        var auxArray = randomMultiples()
        var answer:Int = 0
        var b:Int = 0
        var a:Int = 0
        
        while (auxArray.first == 0 || auxArray.count == 1){
            auxArray = randomMultiples()
        }
        
        if(auxArray.count >= 4) {
            answer = auxArray[0]
            //            b = auxArray[1]
            a = auxArray[2]
        }
        else if auxArray.count == 3 {
            answer = auxArray[0]
            //            b = auxArray[1]
            a = auxArray[2]
        }
        else if auxArray.count == 2 {
            answer = auxArray[0]
            //            b = auxArray[1]
            a = 1
        }
        
        //        answer = randomNumberGenerator()
        b = zeroToTwentyGenerator()
        //        a = zeroToTwentyGenerator()
        
        //fator de correção do a pra dar um inteiro
        //        while( (answer - b) % a != 0 ){
        //            a++
        //        }
        if a >= answer {
            while( (answer - b) % a != 0 ){
                a--
            }
        }
        else if a < answer {
            while( (answer - b) % a != 0 ){
                a++
                if a - answer > 100 {
                    a = 1
                }
            }
        }
        //if the generated answer is equal to one, recalculate a new equation
        while((answer - b)/a == 1) {
            while (auxArray.first == 0 || auxArray.count == 1){
                auxArray = randomMultiples()
            }
            
            if(auxArray.count >= 4) {
                answer = auxArray[0]
                //            b = auxArray[1]
                a = auxArray[2]
            }
            else if auxArray.count == 3 {
                answer = auxArray[0]
                //            b = auxArray[1]
                a = auxArray[2]
            }
            else if auxArray.count == 2 {
                answer = auxArray[0]
                //            b = auxArray[1]
                a = 1
            }
            
            //        answer = randomNumberGenerator()
            b = zeroToTwentyGenerator()
            //        a = zeroToTwentyGenerator()
            
            //fator de correção do a pra dar um inteiro
            //        while( (answer - b) % a != 0 ){
            //            a++
            //        }
            if a >= answer {
                while( (answer - b) % a != 0 ){
                    a--
                }
            }
            else if a < answer {
                while( (answer - b) % a != 0 ){
                    a++
                    if a - answer > 100 {
                        a = 1
                    }
                }
            }
        }
        
        let x:Int = (answer - b)/a
        let equation:String = "\(a)x + \(b) = \(answer)"
        return (equation, x)
    }
    
    func equationTypeTwo() -> (equation:String, answer: Int) {
        //ax - b =  c
        
        var auxArray = randomMultiples()
        var answer:Int = 0
        var b:Int = 0
        var a:Int = 0
        
        while (auxArray.first == 0 || auxArray.count == 1){
            auxArray = randomMultiples()
        }
        
        if(auxArray.count >= 4) {
            answer = auxArray[0]
            //            b = auxArray[1]
            a = auxArray[2]
        }
        else if auxArray.count == 3 {
            answer = auxArray[0]
            //            b = auxArray[1]
            a = auxArray[2]
        }
        else if auxArray.count == 2 {
            answer = auxArray[0]
            //            b = auxArray[1]
            a = 1
        }
        b = zeroToTwentyGenerator()
        if a >= answer {
            while( (answer + b) % a != 0 ){
                a--
            }
        }
        else if a < answer {
            while( (answer + b) % a != 0 ){
                a++
                if a - answer > 100 {
                    a = 1
                }
            }
        }
        
        let x:Int = (answer + b)/a
        let equation:String = "\(a)x - \(b) = \(answer)"
        return (equation, x)
    }
    
    
    func primeNumber(length: Int) {
        let numbers = 1...length
        var primeNumbersArray = [Int]()
        for n in numbers {
            
            //set the flag to true initially
            var prime = true
            for var i = 2; i <= n - 1; i++ {
                
                //even division of a number thats not 1 or the number itself, not a prime number
                if n % i == 0 {
                    prime = false
                    break
                }
            }
            
            if prime == false {
                println("\(n) is not a prime number.")
                
            }  else {
                
                println("\(n) is a prime number.")
                primeNumbersArray.append(n)
                
            }
        }
        println(primeNumbersArray)
    }
    
    func allDividers() -> (arrayToCompare: [Int], newArray: [Int], newNumber: Int)  {
        
        
        var dividers = [Int]()
        while dividers.count < 4 {
            dividers = [Int]()
            var number = randomNumberGenerator()
            while number == 0 {
                number = randomNumberGenerator()
            }
            for index in 1 ... number {
                if number % index == 0 {
                    dividers.append(index)
                }
            }
        }
        
        if(dividers.count > 4){
            return (dividers, self.randomAllIndex(dividers), dividers.last!)
        }
        
        return (dividers, dividers, dividers.last!)
    }
    
    func randomAllIndex(arrayEntry: [Int]) -> [Int]{
        var arrayToRandom = NSMutableArray(array: arrayEntry)
        var auxArray:[Int] = []
        
        for index in 0...3{
            let randomIndex = Int(arc4random_uniform(UInt32(arrayToRandom.count)))
            let newInt = arrayToRandom.objectAtIndex(randomIndex) as! Int
            auxArray.append(newInt)
            arrayToRandom.removeObjectAtIndex(randomIndex)
        }
        
        return auxArray
    }
    
    func calculateSpeed(distance:Int, time:Int)-> Int {
        let speed = (distance/time)
        return speed
    }
    
    func calculateTime(speed:Int, distance:Int) -> Int {
        let time = distance / speed
        return time
    }
    
    func calculateDistance(speed:Int, time:Int) -> Int {
        let distance = speed * time
        return distance
    }
    
    //pragma metodos para 2.4. quando criar tal scene inserir lá!
    
    //    func randomizedProblem() {
    //
    //        let choice = Int(arc4random() % 3)
    //
    //        switch choice {
    //        case 0:
    //            timeProblem()
    //        case 1:
    //            timeProblem()
    //        case 2:
    //            timeProblem()
    //        default:
    //            println("Deu ruim!")
    //
    //        }
    //
    //    }
    
    func randomSpeed() ->Int {
        var speed =  Int(arc4random()%100) * 100
        while(speed == 0) {
            speed = Int(arc4random() % 100) * 100
        }
        return speed
    }
    
    func randomDistance() -> Int {
        
        var distance =  Int(arc4random()%501) * 10000
        while(distance == 0) {
            distance = Int(arc4random() % 501) * 10000
        }
        return distance
    }
    
    func randomTime() -> Int {
        var time = Int(arc4random() % 501)
        while(time == 0) {
            time = Int(arc4random() % 501)
        }
        println(time)
        return time
    }
    
    //mark 2.5 methods
    
    func calcAccel(speed:Int, time:Int) -> Int {
        
        if speed == 0 || time == 0 {
            return  0
        }
            
        else {
            let accel:Int = speed / time
            return accel
        }
    }
    
    func calcWeight(gravity:Int, mass: Int) -> Int {
        let weight = mass * gravity
        return weight
    }
    
    func calcImpulse(mass:Int, accel:Int) ->Int {
        let impulse = accel * mass
        return impulse
        
    }
    
    func resultantForce(impulse:Int, weight:Int) -> Int {
        return impulse  - weight
        
    }
    
    func exercise4Test()  {
        
        // dados básicos: massa, gravidade, distance, tempo
        //lembrar considerar a gravidade está errada por acaso estou calculando km/h e usando m/sˆ2
        //velocidade do foguete mais rápido = 11000 km/h
        
        var mass = 100 //kg
        var weight = calcWeight(10, mass: mass) //Newton
        var speed = calculateSpeed(500000, time: 20) //m/s
        var accel = calcAccel(speed, time: 20) //m/sˆ2
        var impulse = calcImpulse(mass, accel: accel) // Newton
        var resultant = resultantForce(impulse, weight: weight) // Newton
        println("mass: \(mass)")
        println("weight: \(weight)")
        println("speed: \(speed)")
        println("acceleration: \(accel)")
        println("applied force or impulse: \(impulse)")
        println("resultant: \(resultant)")
        
    }
    
    func takeOff(accel: Int, gravity:Int, mass:Int, speed: Int, answer:Int) -> Bool {
        let weight = calcWeight(gravity, mass: mass)
        let launchSpeed = speed
        var impulse = calcImpulse(mass, accel: self.calcAccel(speed, time: self.randomTime()))
        var resultant = resultantForce(impulse, weight: weight)
        
        if resultant >= answer && resultant < answer * 1000 {
            return true
        }
        else {
            return false
        }
    }
    
    //fazem parte da 2.5, talvez devam ficar dentro da fase
    
    func rocketMass() -> Int {
        //considering for example challenger spaceship as 78 ton
        return Int(arc4random_uniform(50) + 51) * 1000
    }
    
    func rocketLaunchSpeed() -> Int {
        //considering the spaceship discovery as parameter, 28000km/h or 7777m/s
        return Int(arc4random_uniform(5) + 6) * 1000
        
    }
    
    func randomGravity() -> Int {
        return Int(arc4random_uniform(10) + 1)
    }
    
    func randomOrbit()-> Int {
        //distance needed to come out from the atmosphere and reach the space
        return Int(arc4random_uniform(10) + 6)
    }
    
    
}


