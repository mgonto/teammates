//
//  UserParseSerializer.swift
//  TeamMates
//
//  Created by Martin Gontovnikas on 13/09/14.
//
//

import Foundation

extension User {
    
    class func fromParseUser(parseUser : PFUser) -> User {
        let firstName = parseUser.getString("first_name")!
        let lastName = parseUser.getString("last_name")!
        let username = parseUser.username
        let email = parseUser.email
        let user = User(firstName, lastName, username, email)
        return ParseSerializerHelper.setBaseFields(user, parseUser)
    }
}