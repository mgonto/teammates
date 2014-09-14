//
//  PlayerGroupViewController.swift
//  TeamMates
//
//  Created by Mariano Cortesi on 9/13/14.
//
//

import UIKit

class PlayerGroupViewController: UIViewController, FBFriendPickerDelegate {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var daysLeftLabel: UILabel!
    @IBOutlet weak var confirmedPlayersLabel: UILabel!
    @IBOutlet weak var requiredPlayersLabel: UILabel!
    @IBOutlet weak var yesButton: UIButton!
    @IBOutlet weak var noButton: UIButton!
    
    let sessionService = Application.sharedInstance.sessionService
    
    var playerGroup : PlayerGroup!
    
    var myPlayer : Player {
        get {
            return Player.fromUser(sessionService.currentUser!)
        }
    }
    

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let fbCache = FBFriendPickerViewController.cacheDescriptor()
        fbCache.prefetchAndCacheForSession(sessionService.session!)
        // Do any additional setup after loading the view.
    }
    
    func reloadUI() {
        nameLabel.text = playerGroup.name
        dateLabel.text = playerGroup.getFormattedDate()
        confirmedPlayersLabel.text = "\(playerGroup.getPlayers().count)"
        requiredPlayersLabel.text = "\(playerGroup.requiredPlayers)"
        let userPlays = playerGroup.plays(myPlayer)
        NSLog("%@", userPlays)
        yesButton.enabled = !userPlays
        noButton.enabled = userPlays
        
    }

    override func viewWillAppear(animated: Bool) {
        self.reloadUI()
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func participateInGame(sender: AnyObject) {
        self.playerGroup.setAsPlayer(myPlayer)
        self.reloadUI()
    }
    

    @IBAction func dontParticipateInGame(sender: AnyObject) {
        self.playerGroup.setAsNonPlayer(myPlayer)
        self.reloadUI()
    }
    

    
    
    func friendPickerViewController(friendPicker: FBFriendPickerViewController!, handleError error: NSError!) {
        NSLog("There was an error fetching the users")
    }
    
    func facebookViewControllerDoneWasPressed(sender: AnyObject!) {
        let picker = sender as FBFriendPickerViewController
        
        for friend in picker.selection {
            playerGroup.addMember(Player.fromFriend(friend as FBGraphObject))
        }
        picker.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func facebookViewControllerCancelWasPressed(sender: AnyObject!) {
        let picker = sender as FBFriendPickerViewController
        picker.dismissViewControllerAnimated(true, completion: nil)
    }
    
    

    // MARK: - Navigation

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "goToMatchPlayersList") {
            (segue.destinationViewController as MatchPlayersListViewController).playerGroup = playerGroup
        } else if (segue.identifier == "showFriends") {
            let controller = segue.destinationViewController as FBFriendPickerViewController
            controller.title = "Invite friends to the match"
            controller.delegate = self
            controller.loadData()
        }
    }
}
