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
    var player1NameField: UITextField!
    var player2NameField: UITextField!
    var player3NameField: UITextField!
    var player4NameField: UITextField!
    var actualPlayers: Array<Player>!
    var separator: UIView!
    var goButton: UIButton!
    
    override func viewDidLoad() {
        setupPage()
        var nameFields = getNameFields()
        let userDefaults = NSUserDefaults.standardUserDefaults()
        for i in 1...4 {
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
    
    func onClickGo(sender: UIButton) {
        
        actualPlayers = getInsertedPlayers()
        if actualPlayers.count < 2 {
            var alert = UIAlertController(title: "Need more players", message: "Must have at least 2 players to participate", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
        } else {
            performSegueWithIdentifier("setupToGame", sender: goButton)
        }
    }
    
    /*
        RENDERING LOGIC
    */
    func setupPage() {
        addInstructionLabel()
        addNameFields()
        addGoButton()
    }
    
    func addInstructionLabel() {
        let labelWidth = self.view.frame.width
        let labelHeight = CGFloat(35)
        let labelX = CGFloat(0)
        let labelY = navigationController!.navigationBar.frame.height + self.view.frame.height * 0.06
        let instructionLabel = UILabel(frame: CGRectMake(labelX, labelY, labelWidth, labelHeight))
        instructionLabel.textAlignment = NSTextAlignment.Center
        instructionLabel.textColor = UIColor(red: 1, green: 234/255, blue: 48/255, alpha: 1)
        instructionLabel.font = UIFont.boldSystemFontOfSize(20)
        instructionLabel.text = "Enter Up To 4 Names"
        self.view.addSubview(instructionLabel)
        //add separator view
        let separatorWidth = self.view.frame.width * 0.9
        let separatorHeight = CGFloat(5)
        let separatorX = self.view.frame.width * 0.05
        let separatorY = labelY + labelHeight + self.view.frame.height * 0.02
        
        separator = UIView(frame: CGRectMake(separatorX, separatorY, separatorWidth, separatorHeight))
        separator.backgroundColor = UIColor(red: 159/255, green: 230/255, blue: 105/255, alpha: 1)
        self.view.addSubview(separator)
    }
    
    func addNameFields() {
        
        let fieldWidth = self.view.frame.width / 3
        let fieldHeight = fieldWidth * 3 / 10
        let fieldX = fieldWidth
        let startFieldY = separator.frame.origin.y + separator.frame.height + self.view.frame.height * 0.05
        let fieldGap = self.view.frame.height * 0.02
        player1NameField = UITextField(frame: CGRectMake(fieldX, startFieldY, fieldWidth, fieldHeight))
        player2NameField = UITextField(frame: CGRectMake(fieldX, startFieldY + fieldHeight + fieldGap, fieldWidth, fieldHeight))
        player3NameField = UITextField(frame: CGRectMake(fieldX, startFieldY + fieldHeight * 2 + fieldGap * 2, fieldWidth, fieldHeight))
        player4NameField = UITextField(frame: CGRectMake(fieldX, startFieldY + fieldHeight * 3 + fieldGap * 3, fieldWidth, fieldHeight))
        setupNameField(player1NameField, index: 1)
        setupNameField(player2NameField, index: 2)
        setupNameField(player3NameField, index: 3)
        setupNameField(player4NameField, index: 4)
        
    }
    
    func addGoButton() {
        goButton = UIButton.buttonWithType(UIButtonType.System) as UIButton
        let buttonWidth = player1NameField.frame.width / 1.618
        let buttonHeight = buttonWidth / 1.618
        let buttonX = self.view.center.x - buttonWidth / 2
        let buttonY = player4NameField.frame.origin.y + player4NameField.frame.height + buttonHeight / 2
        goButton.backgroundColor = UIColor(red: 230/255, green: 221/255, blue: 22/255, alpha: 0.5)
        
        goButton.setTitle("GO!", forState: .Normal)
        goButton.setTitleColor(UIColor(red: 1, green: 9/255, blue: 9/255, alpha: 1), forState: .Normal)
        goButton.titleLabel!.font = UIFont.systemFontOfSize(18)
        goButton.frame = CGRectMake(buttonX, buttonY, buttonWidth, buttonHeight)
        goButton.layer.cornerRadius = 12
        goButton.layer.masksToBounds = true
        goButton.addTarget(self, action: "onClickGo:", forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(goButton)
    }
    
    func setupNameField(field :UITextField, index :Int) {
        field.borderStyle = UITextBorderStyle.RoundedRect
        field.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.6)
        field.placeholder = "Contender \(index)"
        self.view.addSubview(field)
    }
    
}



















