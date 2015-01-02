//
//  ResultsViewController.swift
//  Pushup Game
//
//  Created by Chris Talley on 1/1/15.
//  Copyright (c) 2015 Chris Talley. All rights reserved.
//

import Foundation
import UIKit

class ResultsViewController: UIViewController {
    var game :Game!
    let labelHeight = 70
    let labelGap = 20
    
    override func viewDidLoad() {
        let players: Array<Player> = game!.players
        var message = ""
        for i in 0..<players.count {
            displayPlayer(players[i],index: i)
        }
    }
    
    func displayPlayer(player :Player, index: Int) {
        var totalLabel = UILabel(frame: CGRectMake(self.view.frame.width * 0.1, getYForIndex(index), self.view.frame.width * 0.8, CGFloat(labelHeight)))
        totalLabel.text = NSString(format: "\(player.name) completed \n\t\(player.totalPushups) pushups at a rate of \n\t%.2f seconds per pushup", player.secondsPerPushup())
        totalLabel.numberOfLines = 5
        self.view.addSubview(totalLabel)
    }
    
    func getYForIndex(index :Int) -> CGFloat {
        let firstLabelHeight = Int(self.view.frame.height * 0.15)
        return CGFloat(firstLabelHeight + index * (labelHeight + labelGap))
    }

}