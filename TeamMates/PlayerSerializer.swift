//
//  PlayerSerializer.swift
//  TeamMates
//
//  Created by Martin Gontovnikas on 13/09/14.
//
//

import Foundation

extension Player {
    
    class func fromUser(user :User) -> Player {
        return Player(firstName: user.firstName, lastName: user.lastName, username: user.username, facebookId: user.facebookId)
    }
}
