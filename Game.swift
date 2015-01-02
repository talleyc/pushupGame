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
    var turnIndex :Int
    var stage :Int //0 = game has not yet started. 1 = in progress. 2 = game over.
    var active :Bool {
        return stage == 1
    }
    var currentCardIndex :Int {
        return turnIndex % deck.deckSize
    }
    var currentPlayerIndex :Int {
        return turnIndex % players.count
    }
    var currentCard :Card {
        return deck.deck[currentCardIndex]
    }
    
    init() {
        
        deck = Deck()
        deck.shuffle()
        players = Array<Player>()
        stage = 0
        turnIndex = 0
    }
    
    func startNextTurn() -> Card {
        players[currentPlayerIndex].endCurrentTurn()
        turnIndex++
        var nextCard = deck.getCard(turnIndex)
        if nextCard.level < 1 {
            self.endGame()
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
        stage = 1
        players[0].startNextTurn(deck.getCard(0))
        return deck.getCard(0)
    }
    
    func endGame() {
        players[currentPlayerIndex].deleteCurrentTurn()
        stage = 2
    }
    
}