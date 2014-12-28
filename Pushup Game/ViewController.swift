//
//  ViewController.swift
//  Pushup Game
//
//  Created by Chris Talley on 12/23/14.
//  Copyright (c) 2014 Chris Talley. All rights reserved.
//

import UIKit
import Darwin

class ViewController: UIViewController {

    @IBOutlet weak var cardImage: UIImageView!
    @IBOutlet weak var cardButton: UIButton!
    @IBOutlet weak var reshuffleButton: UIButton!
    @IBOutlet weak var currentPlayerNameLabel: UILabel!
    var game = Game()
    var players :Array<Player>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        displayCard(game.startGame(players!))
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onTouchCard(recognizer: UIGestureRecognizer) {
        if game.active {
            displayCard(game.startNextTurn())
        }
    }
    
    @IBAction func onClickReshuffle(sender :AnyObject) {
        addAlert()        
        game = Game()
        displayCard(game.startGame(players!))
        
    }

    
    func addAlert() {
        var alert = UIAlertController(title: "Alert", message: constructAlertMessage(), preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "Click", style: UIAlertActionStyle.Default, handler: nil))
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    
    func constructAlertMessage() -> String {
        var message = ""
        message += "Total pushups: \(game.players[0].totalPushups)\nSeconds per pushup: \(game.players[0].secondsPerPushup())"
        return message
    }
    
    func displayCard(card :Card) {
        currentPlayerNameLabel.text = game.players[game.currentPlayerIndex].name
        cardImage.image = card.image
    }

}

