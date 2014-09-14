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
    
    var playerGroup : PlayerGroup!
    
    let sessionService = Application.sharedInstance.sessionService
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(animated: Bool) {
        nameLabel.text = playerGroup.name
        dateLabel.text = playerGroup.getFormattedDate()
        confirmedPlayersLabel.text = "\(playerGroup.getPlayers().count)"
        requiredPlayersLabel.text = "\(playerGroup.requiredPlayers)"
        
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func participateInGame(sender: AnyObject) {
        self.playerGroup.setAsPlayer(Player.fromUser(sessionService.currentUser!))
    }
    

    @IBAction func dontParticipateInGame(sender: AnyObject) {
        self.playerGroup.setAsNonPlayer(Player.fromUser(sessionService.currentUser!))
    }

    // MARK: - Navigation

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "goToMatchPlayersList") {
            (segue.destinationViewController as MatchPlayersListViewController).playerGroup = playerGroup
        }
    }

}
