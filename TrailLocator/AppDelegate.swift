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

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    // Create login. 
    // Allow addition of trail items
    // deal with posibility of innappropriate material
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        UINavigationBar.appearance().backgroundColor = UIColor.newGrey()
        UINavigationBar.appearance().tintColor = UIColor.diffGreen()
        
        return true
    }
    
    override init() {
        FIRApp.configure()
        FIRDatabase.database().persistenceEnabled = true
    }
}

