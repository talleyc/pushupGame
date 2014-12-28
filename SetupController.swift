//
//  SetupController.swift
//  Pushup Game
//
//  Created by Chris Talley on 12/27/14.
//  Copyright (c) 2014 Chris Talley. All rights reserved.
//

import Foundation
import UIKit

class SetupController: UIViewController {
    @IBOutlet weak var player1NameField: UITextField!
    @IBOutlet weak var player2NameField: UITextField!
    @IBOutlet weak var player3NameField: UITextField!
    @IBOutlet weak var player4NameField: UITextField!
    var actualPlayers :Array<Player>!
    
    override func viewDidLoad() {
        var nameFields = getNameFields()
        let userDefaults = NSUserDefaults.standardUserDefaults()
        for i in 1...4 {
            //if let highscore = userDefaults.valueForKey("highscore") {
            if let defaultName = userDefaults.objectForKey("player\(i)") as String! {
                nameFields[i-1].text = defaultName
            }
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        var userDefaults = NSUserDefaults.standardUserDefaults()
        userDefaults.setValue(player1NameField.text, forKey: "player1")
        userDefaults.setValue(player2NameField.text, forKey: "player2")
        userDefaults.setValue(player3NameField.text, forKey: "player3")
        userDefaults.setValue(player4NameField.text, forKey: "player4")
        if segue.identifier == "setupToGame" {
            var nextController = segue.destinationViewController as ViewController
            nextController.players = actualPlayers!
        }
        
    }
    
    override func shouldPerformSegueWithIdentifier(identifier: String?, sender: AnyObject?) -> Bool {
        actualPlayers = getInsertedPlayers()
        if actualPlayers.count < 2 {
            var alert = UIAlertController(title: "Need more players", message: "Must have at least 2 players to participate", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "Click", style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
            return false
        }
        return true
    }
    
    @IBAction func onTouchOutsideTextViews(sender :AnyObject) {
        self.view.endEditing(true)
    }
    
    func getInsertedPlayers () -> Array<Player>  {
        var potentialPlayers = getNameFields()
        var insertedPlayers = Array<Player>()
        for potential in potentialPlayers {
            if potential.text != nil && potential.text != "" {
                insertedPlayers.append(Player(newName: potential.text))
            }
        }
        return insertedPlayers
    }
    
    func getNameFields() -> Array<UITextField> {
        var playerFields = Array<UITextField>()
        playerFields.append(player1NameField!)
        playerFields.append(player2NameField!)
        playerFields.append(player3NameField!)
        playerFields.append(player4NameField!)
        return playerFields
    }
    
}
