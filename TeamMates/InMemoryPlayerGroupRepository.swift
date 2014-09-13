//
//  InMemoryPlayerGroupRepository.swift
//  TeamMates
//
//  Created by Guido Marucci Blas on 9/13/14.
//
//

import Foundation

class InMemoryPlayerGroupRepository: PlayerGroupRepository {
    
    private var groups: [PlayerGroup]
    
    init() {
        groups = []
        
        let group = PlayerGroup("Test group", 20, 30, DayOfWeek.Monday)
        
        let cono = Player(firstName: "Mariano", lastName: "Cortesi", username: "cono")
        group.addMember(cono)
        group.setAsPlayer(cono)
        group.addMember(Player(firstName: "Hernan", lastName: "Zalazar", username: "zala"))
        group.addMember(Player(firstName: "Martin", lastName: "Gontovnikas", username: "gonto"))
        group.addMember(Player(firstName: "Guido", lastName: "Maruchi", username: "guido"))
        
        groups.append(group)
    }
    
    func fetchAll(callback: ((NSError?, [PlayerGroup]?) -> ())) {
        callback(nil, groups)
    }
    
    func save(group: PlayerGroup, callback: ((NSError?, PlayerGroup?) -> ())) {
        groups.append(group)
        callback(nil, group)
    }
    
}