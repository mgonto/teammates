//
//  EventDate.swift
//  TeamMates
//
//  Created by Guido Marucci Blas on 9/14/14.
//
//

import Foundation

class EventDate {
    
    let dayOfWeek: DayOfWeek
    let hour: Int
    let minutes: Int
    
    init(_ dayOfWeek: DayOfWeek, _ hour: Int, _ minutes: Int) {
        self.dayOfWeek = dayOfWeek
        self.hour = hour
        self.minutes = minutes
    }
    
//    func nextMatchDate() -> NSDate {
//        let currentDate = NSDate()
//        let gregorian = NSCalendar(calendarIdentifier: NSGregorianCalendar)
//        let components = gregorian.components(NSCalendarUnit.CalendarUnitWeekday, fromDate: currentDate)
//        var weekday = components.weekday
//        
//        var matchDate: NSDate
//        if (weekday == self.dayOfWeek.dayNumber) {
//            matchDate = currentDate
//        } else {
//            if (weekday < self.dayOfWeek.dayNumber) {
//                weekday += 7 + 1
//            }
//            let addDays = weekday - self.dayOfWeek.dayNumber
//            let addComponents = NSDateComponents()
//            addComponents.day = addDays
//            matchDate = gregorian.dateByAddingComponents(addComponents, toDate: currentDate, options: 0)!
//        }
//        return matchDate
//    }
    
    func formmatedDate() -> String {
        return "\(self.dayOfWeek.description) \(self.hour):\(self.minutes)"
    }

    
}