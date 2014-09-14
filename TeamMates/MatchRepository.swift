//
//  MatchRepository.swift
//  TeamMates
//
//  Created by Guido Marucci Blas on 9/14/14.
//
//

import Foundation

protocol MatchRepository {
    
    func fetch(id: String, callback: (NSError?, Match?) -> ())
    
}