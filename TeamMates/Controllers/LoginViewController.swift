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
                self.dismissViewControllerAnimated(true, completion: nil)
            }
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
