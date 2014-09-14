//
//  PlayerGroup.swift
//  TeamMates
//
//  Created by Guido Marucci Blas on 9/13/14.
//
//

import Foundation

class PlayerGroup: Model {

    private var _members: [Player] = []
    
    let date: EventDate
    let name: String
    let currentMatchIdOpt: String?
    var requiredPlayersAmount : Int = 10
    var members: Int {
        get {
            return _members.count
        }
    }
    
    init(_ name: String, _ date: EventDate, _ requiredPlayersAmount: Int, _ currentMatchIdOpt: String?) {
        self.name = name
        self.date = date
        self.requiredPlayersAmount = requiredPlayersAmount
        self.currentMatchIdOpt = currentMatchIdOpt
    }
    
    func addMember(member: Player) {
        _members.append(member)
    }
    
    func removeMember(member: Player) {
        for (index, element) in enumerate(_members) {
            if (element == member) {
                _members.removeAtIndex(index)
            }
        }
    }
    
    func getAbsentPlayers(match: Match) -> [Player] {
        let players = match.players
        return _members.filter { (player) -> Bool in
            !contains(players, player)
        }
    }
    
}