//
//  PlayerGroupParseSerializer.swift
//  TeamMates
//
//  Created by Guido Marucci Blas on 9/13/14.
//
//

import Foundation

extension PlayerGroup {
    
    class func fromParseObject(object: PFObject) -> PlayerGroup {
        let name = object.getString("name")!
        let hour = object.getInt("hour")!
        let minutes = object.getInt("minutes")!
        let dayOfWeek = DayOfWeek.fromNumber(object.getInt("day_of_week")!)
        let group = PlayerGroup(name, hour, minutes, dayOfWeek)
        return ParseSerializerHelper.setBaseFields(group, object)
    }
    
    func toParseObject() -> PFObject {
        let object = PFObject(className: PlayerGroup.tableName())
        object["name"] = self.name
        object["day_of_week"] = self.dayOfWeek.dayNumber
        object["hour"] = self.hour
        object["minutes"] = self.minutes
        return object
    }
    
    class func tableName() -> String {
        return "PlayerGroup"
    }
    
}