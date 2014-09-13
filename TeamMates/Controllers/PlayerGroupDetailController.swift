//
//  PlayerGroupDetailController.swift
//  TeamMates
//
//  Created by Mariano Cortesi on 9/13/14.
//
//

import UIKit

class PlayerGroupDetailController: UITableViewController {

    var playerGroup : PlayerGroup! {
        didSet {
            self.nonPlayers = playerGroup.getNonPlayers()
            self.players = playerGroup.getPlayers()
        }
    }
    
    var players : [Player]!
    var nonPlayers : [Player]!
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 3
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch (section) {
        case 0:
            return 1
        case 1:
            NSLog("players \(players.count)")
            return self.players.count
        case 2:
            NSLog("players \(players.count)")
            return self.nonPlayers.count
        default:
            return 0
        }
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        switch (indexPath.section) {
        case 0:
            let cell = tableView.dequeueReusableCellWithIdentifier("groupHeaderCell", forIndexPath: indexPath) as UITableViewCell
            
            cell.textLabel?.text = playerGroup.name
            cell.detailTextLabel?.text = formatPlayerGroupDate(playerGroup)
            
            return cell
            
        case 1:
            let cell = tableView.dequeueReusableCellWithIdentifier("playerDetailCell", forIndexPath: indexPath) as UITableViewCell
         
            let member = players[indexPath.row]
            NSLog("member player \(member.firstName)")
            cell.textLabel?.text = "\(member.firstName) \(member.lastName)"
            cell.accessoryType = UITableViewCellAccessoryType.Checkmark
            return cell
            
        default: // case 3
            let cell = tableView.dequeueReusableCellWithIdentifier("playerDetailCell", forIndexPath: indexPath) as UITableViewCell
            
            let member = nonPlayers[indexPath.row]
            NSLog("member NONplayer \(member.firstName)")
            cell.textLabel?.text = "\(member.firstName) \(member.lastName)"

            
            return cell
        }
    }
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch (section) {
        case 0: return nil
        case 1: return "Players"
        case 2: return "Not Going"
        default: return nil
        }
    }
    
    func formatPlayerGroupDate(group: PlayerGroup) -> String {
        return "\(group.dayOfWeek.description) \(group.hour):\(group.minutes)"
    }
}
