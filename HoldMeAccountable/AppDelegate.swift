//
//  AppDelegate.swift
//  HoldMeAccountable
//
//  Created by Alex on 7/13/16.
//  Copyright © 2016 Alex. All rights reserved.
//

import UIKit
import Fabric
import DigitsKit
import Parse

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        UINavigationBar.appearance().shadowImage = UIImage()
        UINavigationBar.appearance().setBackgroundImage(UIImage(), forBarMetrics: .Default)
        Fabric.with([Digits.self()])
        
        
        // Set up the Parse SDK
        let configuration = ParseClientConfiguration {
            $0.applicationId = "reli"
            $0.server = "https://reli-parse-ob.herokuapp.com/parse"
        }
        Parse.initializeWithConfiguration(configuration)
        return true
    }
    
    func applicationWillResignActive(application: UIApplication) {
    }
    
    func applicationDidEnterBackground(application: UIApplication) {
    }
    
    func applicationWillEnterForeground(application: UIApplication) {
    }
    
    func applicationWillTerminate(application: UIApplication) {
    }
}
