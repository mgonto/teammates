//
//  ParsePlayerGroupRepository.swift
//  TeamMates
//
//  Created by Guido Marucci Blas on 9/13/14.
//
//

import Foundation

class ParsePlayerGroupRepository: PlayerGroupRepository {
    
    private let applicationId = "0QdMEXIWIO1climwC5f5wUFx4ajgyWzK83s3JUSK"
    private let clientKey = "uObXtrRM0M8gtOCEJHJuWexqnewUvXv2oLYJHlib"
    
    init() {
        Parse.setApplicationId(applicationId, clientKey: clientKey)
    }
    
    func fetchAll(callback: ((NSError?, [PlayerGroup]?) -> ())) {
        let query = PFQuery(className: PlayerGroup.tableName())
        query.findObjectsInBackgroundWithBlock { (objects, error) -> Void in
            let groups = objects.map({ (object) in
                PlayerGroup.fromParseObject(object as PFObject)
            })
            callback(error, groups)
        }
    }
    
    func save(group: PlayerGroup, callback: ((NSError?, PlayerGroup?) -> ())) {
        let object = group.toParseObject()
        object.saveInBackgroundWithBlock { (success, error) -> Void in
            let savedGroup = PlayerGroup.fromParseObject(object)
            callback(error, savedGroup)
        }
    }
    
}