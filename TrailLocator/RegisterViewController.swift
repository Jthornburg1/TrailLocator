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

class RegisterViewController: UIViewController, FBSDKLoginButtonDelegate, UITextFieldDelegate {
    
    @IBOutlet weak var logoutButton: UIBarButtonItem!
    @IBOutlet weak var orSupplyLabel: UILabel!
    @IBOutlet weak var userTextHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var usernameSeparator: UIView!
    @IBOutlet weak var usernameText: UITextField!
    @IBOutlet weak var passwordText: UITextField!
    @IBOutlet weak var emailText: UITextField!
    @IBOutlet weak var submitButton: UIButton!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var loginView: UIView!
    @IBOutlet weak var fbLoginButton: FBSDKLoginButton!
    @IBOutlet weak var topBar: UIToolbar!
    @IBOutlet weak var textFieldContainer: UIView!
    
    let fireLog = FirebaseAuth()
    let fireGet = SprayFirebase()
    let defaults = UserDefaults()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if defaults.bool(forKey: "userLoggedIn") == true {
            hideAndDisable()
        } else {
            showAndEnable()
        }
        
        emailText.delegate = self
        passwordText.delegate = self
        usernameText.delegate = self
        
        topBar.barTintColor = UIColor.tryBlue()
        topBar.tintColor = UIColor.white
        segmentedControl.selectedSegmentIndex = 0
        submitButton.layer.cornerRadius = 5
        
        self.fbLoginButton.readPermissions = ["public_profile", "email", "user_friends"]
        
        self.fbLoginButton.delegate = self
    }
    
    func configureLoginButton(button: FBSDKLoginButton) {
        
    }
    
    @IBAction func submitClicked(_ sender: AnyObject) {
        
        if emailText.text == "" || usernameText.text == "" || passwordText.text == "" {
            showFieldsEmptyAlert()
        } else {
            FIRAuth.auth()?.createUser(withEmail: emailText.text!, password: passwordText.text!, completion: { (user, error) in
                print("We've got us a live 'un: \(self.usernameText.text!)")
                self.hideAndDisable()
            })
        }
    }
    @IBAction func segmentValueChanged(_ sender: AnyObject) {
        if segmentedControl.selectedSegmentIndex == 0 {
            isRegister()
        } else {
            isLogin()
        }
        fireGet.addTestNode()
    }
    @IBAction func dismissTapped(_ sender: AnyObject) {
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func logoutTapped(_ sender: Any) {
        fireLog.logoutOfFirebase()
        defaults.set(false, forKey: "userLoggedIn")
        fbLoginButton.sendActions(for: .touchUpInside)
        showAndEnable()
    }
    
    func isLogin() {
        userTextHeightConstraint.constant = 0
        usernameSeparator.isHidden = true
    }
    
    func isRegister() {
        userTextHeightConstraint.constant = 50
        usernameSeparator.isHidden = false
    }
    
    func showFieldsEmptyAlert() {
        let alert = UIAlertController(title: "Empty fields", message: "To create an account, you must fill all of the text fields in with valid entries.", preferredStyle: .alert)
        let action = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
        alert.view.tintColor = UIColor.red
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
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
                    self.hideAndDisable()
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
        showAndEnable()
        print("loggedout")
    }
    
    // TextField delegate
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        emailText.resignFirstResponder()
        usernameText.resignFirstResponder()
        passwordText.resignFirstResponder()
        return true
    }
    
    func hideAndDisable() {
        usernameText.isUserInteractionEnabled = false
        passwordText.isUserInteractionEnabled = false
        emailText.isUserInteractionEnabled = false
        textFieldContainer.isHidden = true
        orSupplyLabel.isHidden = true
        submitButton.isHidden = true
        submitButton.isUserInteractionEnabled = false
        segmentedControl.isHidden = true
        segmentedControl.isUserInteractionEnabled = false
        logoutButton.isEnabled = true
    }
    
    func showAndEnable() {
        usernameText.isUserInteractionEnabled = true
        passwordText.isUserInteractionEnabled = true
        emailText.isUserInteractionEnabled = true
        textFieldContainer.isHidden = false
        orSupplyLabel.isHidden = false
        submitButton.isHidden = false
        submitButton.isUserInteractionEnabled = true
        segmentedControl.isHidden = false
        segmentedControl.isUserInteractionEnabled = true
        logoutButton.isEnabled = false
    }
}
