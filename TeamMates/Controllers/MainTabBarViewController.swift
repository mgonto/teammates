//
//  MainTabBarViewController.swift
//  TeamMates
//
//  Created by Martin Gontovnikas on 13/09/14.
//
//

import UIKit

class MainTabBarViewController: UITabBarController {
    
    let sessionService = Application.sharedInstance.sessionService

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        if !sessionService.isLoggedIn() {
            let controller = LoginViewController()
            self.performSegueWithIdentifier("LoginSegue", sender: self)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
