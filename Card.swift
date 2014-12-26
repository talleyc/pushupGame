//
//  Card.swift
//  Pushup Game
//
//  Created by Chris Talley on 12/26/14.
//  Copyright (c) 2014 Chris Talley. All rights reserved.
//

import Foundation
import UIKit

class Card {
    private struct suitStruct {static var suits = ["c","d","h","s"]}
    var level :Int
    var suit :String
    public class var suits :Array<String> {
        get { return suitStruct.suits }
    }
    
    var image :UIImage {
        get {
            if ( self.level < 0 || self.level > 51 || find(Card.suits, self.suit) == nil) {
                return UIImage(named: "j1.png")!
            } else {
                return UIImage(named: "\(level)\(suit).png")!
            }
        }
    }
    
    init(){
        self.level = -1
        self.suit = ""
    }
    
    init(l :Int, s :String) {
        level = l
        suit = s
    }
}