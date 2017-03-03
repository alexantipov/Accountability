//
//  SetGoalViewController.swift
//  HoldMeAccountable˚
//
//  Created by Alex on 7/13/16.
//  Copyright © 2016 Alex. All rights reserved.
//

import UIKit
import Fabric
import DigitsKit
import Parse

var num = ""

class SetGoalViewController: UIViewController {
    

    let GOAL_CLASS_NAME : String = "Goal"

    let GOAL_USER_ID : String = "userId"
    let GOAL_ENTER_GOAL : String = "goal"
    let GOAL_DATE : String = "goalDate"
    let GOAL_FAIL_STATUS : String = "goalFailStatus"
    let GOAL_SUPPORTER_NAME : String = "supporterName"
    let GOAL_SUPPORTER_PHONE_NUMBER : String = "supporterPhoneNumber"
    

    //IBOutlets and IBActions
    @IBOutlet weak var myDatePicker: UIDatePicker!
    @IBAction func myDateView(sender: AnyObject) {}
    @IBOutlet var scrollView: UIScrollView!
    @IBAction func didTapButton(sender: AnyObject) {
                self.navigateToContacts()
    }
    
    
    var goalData = GoalModel()
    
    
    //Define dismissKeyboard method
    func dismissKeyboard() {
        view.endEditing(true)
    }
    
    //Define options in the "If I fail, I will" Picker View
    var pickerDataSource = ["Run 2 Miles", "Sing a song in front of 10 strangers", "Buy My Supporter Coffee"];
    
    //viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        

        //Changes the color of the UIDatePicker to white & changes the text for "today" to the current date
        myDatePicker.setValue(UIColor.whiteColor(), forKey: "textColor")
        myDatePicker.sendAction("setHighlightsToday:", to: nil, forEvent: nil)
        
        //Changes the size of the scroll view
        scrollView.contentSize = CGSizeMake(self.view.frame.size.width, 2300)
        
        // Formatting the Date Picker to have the minimum date be the current date
        let currentDate = NSDate()
        myDatePicker.minimumDate = currentDate
        myDatePicker.date = currentDate
        
        // Make the keyboard disappear
        let tap: UITapGestureRecognizer?
        tap = UITapGestureRecognizer(target: self, action: #selector(SetGoalViewController.dismissKeyboard))
        view.addGestureRecognizer(tap!)
    }
    
    // Delegates and Datasources for the Picker View
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerDataSource.count;
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerDataSource[row]
    }
    
    //Currently Not Used
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
//    func makeAUser(num: String) {
//        //Defining Parse user
//        let newUser = PFUser()
//        
//        //Inputs information on logged in user to Parse server
//        newUser["number"] = num
//        newUser.password = "test"
//        newUser.email = "me@gmail.com"
//        
//        // Sign up the user asynchronously
//        newUser.signUpInBackgroundWithBlock {
//            (succeeded: Bool, error: NSError?) -> Void in
//            if error == nil {
//                //Success
//            } else {
//            }
//        }
//    }
    
    private func navigateToContacts() {
        performSegueWithIdentifier("NavigateToContacts", sender: self)
    }
    
    @IBAction func unwindToSetGoalViewController(segue: UIStoryboardSegue) {
        // defining method
    }
    
    @IBAction func onSave(sender: AnyObject) {
        
        //you should change following values with values that you want...
        
        //setting Enter Goal value
        goalData.goal = "My test goal"

        //I will finish this goal by...
        let dateformatter = NSDateFormatter()
        dateformatter.dateFormat = "yyyy-MM-dd"
        let date = dateformatter.dateFromString("2016-08-01")
        goalData.goalDate = date!
        
        //If I fail, I will
        goalData.goalFailStatus = 3
        
        //select a support
        goalData.supporterName = "Alex"
        goalData.supporterPhoneNumber = "1234567890"
        
        
        //getting Goal Class
        let goalClass = PFObject(className: GOAL_CLASS_NAME)
        
        //geting current user logged in
        let user : PFObject = PFUser.currentUser()!
        
        //setting other values
        goalClass.setObject(user.objectId!, forKey: GOAL_USER_ID)
        goalClass.setObject(goalData.goal, forKey: GOAL_ENTER_GOAL)
        goalClass.setObject(goalData.goalDate, forKey: GOAL_DATE)
        goalClass.setObject(goalData.goalFailStatus, forKey: GOAL_FAIL_STATUS)
        goalClass.setObject(goalData.supporterPhoneNumber, forKey: GOAL_SUPPORTER_NAME)
        goalClass.setObject(goalData.supporterPhoneNumber, forKey: GOAL_SUPPORTER_PHONE_NUMBER)
        
        // save
        goalClass.saveInBackgroundWithBlock { (succeeded, error) in
            
            if succeeded {
                print("Goal Saved.")
                return
            }
            
            print("Save was failed.")
            return
        }
    }
}

class TextField: UITextField {
    let padding = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5);
    
    override func textRectForBounds(bounds: CGRect) -> CGRect {
        return UIEdgeInsetsInsetRect(bounds, padding)
    }
    
    override func placeholderRectForBounds(bounds: CGRect) -> CGRect {
        return UIEdgeInsetsInsetRect(bounds, padding)
    }
    
    override func editingRectForBounds(bounds: CGRect) -> CGRect {
        return UIEdgeInsetsInsetRect(bounds, padding)
    }
}
