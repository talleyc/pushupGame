//
//  ViewController.swift
//  Pushup Game
//
//  Created by Chris Talley on 12/23/14.
//  Copyright (c) 2014 Chris Talley. All rights reserved.
//

import UIKit
import Darwin
import AVFoundation

class ViewController: UIViewController {

    var cardImage: UIImageView!
    var currentPlayerNameLabel: UILabel!
    var instructionLabel :UILabel!
    var game :Game!
    var players :Array<Player>!
    var soundEffectPlayer: AVAudioPlayer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        cardImage.layer.cornerRadius = 10
        cardImage.clipsToBounds = true
        cardImage.image = UIImage(named: "back_of_card.png")
    }
    
    override func viewWillAppear(animated: Bool) {        
        playSoundEffect("shuffle.mp3")

    }
    
    override func viewDidAppear(animated :Bool) {        instructionLabel.frame = CGRectMake(-100,self.cardImage.frame.origin.y,  self.cardImage.frame.width, cardImage.frame.height)
        game = Game()
        instructionLabel.hidden = false
        
        UIView.animateWithDuration(0.7, delay:0.0, options: .CurveEaseOut, animations: {
            
            self.view.addSubview(self.instructionLabel)
            self.instructionLabel!.frame.origin.x = self.cardImage.frame.origin.x
            }, completion: {finished in}
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
    
    
    
    func onTouchCard(sender: UIGestureRecognizer) {
        if game != nil && game.active {
            playSoundEffect("card_flip.mp3")
            displayCard(game.startNextTurn())
        } else if game.stage == 0 {
            instructionLabel.hidden = true
            playSoundEffect("card_flip.mp3")
            game = Game()
            displayCard(game.startGame(players!))
        }
    }
    
    func onClickEndGame(sender: UIButton) {
        if game != nil && game.players.count > 0 && game.players[0].turns.count > 0 {
            //if game has been initialized and at least one player has taken a turn
            performSegueWithIdentifier("gameToResults", sender: sender)
        }
    }
    
    
    func playSoundEffect(filename: String) {
        let url = NSBundle.mainBundle().URLForResource(filename, withExtension: nil)
        if (url == nil) {
            println("Could not find file: \(filename)")
            return
        }
        
        var error: NSError? = nil
        soundEffectPlayer = AVAudioPlayer(contentsOfURL: url, error: &error)
        if let player = soundEffectPlayer {
            player.numberOfLoops = 0
            player.prepareToPlay()
            player.play()
        } else {
            println("Could not create audio player: \(error!)")
        }
    }
    
    /*
        RENDERING LOGIC
    */
    
    func setupView() {
        placeNameLabel()
        placeCardImage()
        prepareInstructionLabel()
        placeEndGameButton()
    }
    
    func placeNameLabel() {
        let labelWidth = self.view.frame.width
        let labelHeight = CGFloat(30)
        let labelX = CGFloat(0)
        let labelY = self.view.frame.height * 0.06 + navigationController!.navigationBar.frame.height
        currentPlayerNameLabel = UILabel(frame:CGRectMake(labelX,labelY,labelWidth, labelHeight))
        currentPlayerNameLabel.textColor = UIColor(red: 1, green: 234/255, blue: 48/255, alpha: 1)
        currentPlayerNameLabel.textAlignment = NSTextAlignment.Center
        currentPlayerNameLabel.font = UIFont.boldSystemFontOfSize(26)
        currentPlayerNameLabel.numberOfLines = 1
        self.view.addSubview(currentPlayerNameLabel)
    }
    
    func placeEndGameButton() {
        let endGameButton = UIButton.buttonWithType(UIButtonType.System) as UIButton
        let buttonWidth = cardImage.frame.width / 1.618
        let buttonHeight = 43/111 * buttonWidth
        let buttonX = self.view.center.x - buttonWidth / 2
        let buttonY = cardImage.frame.origin.y + cardImage.frame.height + buttonHeight / 2
        
        endGameButton.backgroundColor = UIColor(red: 230/255, green: 221/255, blue: 22/255, alpha: 0.5)
        endGameButton.setTitle("End Game", forState: .Normal)
        endGameButton.setTitleColor(UIColor(red: 1, green: 9/255, blue: 9/255, alpha: 1), forState: .Normal)
        endGameButton.titleLabel!.font = UIFont.systemFontOfSize(18)
        endGameButton.frame = CGRectMake(buttonX, buttonY, buttonWidth, buttonHeight)
        endGameButton.layer.cornerRadius = 12
        endGameButton.layer.masksToBounds = true
        endGameButton.addTarget(self, action: "onClickEndGame:", forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(endGameButton)
    }
    

    
    func placeCardImage() {
        let cardHeight = self.view.frame.height * 0.5
        let cardWidth = 5 / 7 * cardHeight
        let cardX = CGFloat(self.view.center.x - (cardWidth / 2))
        let cardY = currentPlayerNameLabel.frame.origin.y + currentPlayerNameLabel.frame.height
        cardImage = UIImageView(image: UIImage(named: "back_of_card.png"))
        cardImage!.frame = CGRectMake(cardX, cardY, cardWidth, cardHeight)
        let swipe = UISwipeGestureRecognizer(target: self, action: Selector("onTouchCard:"))
        cardImage!.addGestureRecognizer(swipe)
        cardImage!.userInteractionEnabled = true
        self.view.addSubview(cardImage)
    }
    
    func prepareInstructionLabel() {
        instructionLabel = UILabel(frame:CGRectMake(-100,self.cardImage.center.y - 40,  self.cardImage.frame.width, cardImage.frame.height))
        instructionLabel.text = "SWIPE RIGHT TO START"
        instructionLabel.textColor = UIColor(red: 0.03, green: 0, blue: 0.75, alpha: 1)
        instructionLabel.textAlignment = NSTextAlignment.Center
        instructionLabel.font = UIFont.boldSystemFontOfSize(22)
        instructionLabel.numberOfLines = 2
    }
    
    func displayCard(card :Card) {
        currentPlayerNameLabel.text = game.players[game.currentPlayerIndex].name
        cardImage.image = card.image
    }

}

