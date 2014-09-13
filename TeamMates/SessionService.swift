//
//  SessionService.swift
//  TeamMates
//
//  Created by Guido Marucci Blas on 9/13/14.
//
//

import Foundation

protocol SessionService {
    
    func registerFacebookURLHandler(url: NSURL, _ application: String) -> Bool
    
    func activate()
    
    func close()
    
    func isLoggedIn() -> Bool
    
}