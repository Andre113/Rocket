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
}
   

