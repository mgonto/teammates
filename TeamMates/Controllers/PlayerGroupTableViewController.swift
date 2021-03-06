//
//  PlayerGroupTableViewController.swift
//  TeamMates
//
//  Created by Guido Marucci Blas on 9/13/14.
//
//

import UIKit

class PlayerGroupTableViewController: UITableViewController {

    private let cellIdentifier = "PlayerGroupCell"
    
    let playerGroupRepository = Application.sharedInstance.playerGroupRepository
    var groups: [PlayerGroup] = []
    
    func fetchAll() {
        playerGroupRepository.fetchAll({ [unowned self] (errorOpt, groupsOpt) in
            if let error = errorOpt {
                NSLog("Error fetching groups \(error)")
            } else {
                self.groups = groupsOpt!
                self.tableView.reloadData()
            }
        })
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.fetchAll()
    }
    
    // MARK: - Table view data source

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return groups.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as UITableViewCell

        let group = groups[indexPath.row]
        cell.textLabel?.text = group.name
        cell.detailTextLabel?.text = formatPlayerGroupDate(group)

        return cell
    }

    @IBAction func unwindFromAddPlayerGroup(segue: UIStoryboardSegue) {
        NSLog("Trying to do the segue")
        fetchAll()
    }
    
    // MARK: - Private methods
    
    func formatPlayerGroupDate(group: PlayerGroup) -> String {
        return "\(group.dayOfWeek.description) \(group.hour):\(group.minutes)"
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "goToGroupDetail") {
            let group: PlayerGroup = groups[self.tableView.indexPathForSelectedRow()!.row]
            (segue.destinationViewController as PlayerGroupViewController).playerGroup = group
        }
    }
}
