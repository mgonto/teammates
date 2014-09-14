//
//  EventDateParseSerializer.swift
//  TeamMates
//
//  Created by Guido Marucci Blas on 9/14/14.
//
//

import Foundation

extension EventDate {
    
    class func fromParseObject(object: PFObject) -> EventDate {
        let hour = object.getInt("hour")!
        let minutes = object.getInt("minutes")!
        let dayOfWeek = DayOfWeek.fromNumber(object.getInt("day_of_week")!)
        return EventDate(dayOfWeek, hour, minutes)
    }
    
    func toParseObject(object:PFObject) -> PFObject {
        object["day_of_week"] = self.dayOfWeek.dayNumber
        object["hour"] = self.hour
        object["minutes"] = self.minutes
        return object
    }
    
}