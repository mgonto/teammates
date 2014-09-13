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