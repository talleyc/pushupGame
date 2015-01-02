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
    var instructionLabel :UILabel!
    var game :Game!
    var players :Array<Player>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cardImage.layer.cornerRadius = 10
        cardImage.clipsToBounds = true
        cardImage.image = UIImage(named: "back_of_card.png")
        instructionLabel = UILabel(frame:CGRectMake(-100,self.cardImage.center.y - 40,  self.cardImage.frame.width, 50))
        instructionLabel.text = "SWIPE RIGHT TO START"
        instructionLabel.textColor = UIColor(red: 0.03, green: 0, blue: 0.75, alpha: 1)
        instructionLabel.textAlignment = NSTextAlignment.Center
        instructionLabel.font = UIFont.boldSystemFontOfSize(17)
    }
    
    
    override func viewDidAppear(animated :Bool) {
        instructionLabel.frame = CGRectMake(-100,self.cardImage.center.y - 40,  self.cardImage.frame.width, 50)
        game = Game()
        instructionLabel.hidden = false
        UIView.animateWithDuration(0.7, delay:0.0, options: .CurveEaseOut, animations: {
            
            self.view.addSubview(self.instructionLabel)
            self.instructionLabel!.frame.origin.x = self.cardImage.frame.origin.x
            }, completion: {finished in
                println("showing instructions")
            }
        )
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "gameToResults" {
            cardImage.image = UIImage(named: "back_of_card.png")
            game.endGame()
            var nextController = segue.destinationViewController as ResultsViewController
            nextController.game = self.game
            game = Game()
        }
    }
    
    
    override func shouldPerformSegueWithIdentifier(identifier: String?, sender: AnyObject?) -> Bool {
        if game != nil && game.players.count > 0 && game.players[0].turns.count > 0 {
            //if game has been initialized, has players, and at least one turn has happened
            return true
        }
        return false
    }
    
    
    @IBAction func onTouchCard(recognizer: UIGestureRecognizer) {
        if game != nil && game.active {
            displayCard(game.startNextTurn())
        } else if game.stage == 0 {
            instructionLabel.hidden = true
            game = Game()
            displayCard(game.startGame(players!))
        }
    }
    
    func displayCard(card :Card) {
        currentPlayerNameLabel.text = game.players[game.currentPlayerIndex].name
        cardImage.image = card.image
    }

}

