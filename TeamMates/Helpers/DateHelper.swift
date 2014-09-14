//
//  DateHelper.swift
//  TeamMates
//
//  Created by Mariano Cortesi on 9/13/14.
//
//

import Foundation


class DateHelper {
    class func getDateFor(hours: Int, minutes: Int) -> NSDate {
        let c = NSDateComponents()
        c.hour = hours
        c.minute = minutes
        
        return NSCalendar.currentCalendar().dateFromComponents(c)!
    }
    
    class func hourAndMinutesFrom(date: NSDate) -> (hours: Int, minutes: Int) {
        let components = NSCalendar.currentCalendar().components(NSCalendarUnit.HourCalendarUnit | NSCalendarUnit.MinuteCalendarUnit, fromDate: date)
        return (components.hour, components.minute)
    }
}