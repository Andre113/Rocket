//
//  Timer.swift
//  Rocket
//
//  Created by Wellington Pardim Ferreira on 5/20/15.
//  Copyright (c) 2015 Andre Lucas Ota. All rights reserved.
//

import SpriteKit

protocol TimerDelegate{
    func timeEnd(timer: Timer)
}

class Timer: SKLabelNode {
    var startTime = 0
    var delay: NSTimer?
    var timer: NSTimer?
    var delegate: TimerDelegate? = nil
    
    init(time: Int) {
        super.init()
        self.startTime = time
        self.text = "\(startTime)"
        self.zPosition = 2
        self.startDelay()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func startDelay(){
        self.delay = NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: "startTimer", userInfo: nil, repeats: false)
    }
    
    func startTimer() {
        self.delay?.invalidate()
        self.timer = NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: "updateTime", userInfo: nil, repeats: true)
    }
    
    func updateTime() {
        startTime--
        self.text = "\(startTime)"
        
        if self.text == "0" {
            if(delegate != nil){
                delegate?.timeEnd(self)
            }
        }
    }
    
    func pause(){
        timer?.invalidate()
        self.startTime = Int(self.text!)!
    }
    
    func resume(){
        self.startTimer()
    }
}
