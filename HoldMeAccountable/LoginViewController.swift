//
//  LoginViewController.swift
//  HoldMeAccountable
//
//  Created by Alex on 7/28/16.
//  Copyright © 2016 Alex. All rights reserved.
//

import UIKit
import Fabric
import DigitsKit
import Parse

class LoginViewController: UIViewController {
    
    private func navigateToMainAppScreen() {
        performSegueWithIdentifier("NavigateToMain", sender: self)
    }

    @IBAction func tapButton(sender: AnyObject) {
        let digits = Digits.sharedInstance()
        digits.authenticateWithCompletion { (session, error) in
            if (session != nil) {
                self.navigateToMainAppScreen()
                print("test")
                
                let phoneNumber = session.phoneNumber
                
                let newUser = PFUser()
                
                let email = phoneNumber + "me@me.com"
                let userName = phoneNumber + "_username"
                let password = phoneNumber + "_password"
                
                newUser.email = email
                newUser.username = userName
                newUser.password = password
                newUser["phoneNumber"] = phoneNumber
                
                print("example")
                
                newUser.signUpInBackgroundWithBlock {
                    
                    (succeeded: Bool, error: NSError?) -> Void in
                    
                    if let error = error {
                        let errorString = error.userInfo["error"] as? String
                        print("failure : " + errorString!)
                    } else {
                        print("success")
                        
                        let defaults = NSUserDefaults.standardUserDefaults()
                        
                        defaults.setValue(email, forKey: "email")
                        defaults.setValue(userName, forKey: "user_name")
                        defaults.setValue(password, forKey: "password")
                        defaults.setValue(phoneNumber, forKey: "phone_number")
                        
                        defaults.synchronize()
                    }
                }
                print("sample")
                
                //num = session!.phoneNumber
            } else {
                NSLog("Authentication error: %@", error!.localizedDescription)
            }
        }

    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        let defaults = NSUserDefaults.standardUserDefaults()
        let email = defaults.stringForKey("email")
        let userName = defaults.stringForKey("user_name")
        let password = defaults.stringForKey("password")
        
        if email == nil || email!.isEmpty {
            
            return
        }
        
        if PFUser.currentUser() != nil {
            
            self.showGoalViewController ()
            return
        }
        
        PFUser.logInWithUsernameInBackground(userName!, password: password!, block: { (user, error) -> Void in
            
            // Stop the spinner
            if ((user) != nil) {
                
                self.showGoalViewController ()
            } else {
                
            }
        })

        
        
    }
    
    func showGoalViewController () {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewControllerWithIdentifier("ID_SetGoalViewController") as! SetGoalViewController
        self.presentViewController(vc, animated: false, completion: nil)

    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
