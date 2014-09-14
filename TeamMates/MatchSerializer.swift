//
//  MatchSerializer.swift
//  TeamMates
//
//  Created by Guido Marucci Blas on 9/14/14.
//
//

import Foundation

extension Match {
    
    class func tableName() -> String {
        return "Match"
    }
    
    class func fromParseObject(object: PFObject) -> Match {
        let date = object.getDate("date")!
        let requiredPlayersAmount = object.getInt("required_players_amount")!
        let match = Match(date, requiredPlayersAmount)
        return ParseSerializerHelper.setBaseFields(match, object)
    }
    
    func toParseObject() -> PFObject {
        let object = PFObject(className: Match.tableName())
        object["date"] = self.date
        object["required_players_amount"] = self.requiredPlayersAmount
        return object
    }
    
}