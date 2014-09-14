//
//  PlayerGroupViewController.swift
//  TeamMates
//
//  Created by Mariano Cortesi on 9/13/14.
//
//

import UIKit

class PlayerGroupViewController: UIViewController {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var daysLeftLabel: UILabel!
    @IBOutlet weak var confirmedPlayersLabel: UILabel!
    @IBOutlet weak var requiredPlayersLabel: UILabel!
    @IBOutlet weak var yesButton: UIButton!
    @IBOutlet weak var noButton: UIButton!
    
    let sessionService = Application.sharedInstance.sessionService
    let matchRepository = Application.sharedInstance.matchRepository
    
    var playerGroup : PlayerGroup! {
        didSet {
            self.fetchCurrentMatch()
        }
    }
    var matchOpt: Match?
    var currentPlayer : Player!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.currentPlayer = Player.fromUser(sessionService.currentUser!)
    }
    
    func reloadUI() {
        nameLabel.text = playerGroup.name
        if let match = self.matchOpt {
            dateLabel.text = self.formatDate(match.date)
            confirmedPlayersLabel.text = "\(match.players)"
            requiredPlayersLabel.text = "\(match.requiredPlayersAmount)"
            let userPlays = match.plays(currentPlayer)
            yesButton.enabled = !userPlays
            noButton.enabled = userPlays
        } else {
            yesButton.enabled = false
            noButton.enabled = false
        }
    }

    override func viewWillAppear(animated: Bool) {
        self.reloadUI()
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func participateInGame(sender: AnyObject) {
        self.matchOpt?.addPlayer(self.currentPlayer)
        self.reloadUI()
    }
    

    @IBAction func dontParticipateInGame(sender: AnyObject) {
        self.matchOpt?.removePlayer(self.currentPlayer)
        self.reloadUI()
    }

    // MARK: - Navigation

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "goToMatchPlayersList") {
            (segue.destinationViewController as MatchPlayersListViewController).setMatch(self.matchOpt!, forGroup: self.playerGroup)
        }
    }
    
    // MARK: - Private methods
    
    func fetchCurrentMatch() {
        if let currentMatchId = self.playerGroup.currentMatchIdOpt {
            self.matchRepository.fetch(currentMatchId, callback: { (errorOpt, matchOpt) -> () in
                if let error = errorOpt {
                    NSLog("Current match could not be fetched \(error)")
                } else {
                    self.matchOpt = matchOpt
                    self.reloadUI()
                }
            })
        }
    }
    
    func formatDate(date: NSDate) -> String {
        let formatter = NSDateFormatter()
        formatter.dateStyle = NSDateFormatterStyle.MediumStyle
        formatter.timeStyle = NSDateFormatterStyle.ShortStyle
        return formatter.stringFromDate(date)
    }

}
