//
//  Model.swift
//  TeamMates
//
//  Created by Guido Marucci Blas on 9/13/14.
//
//

import Foundation

class Model: Equatable {

    var id: String?
    var createdAt: NSDate?
    var updatedAt: NSDate?
    
    init() {
        
    }
    
}

func ==(lhs: Model, rhs: Model) -> Bool {
    return lhs.id == rhs.id
}