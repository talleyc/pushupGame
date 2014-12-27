//
//  Turn.swift
//  Pushup Game
//
//  Created by Chris Talley on 12/26/14.
//  Copyright (c) 2014 Chris Talley. All rights reserved.
//

import Foundation

class Turn {
    var card :Card
    var startTime :NSDate
    var endTime :NSDate
    var active :Bool
    var totalTime :Double{
        get {
            return endTime.timeIntervalSinceDate(startTime)
        }
    }
    var secondsPerPushup :Double{
        get {
            return totalTime/Double(numPushups)
        }
    }
    
    var numPushups :Int {
        get {
            switch card.level {
            case 1:
                return 30
            case 11:
                return 15
            case 12:
                return 20
            case 13:
                return 25
            default:
                return card.level
            }
        }
    }
    
    init(card :Card) {
        self.card = card
        self.active = true
        self.startTime = NSDate()
        self.endTime = NSDate()
    }
    
    func end() {
        self.endTime = NSDate()
        self.active = false
    }
    
}