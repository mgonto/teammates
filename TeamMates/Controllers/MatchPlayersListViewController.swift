//
//  PlayerGroupDetailController.swift
//  TeamMates
//
//  Created by Mariano Cortesi on 9/13/14.
//
//

import UIKit

class MatchPlayersListViewController: UITableViewController {

    private var _group: PlayerGroup!
    private var _match: Match!
    private var _attendees: [Player]!
    private var _nonAttendees: [Player]!
    
    func setMatch(match: Match, forGroup group: PlayerGroup) {
        _group = group
        _match = match
        _attendees = match.players
        _nonAttendees = group.getAbsentPlayers(_match)
    }
    
    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch (section) {
        case 0:
            return _attendees.count
        case 1:
            return _nonAttendees.count
        default:
            return 0
        }
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        switch (indexPath.section) {
        case 0:
            let cell = tableView.dequeueReusableCellWithIdentifier("playerDetailCell", forIndexPath: indexPath) as UITableViewCell
         
            let member = _attendees[indexPath.row]
            cell.textLabel?.text = "\(member.firstName) \(member.lastName)"
            cell.accessoryType = UITableViewCellAccessoryType.Checkmark
            return cell
            
        default: // case 3
            let cell = tableView.dequeueReusableCellWithIdentifier("playerDetailCell", forIndexPath: indexPath) as UITableViewCell
            let member = _nonAttendees[indexPath.row]
            cell.textLabel?.text = "\(member.firstName) \(member.lastName)"

            
            return cell
        }
    }
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch (section) {
        case 0: return "Players"
        case 1: return "Not Going"
        default: return nil
        }
    }
}
