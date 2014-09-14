//
//  ParseMatchRepository.swift
//  TeamMates
//
//  Created by Guido Marucci Blas on 9/14/14.
//
//

import Foundation

class ParseMatchRepository: MatchRepository {
    
    func fetch(id: String, callback: (NSError?, Match?) -> ()) {
        let object = PFObject(withoutDataWithClassName: Match.tableName(), objectId: id)
        object.fetchIfNeededInBackgroundWithBlock { (matchObject, error) -> Void in
            if (error != nil) {
                callback(error, nil)
            } else {
                callback(nil, Match.fromParseObject(matchObject))
            }
        }
    }
    
}