//
//  ParseExtensions.swift
//  TeamMates
//
//  Created by Guido Marucci Blas on 9/13/14.
//
//

import Foundation

extension PFObject {
    
    func getString(key: String) -> String? {
        return self[key] as String?
    }
    
    func getInt(key: String) -> Int? {
        return self[key] as Int?
    }
    
    func getDate(key: String) -> NSDate? {
        return self[key] as NSDate?
    }
    
}