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

class RegisterViewController: UIViewController {
    
    @IBOutlet weak var userTextHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var usernameSeparator: UIView!
    @IBOutlet weak var usernameText: UITextField!
    @IBOutlet weak var passwordText: UITextField!
    @IBOutlet weak var emailText: UITextField!
    @IBOutlet weak var uploadPhotoButton: UIButton!
    @IBOutlet weak var submitButton: UIButton!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    override func viewDidLoad() {
        super.viewDidLoad()
        segmentedControl.selectedSegmentIndex = 0
        uploadPhotoButton.layer.cornerRadius = 5
        submitButton.layer.cornerRadius = 5
        
        let fbLoginButton = FBSDKLoginButton()
        //fbLoginButton.center = CGPoint(x:, y: <#T##CGFloat#>)
        view.addSubview(fbLoginButton)
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
}
