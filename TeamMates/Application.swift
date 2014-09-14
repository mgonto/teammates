//
//  Application.swift
//  TeamMates
//
//  Created by Guido Marucci Blas on 9/13/14.
//
//

import Foundation

private let _application = Application()

class Application {
    
    let playerGroupRepository: PlayerGroupRepository = ParsePlayerGroupRepository()
    let matchRepository: MatchRepository = ParseMatchRepository()
    let sessionService: SessionService = ParseSessionService()
    
    class var sharedInstance: Application {
        return _application
    }
    
}