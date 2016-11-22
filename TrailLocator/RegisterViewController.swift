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

enum LoginType: String {
    case faisbook = "facebook"
    case email = "email"
}

class RegisterViewController: UIViewController, FBSDKLoginButtonDelegate, UITextFieldDelegate {
    
    @IBOutlet weak var loggedInLabel: UILabel!
    @IBOutlet weak var textFieldContainer: UIView!
    @IBOutlet weak var toolBar: UIToolbar!
    @IBOutlet weak var fbButton: FBSDKLoginButton!
    
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
        
        loggedInLabel.text = "You're logged in."
        
        
        if defaults.bool(forKey: "userLoggedIn") == true {
            
        } else {
            
        }
        
    }
    
    func configureLoginButton(button: FBSDKLoginButton) {
        
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
