//
//  DayOfWeek.swift
//  TeamMates
//
//  Created by Guido Marucci Blas on 9/13/14.
//
//

import Foundation

enum DayOfWeek: String {
    case Monday = "Monday"
    case Tuesday = "Tuesday"
    case Wednesday = "Wednesday"
    case Thursday = "Thursday"
    case Friday = "Friday"
    case Saturday = "Saturday"
    case Sunday = "Sunday"
    
    var description: String {
        get {
            return self.toRaw()
        }
    }
    
    private static let days = [Monday, Tuesday, Wednesday, Thursday, Friday, Saturday, Sunday]
    
    static func fromNumber(number: Int) -> DayOfWeek {
        // FIXME check number index out of bounds
        return days[number]
    }
}