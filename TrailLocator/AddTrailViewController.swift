//
//  AddTrailViewController.swift
//  TrailLocator
//
//  Created by Jon Thornburg on 11/23/16.
//  Copyright © 2016 Jon Thornburg. All rights reserved.
//

import Foundation
import UIKit

class AddTrailViewController: UIViewController {
    
    @IBOutlet weak var descriptionInstructionLabel: UILabel!
    @IBOutlet weak var descriptionView: UIView!
    @IBOutlet weak var rightViewLayoutConstraint: NSLayoutConstraint!
    @IBOutlet weak var leftViewLayoutConstraint: NSLayoutConstraint!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var toolbar: UIToolbar!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var cityText: UITextField!
    @IBOutlet weak var stateText: UITextField!
    @IBOutlet weak var deskButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureDescriptionView()
        titleLabel.textColor = UIColor.tryBlue()
        toolbar.barTintColor = UIColor.myOrange()
        toolbar.tintColor = UIColor.tryBlue()
        UIApplication.shared.setStatusBarHidden(true, with: .none)
        
        deskButton.tintColor = UIColor.tryBlue()
    }
    
    @IBAction func saveDescriptionTapped(_ sender: Any) {
    }
    
    @IBAction func cancelTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    @IBAction func descriptionTapped(_ sender: Any) {
        self.view.layoutIfNeeded()
        
    }
    
}

extension AddTrailViewController {
    
    func configureDescriptionView() {
        descriptionView.backgroundColor = UIColor.myOrange()
        descriptionView.layer.cornerRadius = 5
        descriptionInstructionLabel.textColor = UIColor.tryBlue()
        descriptionTextView.layer.borderColor = UIColor.tryBlue().cgColor
        descriptionTextView.layer.borderWidth = 2
        descriptionTextView.layer.cornerRadius = 5
        leftViewLayoutConstraint.constant = -400
        rightViewLayoutConstraint.constant = -400
    }
}
