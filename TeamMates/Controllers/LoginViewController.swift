//
//  LoginViewController.swift
//  TeamMates
//
//  Created by Martin Gontovnikas on 13/09/14.
//
//

import UIKit

class LoginViewController: UIViewController {
    
    let sessionService = Application.sharedInstance.sessionService

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func loginWithFacebook(sender: AnyObject) {
        sessionService.login { (errorOpt, userOpt) -> () in
            if let error = errorOpt {
                NSLog("There was an error \(error)")
            } else {
                NSLog("User \(userOpt?.username) successfully logged in")
                NSLog("Email \(userOpt?.email)")
                NSLog("First name \(userOpt?.firstName)")
                NSLog("Last name \(userOpt?.lastName)")
                self.dismissViewControllerAnimated(true, completion: nil)
            }
        }
    }

}
