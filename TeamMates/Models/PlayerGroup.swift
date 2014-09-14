//
//  PlayerGroup.swift
//  TeamMates
//
//  Created by Guido Marucci Blas on 9/13/14.
//
//

import Foundation

class PlayerGroup: Model {

    var dayOfWeek: DayOfWeek
    var hour: Int
    var minutes: Int
    var name: String
    var requiredPlayers : Int = 10
    
    var members: [Player] {
        get {
            return Array(membersDict.keys)
        }
    }
    
    var membersDict: [Player: Bool]
    
    init(_ name: String, _ hour: Int, _ minutes: Int, _ dayOfWeek: DayOfWeek) {
        self.name = name
        self.hour = hour
        self.minutes = minutes
        self.dayOfWeek = dayOfWeek
        self.membersDict = Dictionary()
        
        super.init()
    }
    
    func addMember(member: Player) {
        membersDict[member] = false
    }
    
    func setAsPlayer(member: Player) {
        membersDict[member] = true
    }
    
    func plays(member: Player) -> Bool {
        var contains = false
        if let plays = membersDict[member] {
            contains = plays
        }
        return contains
    }

    
    func setAsNonPlayer(member: Player) {
        membersDict[member] = false
    }
    
    func getPlayers() -> [Player] {
        return Array(membersDict.keys.filter({ (player) in return self.membersDict[player]! }))
    }
    
    func getNonPlayers() -> [Player] {
        return Array(membersDict.keys.filter({ (player) in return !(self.membersDict[player]!) }))
    }
    
    func getFormattedDate() -> String {
        return "\(self.dayOfWeek.description) \(self.hour):\(self.minutes)"
    }
    
}