//
//  PlayerGroupParseSerializer.swift
//  TeamMates
//
//  Created by Guido Marucci Blas on 9/13/14.
//
//

import Foundation

extension PlayerGroup {
    
    class func tableName() -> String {
        return "PlayerGroup"
    }
    
    class func fromParseObject(object: PFObject) -> PlayerGroup {
        let name = object.getString("name")!
        let date = EventDate.fromParseObject(object)
        let requiredPlayersAmount = object.getInt("required_players_amount")!
        let currentMatchId = object.getString("current_match_id")!
        let group = PlayerGroup(name, date, requiredPlayersAmount, currentMatchId)
        return ParseSerializerHelper.setBaseFields(group, object)
    }
    
    func toParseObject() -> PFObject {
        let object = PFObject(className: PlayerGroup.tableName())
        self.date.toParseObject(object)
        object["name"] = self.name
        object["required_players"] = self.requiredPlayersAmount
        return object
    }
    
}