//
//  ParseSessionService.swift
//  TeamMates
//
//  Created by Guido Marucci Blas on 9/13/14.
//
//

import Foundation

class ParseSessionService: SessionService {
    
    private let permissions = ["public_profile", "email", "user_friends"]
    
    init() {
        PFFacebookUtils.initializeFacebook();
    }
    
    private var session: FBSession? {
        get {
            return PFFacebookUtils.session()
        }
    }
    
    private var currentFBUser: PFUser? {
        get {
            return PFUser.currentUser()
        }
    }
    
    var user : User? = nil
    
    func login(callback : (NSError?, User?) -> ()) {
        PFFacebookUtils.logInWithPermissions(permissions, block: { (fbUser, error) -> Void in
            var user : User? = nil
            if error == nil {
                user = User.fromParseUser(fbUser)
            }
            callback(error, user)
        })   
    }
    
    func currentUser() -> User? {
        return user
    }
    
    func registerFacebookURLHandler(url: NSURL, _ application: String) -> Bool {
        return FBAppCall.handleOpenURL(url, sourceApplication: application, withSession: self.session)
    }
    
    func activate() {
        FBAppCall.handleDidBecomeActiveWithSession(self.session)
    }
    
    func close() {
        self.session?.close()
    }
    
    func isLoggedIn() -> Bool {
        return self.currentFBUser != nil && PFFacebookUtils.isLinkedWithUser(self.currentFBUser)
    }
    
}