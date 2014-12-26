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
    var deck = Deck()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        deck.shuffle()
        cardImage.image = deck.getNextCard().image
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onTouchCard(sender: AnyObject) {
        cardImage.image = deck.getNextCard().image
    }

    @IBAction func onClickReshuffle(sender :AnyObject) {
        deck.shuffle()
        onTouchCard(sender)
    }

}

