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
            b = auxArray[2]
            a = auxArray[3]
        }
        else if auxArray.count == 3 {
            answer = auxArray[0]
            b = auxArray[1]
            a = auxArray[2]
        }
        else if auxArray.count == 2 {
            answer = auxArray[0]
            b = auxArray[1]
            a = 1
        }
        
        //answer = randomNumberGenerator()
//        b = zeroToTwentyGenerator()
//        a = zeroToTwentyGenerator()
        
        //fator de correção do a pra dar um inteiro
        while( (answer - b) % a != 0 ){
            a++
        }
//        while((answer - b) % a != 0){
//            if(a > answer) {
//                a++
//            }
//        }
    
        let x:Int = (answer - b)/a
        
       let equation:String = "\(a)x + \(b)= \(answer)"
        return (equation, x)
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
    
            
}
   

