//
//  Question.swift
//  Rocket
//
//  Created by Andre Lucas Ota on 19/05/15.
//  Copyright (c) 2015 Andre Lucas Ota. All rights reserved.
//

import UIKit

class Question: NSObject{
    var equation: String = ""
    var answer: Int = 0
    
    init(equation: String, answer: Int){
        super.init()
        self.equation = equation
        self.answer = answer
    }
    
    func getAnswer() -> Int{
        return self.answer
    }
    
    func getEquation() -> String{
        return self.equation
    }
}
