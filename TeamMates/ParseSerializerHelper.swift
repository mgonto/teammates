//
//  ParseSerializerHelper.swift
//  TeamMates
//
//  Created by Guido Marucci Blas on 9/13/14.
//
//

import Foundation

class ParseSerializerHelper {
    
    class func setBaseFields<T: Model>(model: T, _ object: PFObject) -> T {
        model.id = object.objectId
        model.createdAt = object.createdAt
        model.updatedAt = object.updatedAt
        return model
    }
    
}