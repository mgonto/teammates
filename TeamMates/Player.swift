//
//  Player.swift
//  TeamMates
//
//  Created by Guido Marucci Blas on 9/13/14.
//
//

import Foundation

class Player: Hashable {
    
    var firstName: String
    var lastName: String
    var username: String
    
    init(firstName: String, lastName: String, username: String) {
        self.firstName = firstName
        self.lastName = lastName
        self.username = username
    }

    var hashValue: Int {
        get {
            return self.username.hashValue
        }
    }

}

func ==(lhs: Player, rhs: Player) -> Bool {
    return lhs.username == rhs.username
}