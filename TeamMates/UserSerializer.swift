//
//  UserParseSerializer.swift
//  TeamMates
//
//  Created by Martin Gontovnikas on 13/09/14.
//
//

import Foundation

extension User {
    
    class func fromDictionary(userData : Dictionary<String, AnyObject>) -> User {
        let firstName = userData["first_name"] as NSString!
        let lastName = userData["last_name"] as NSString!
        let username = userData["name"] as NSString!
        let email = userData["email"] as NSString!
        let facebookId = userData["id"] as NSString!
        
        return User(firstName, lastName, username, email, facebookId)
    }
    
    func toDictionary() -> Dictionary<NSString, AnyObject> {
        return [
            "first_name" : self.firstName,
            "last_name" : self.lastName,
            "name" : self.username,
            "email" : self.email,
            "id" : self.facebookId
        ]
    }
}