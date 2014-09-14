//
//  User.swift
//  TeamMates
//
//  Created by Martin Gontovnikas on 13/09/14.
//
//

import Foundation

class User {
    
    let firstName : String
    let lastName : String
    let username : String
    let email : String
    let facebookId : String
    
    init(_ firstName : String, _ lastName : String, _ username : String, _ email : String, _ facebookId : String) {
        self.firstName = firstName
        self.lastName = lastName
        self.username = username
        self.email = email
        self.facebookId = facebookId
    }
    
}