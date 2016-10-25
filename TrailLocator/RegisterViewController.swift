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

class RegisterViewController: UIViewController, FBSDKLoginButtonDelegate {
    
    @IBOutlet weak var userTextHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var usernameSeparator: UIView!
    @IBOutlet weak var usernameText: UITextField!
    @IBOutlet weak var passwordText: UITextField!
    @IBOutlet weak var emailText: UITextField!
    @IBOutlet weak var uploadPhotoButton: UIButton!
    @IBOutlet weak var submitButton: UIButton!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var loginView: UIView!
    @IBOutlet weak var fbLoginButton: FBSDKLoginButton!
    @IBOutlet weak var topBar: UIToolbar!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        topBar.barTintColor = UIColor.tryBlue()
        topBar.tintColor = UIColor.white
        segmentedControl.selectedSegmentIndex = 0
        uploadPhotoButton.layer.cornerRadius = 5
        submitButton.layer.cornerRadius = 5
        
        self.fbLoginButton.readPermissions = ["public_profile", "email", "user_friends"]
        
        self.fbLoginButton.delegate = self
    }
    
    func configureLoginButton(button: FBSDKLoginButton) {
        
    }
    
    @IBAction func uploadPhotoClicked(_ sender: AnyObject) {
    }
    @IBAction func submitClicked(_ sender: AnyObject) {
        
        guard let email = emailText.text, let password = passwordText.text, let username = usernameText.text else {
            
            showFieldsEmptyAlert()
            
            return
        }
    }
    @IBAction func segmentValueChanged(_ sender: AnyObject) {
        if segmentedControl.selectedSegmentIndex == 0 {
            isRegister()
        } else {
            isLogin()
        }
    }
    @IBAction func dismissTapped(_ sender: AnyObject) {
        self.dismiss(animated: true, completion: nil)
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
        print("loggedIn")
            let credential = FIRFacebookAuthProvider.credential(withAccessToken: FBSDKAccessToken.current().tokenString)
        FIRAuth.auth()?.signIn(with: credential, completion: { (user, error) in
            print("logged into both")
        })
    }
    
    func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!) {
        print("loggedout")
    }
}
