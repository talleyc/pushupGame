//
//  Deck.swift
//  Pushup Game
//
//  Created by Chris Talley on 12/26/14.
//  Copyright (c) 2014 Chris Talley. All rights reserved.
//

import Foundation

class Deck {
    var deck :Array<Card>
    var nextCardIndex :Int
    var deckSize :Int {
        return deck.count
    }
    
    
    init() {
        deck = Array<Card>()
        nextCardIndex = 0
        setUp()
    }
    
    func setUp() {
        deck = Array<Card>()
        nextCardIndex = 0
        for i in 1..<14 {
            for suit in Card.suits {
                deck.append(Card(l: i,s :suit))
            }
        }
    }
    
    func shuffle() {
        if(deck.count < 52) {
            setUp()
        }
        for i in 0..<52 {
            var tempCard = deck[i]
            var rand = Int(arc4random_uniform(52))
            deck[i] = deck[rand]
            deck[rand] = tempCard
        }
        nextCardIndex = 0
    }
    
    func getCard(index :Int) ->Card {
        if index < deck.count {
            return deck[index]
        }
        return Card()
    }
    
}