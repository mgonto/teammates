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
    
    class func fromFriend(friend : FBGraphObject) -> Player {
        return Player(firstName: friend.objectForKey("first_name") as NSString,
            lastName: friend.objectForKey("last_name") as NSString,
            username: friend.objectForKey("name") as NSString,
            facebookId: friend.objectForKey("id") as NSString)
    }
}
