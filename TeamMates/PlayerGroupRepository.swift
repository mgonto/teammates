//
//  PlayerGroupRepository.swift
//  TeamMates
//
//  Created by Guido Marucci Blas on 9/13/14.
//
//

import Foundation

protocol PlayerGroupRepository {
    
    func fetchAll(callback: ((NSError?, [PlayerGroup]?) -> ()))
    
    func save(group: PlayerGroup, callback: ((NSError?, PlayerGroup?) -> ()))
    
}