//
//  Game.swift
//  Pushup Game
//
//  Created by Chris Talley on 12/27/14.
//  Copyright (c) 2014 Chris Talley. All rights reserved.
//

import Foundation

class Game {
    var deck :Deck
    var players :Array<Player>
    var active :Bool
    var turnIndex :Int
    var currentCardIndex :Int {
        return turnIndex % deck.deckSize
    }
    var currentPlayerIndex :Int {
        return turnIndex % players.count
    }
    
    init() {
        
        deck = Deck()
        deck.shuffle()
        players = Array<Player>()
        active = false
        turnIndex = 0
    }
    
    func startNextTurn() -> Card {
        players[currentPlayerIndex].endCurrentTurn()
        turnIndex++
        var nextCard = deck.getCard(turnIndex)
        if nextCard.level < 1 {
            active = false
            return nextCard
        } else {
            players[currentPlayerIndex].startNextTurn(nextCard)
            return nextCard
        }
    }
    
    func startGame(p :Array<Player>) -> Card {
        players = p
        for player in players {
            player.turns = Array<Turn>()
        }
        active = true
        players[0].startNextTurn(deck.getCard(0))
        return deck.getCard(0)
    }
    
    
    
}