//
//  Player.swift
//  Pushup Game
//
//  Created by Chris Talley on 12/26/14.
//  Copyright (c) 2014 Chris Talley. All rights reserved.
//

import Foundation

class Player {
    var turns :Array<Turn>
    var currentTurn :Turn{
        get {
            return turns[turns.count - 1]
        }
    }
    var totalPushups :Int {
        get {
            var pushups = 0
            for turn in turns {
                if !turn.active {
                    pushups += turn.numPushups
                }
            }
            return pushups
        }
    }
    
    init() {
        turns = Array<Turn>()
    }
    
    func startNextTurn(card :Card) {
        turns.append(Turn(card: card))
    }
    
    func endCurrentTurn() {
        if currentTurn.active {
            currentTurn.end()
        }
    }
    
    func secondsPerPushup() -> Double {
        var totalTime = 0.0
        var totalPushups = 0.0
        for turn in turns {
            if !turn.active {
                totalTime += turn.totalTime
                totalPushups += Double(turn.numPushups)
        
            }
        }
        if totalPushups > 0 && totalTime > 0.1 {
            return totalTime / totalPushups
        }
        return 0
    }
}