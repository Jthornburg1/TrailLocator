//
//  AppDelegate.swift
//  TrailLocator
//
//  Created by Jon Thornburg on 9/2/16.
//  Copyright © 2016 Jon Thornburg. All rights reserved.
//

import UIKit
import CoreData
import Firebase
import GoogleMaps
import FBSDKCoreKit
import FBSDKLoginKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    let defaults = UserDefaults()

    // Create login Debug facebook issue. 
    // Allow addition of trail items
    // deal with posibility of innappropriate material
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        UINavigationBar.appearance().barTintColor = UIColor.myOrange()
        UINavigationBar.appearance().tintColor = UIColor.tryBlue()
        
        UIToolbar.appearance().tintColor = UIColor.tryBlue()
        
        GMSServices.provideAPIKey("AIzaSyAeYQF6v9KtP3mUYdOXp8m_fOYtctnIBEk")
        
        FBSDKApplicationDelegate.sharedInstance().application(application, didFinishLaunchingWithOptions: launchOptions)
        
        let firebaseGet = SprayFirebase()
        firebaseGet.getEveryTrail { (dict, error) in
            
        }
        
        for family: String in UIFont.familyNames
        {
            print("\(family)")
            for names: String in UIFont.fontNames(forFamilyName: family)
            {
                print("== \(names)")
            }
        }

        UIApplication.shared.statusBarStyle = .lightContent
        return true
    }
    
    override init() {
        FIRApp.configure()
        FIRDatabase.database().persistenceEnabled = true
    }
    
    func application(_ application: UIApplication, open url: URL, sourceApplication: String?, annotation: Any) -> Bool {
        return FBSDKApplicationDelegate.sharedInstance().application(application,
                                                                     open: url,
                                                                     sourceApplication: sourceApplication,
                                                                     annotation: annotation)
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        
    }
    
    private func application(application: UIApplication, openURL url: NSURL, sourceApplication: String?, annotation: AnyObject) -> Bool {
        return true
    }
}

