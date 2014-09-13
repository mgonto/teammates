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
    var members: [Player]
    
    init(_ name: String, _ hour: Int, _ minutes: Int, _ dayOfWeek: DayOfWeek) {
        self.name = name
        self.hour = hour
        self.minutes = minutes
        self.dayOfWeek = dayOfWeek
        self.members = []
    }
    
    func addMember(member: Player) {
        members.append(member)
    }
}