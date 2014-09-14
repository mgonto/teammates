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

    private var _currentUser: User? = nil
    
    var currentUser: User? {
        set(newCurrentUser) {
            _currentUser = newCurrentUser
            let userDefaults = NSUserDefaults.standardUserDefaults()
            userDefaults.setObject(_currentUser?.toDictionary(), forKey: "currentUser")
        }
        get {
            if _currentUser == nil {
                let userDefaults = NSUserDefaults.standardUserDefaults()
                let userDataOpt = userDefaults.objectForKey("currentUser") as Dictionary<String, AnyObject>?
                if let userData = userDataOpt {
                    _currentUser = User.fromDictionary(userData)
                }
            }
            return _currentUser
        }
    }
    
    init() {
        PFFacebookUtils.initializeFacebook();
    }
    
    func login(callback : (NSError?, User?) -> ()) {
        PFFacebookUtils.logInWithPermissions(permissions, block: { (fbUser, error) -> Void in
            if (error != nil) {
                callback(error, nil)
            } else {
                self.fetchFacebookUserData({ (errorOpt, userData) -> () in
                    if let error = errorOpt {
                        callback(errorOpt, nil)
                    } else {
                        self.currentUser = User.fromDictionary(userData!)
                        callback(nil, self.currentUser)
                    }
                })
            }
        })
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
    
    // MARK: - Private methods
    
    private func fetchFacebookUserData(callback: (NSError?, Dictionary<String, AnyObject>?) -> ()) {
        let request = FBRequest.requestForMe()
        request.startWithCompletionHandler { (connection, userData, error) -> Void in
            callback(error, userData as Dictionary<String, AnyObject>?)
        }
    }
    
    
}