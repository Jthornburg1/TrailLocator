//
//  RegisterViewController.swift
//  TrailLocator
//
//  Created by Jon Thornburg on 9/6/16.
//  Copyright © 2016 Jon Thornburg. All rights reserved.
//

import Foundation
import UIKit
import FBSDKLoginKit
import Firebase
import GoogleSignIn

enum LoginType: String {
    case faisbook = "Facebook"
    case google = "Google"
    case none = "Not Logged in"
    case unRegistered = "Not Registered"
}

class RegisterViewController: UIViewController, FBSDKLoginButtonDelegate, UITextFieldDelegate {
    
    @IBOutlet weak var loggedInLabel: UILabel!
    @IBOutlet weak var textFieldContainer: UIView!
    @IBOutlet weak var toolBar: UIToolbar!
    @IBOutlet weak var fbButton: FBSDKLoginButton!
    @IBOutlet weak var googelSignInButton: GIDSignInButton!
    
    let fireLog = FirebaseAuth()
    let fireGet = SprayFirebase()
    let defaults = UserDefaults()
    var loginType: LoginType?
    var emailAuthentic: Bool?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        UIApplication.shared.setStatusBarHidden(true, with: .none)
        fbButton.delegate = self
        toolBar.barTintColor = UIColor.tryBlue()
        toolBar.tintColor = UIColor.white
        
        setLoginType()
        buildDisplayString()
        
        
        if defaults.bool(forKey: "userLoggedIn") == true {
            
        }
    }
    
    func buildDisplayString() {
        if let logtype = loginType {
            switch logtype {
            case LoginType.faisbook:
                loggedInLabel.text = "You're logged in with Facebook."
                googelSignInButton.isEnabled = false
            case LoginType.google:
                loggedInLabel.text = "You're logged in with Google."
                fbButton.isEnabled = false
            case LoginType.none:
                fbButton.isEnabled = true
                googelSignInButton.isEnabled = true
                loggedInLabel.text = "You're not logged in."
            case LoginType.unRegistered:
                fbButton.isEnabled = true
                googelSignInButton.isEnabled = true
                loggedInLabel.text = "You've not registered yet."
            default:
                print("default")
            }
        } else {
            loggedInLabel.text = "You've not registered yet."
        }
    }
    
    func setLoginType() {
        if defaults.object(forKey: "LoggedInWith") as? String == "Google" {
            loginType = LoginType.google
        } else if defaults.object(forKey: "LoggedInWith") as? String == "Facebook" {
            loginType = LoginType.faisbook
        } else if defaults.object(forKey: "LoggedInWith") as? String == "None" {
            loginType = LoginType.none
        } else if defaults.object(forKey: "LoggedInWith") as? String == nil {
            loginType = LoginType.unRegistered
        }
    }
    
    func configureLoginButton(button: FBSDKLoginButton) {
        button.tintColor = UIColor.white
    }
    
   
    @IBAction func dismissTapped(_ sender: AnyObject) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    //FBSDKLoginButtonDelegate
    func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error!) {
        if Reachable.isConnectedToNetwork() {
            print("loggedIn")
            if let token = FBSDKAccessToken.current().tokenString {
                let credential = FIRFacebookAuthProvider.credential(withAccessToken: token)
                FIRAuth.auth()?.signIn(with: credential, completion: { (user, error) in
                    print("logged into both")
                    self.defaults.set(true, forKey: "userLoggedIn")
                    self.loginType = LoginType.faisbook
                })

            } else {
                
            }
        } else {
            let alert = UIAlertController(title: "Error", message: "Your network connection is bad. Try logging in again when it's better.", preferredStyle: .alert)
            let action = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
            alert.addAction(action)
            present(alert, animated: true, completion: nil)
        }
    }
    
    func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!) {
        fireLog.logoutOfFirebase()
        defaults.set(false, forKey: "userLoggedIn")
        loginType = nil
        print("loggedout")
    }
}
