//
//  ParseSessionService.swift
//  TeamMates
//
//  Created by Guido Marucci Blas on 9/13/14.
//
//

import Foundation

class ParseSessionService: SessionService {
    
    private var session: FBSession {
        get {
            return PFFacebookUtils.session()
        }
    }
    
    private var currentUser: PFUser? {
        get {
            return PFUser.currentUser()
        }
    }
    
    func registerFacebookURLHandler(url: NSURL, _ application: String) -> Bool {
        return FBAppCall.handleOpenURL(url, sourceApplication: application, withSession: self.session)
    }
    
    func activate() {
        FBAppCall.handleDidBecomeActiveWithSession(self.session)
    }
    
    func close() {
        self.session.close()
    }
    
    func isLoggedIn() -> Bool {
        return self.currentUser != nil && PFFacebookUtils.isLinkedWithUser(self.currentUser)
    }
    
}