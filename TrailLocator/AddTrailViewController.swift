//
//  AddTrailViewController.swift
//  TrailLocator
//
//  Created by Jon Thornburg on 11/23/16.
//  Copyright © 2016 Jon Thornburg. All rights reserved.
//

import Foundation
import UIKit
import Photos

class AddTrailViewController: UIViewController {
    
    @IBOutlet weak var instructionLabel: UILabel!
    @IBOutlet weak var descriptionInstructionLabel: UILabel!
    @IBOutlet weak var descriptionView: UIView!
    @IBOutlet weak var rightViewLayoutConstraint: NSLayoutConstraint!
    @IBOutlet weak var leftViewLayoutConstraint: NSLayoutConstraint!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var toolbar: UIToolbar!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var cityText: UITextField!
    @IBOutlet weak var stateText: UITextField!
    @IBOutlet weak var useText: UITextField!
    @IBOutlet weak var trailNameText: UITextField!
    @IBOutlet weak var urlText: UITextField!
    @IBOutlet weak var deskButton: UIButton!
    @IBOutlet weak var trailUseButton: UIButton!
    @IBOutlet weak var activityPickerContainer: UIView!
    @IBOutlet weak var activityPicker: UIPickerView!
    @IBOutlet weak var pickerRightConstraint: NSLayoutConstraint!
    @IBOutlet weak var pickerLeftConstraint: NSLayoutConstraint!
    @IBOutlet weak var pickerViewButton: UIButton!
    @IBOutlet weak var addPhotoButton: UIButton!
   
    var selectedActivity = "Mountain-Biking"
    var activities = ["Mountain-Biking", "Hiking", "Camping", "Snow-Sports"]
    let defaults = UserDefaults.standard
    var image: UIImage?
    var descr: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureDescriptionView()
        configurePickerView()
        titleLabel.textColor = UIColor.tryBlue()
        toolbar.barTintColor = UIColor.myOrange()
        toolbar.tintColor = UIColor.tryBlue()
        instructionLabel.textColor = UIColor.myOrange()
        UIApplication.shared.setStatusBarHidden(true, with: .none)
        deskButton.tintColor = UIColor.tryBlue()
        activityPicker.delegate = self
        urlText.delegate = self
        urlText.textColor = UIColor.myOrange()
        cityText.delegate = self
        cityText.textColor = UIColor.myOrange()
        stateText.delegate = self
        stateText.textColor = UIColor.myOrange()
        trailNameText.delegate = self
        trailNameText.textColor = UIColor.myOrange()
        pickerViewButton.setTitle("OK", for: .normal)
        pickerViewButton.backgroundColor = UIColor.tryBlue()
        pickerViewButton.setTitleColor(UIColor.white, for: .normal)
        pickerViewButton.layer.cornerRadius = 10
        trailUseButton.tintColor = UIColor.tryBlue()
        useText.isHidden = true
        useText.textColor = UIColor.myOrange()
    }
    
    @IBAction func saveDescriptionTapped(_ sender: Any) {
        animateConstraint(constraint: rightViewLayoutConstraint, endConstant: -400, duration: 0.5)
        animateConstraint(constraint: leftViewLayoutConstraint, endConstant: -400, duration: 0.5)
        instructionLabel.isHidden = false
        descr = descriptionTextView.text
        print(descr!)
    }
    
    @IBAction func cancelTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    @IBAction func descriptionTapped(_ sender: Any) {
        hideKeyBoard()
        animateConstraint(constraint: rightViewLayoutConstraint, endConstant: 0.0, duration: 0.5)
        animateConstraint(constraint: leftViewLayoutConstraint, endConstant: 0.0, duration: 0.5)
        instructionLabel.isHidden = true
    }
    
    @IBAction func setPickerView(_ sender: Any) {
        
        // need to set textfield here
        animateConstraint(constraint: pickerRightConstraint, endConstant: -400, duration: 0.5)
        animateConstraint(constraint: pickerLeftConstraint, endConstant: -400, duration: 0.5)
        useText.isHidden = false
        useText.text = selectedActivity

    }
    
    @IBAction func submitTapped(_ sender: Any) {
        
    }
    @IBAction func addPhotoClicked(_ sender: Any) {
        showLibrary()
    }
    
    @IBAction func addUseTapped(_ sender: Any) {
        hideKeyBoard()
        animateConstraint(constraint: pickerRightConstraint, endConstant: 0.0, duration: 0.5)
        animateConstraint(constraint: pickerLeftConstraint, endConstant: 0.0, duration: 0.5)
    }
    
    func animateConstraint(constraint: NSLayoutConstraint, endConstant: CGFloat, duration: Double) {
        UIView.animate(withDuration: duration, animations: {
            constraint.constant = endConstant
            self.view.layoutIfNeeded()
            self.useText.resignFirstResponder()
        })
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
    
    func configurePickerView() {
        activityPickerContainer.backgroundColor = UIColor.myOrange()
        activityPickerContainer.layer.cornerRadius = 5
        pickerLeftConstraint.constant = -400
        pickerRightConstraint.constant = -400
        activityPicker.tintColor = UIColor.tryBlue()
    }
}

extension AddTrailViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
        return 200
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return activities.count
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedActivity = activities[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        let attributes = [NSForegroundColorAttributeName:UIColor.tryBlue()]
        return NSAttributedString(string: activities[row], attributes: attributes)
    }

}

extension AddTrailViewController: UITextFieldDelegate {
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if textField.tag == 5 {
            
        }
       return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        if textField.tag == 5 {
            addAlertToDiscourageFilthUrl()
        }
        return true
    }
    
    func hideKeyBoard() {
        cityText.resignFirstResponder()
        stateText.resignFirstResponder()
        trailNameText.resignFirstResponder()
        urlText.resignFirstResponder()
    }
}

extension AddTrailViewController {
    // make alerts
    func addAlertToDiscourageFilthUrl() {
        let alert = UIAlertController(title: "Keep it clean", message: "Remember, you are logged in so this url can, ultimately, be traced back to you.", preferredStyle: .alert)
        let action1 = UIAlertAction(title: "Never mind", style: .default, handler: { (action1) -> Void in
            self.urlText.text = ""
        })
        let action2 = UIAlertAction(title: "That's fine", style: .cancel, handler: nil)
        
        alert.addAction(action1)
        alert.addAction(action2)
        present(alert, animated: true, completion: nil)
    }
    
    func secondPermissionAlert() {
        let alert = UIAlertController(title: "Library access", message: "To enable this function, TrailLocator needs access to this phone's photo-library", preferredStyle: .alert)
        let action1 = UIAlertAction(title: "Deny", style: .default, handler: nil)
        let action2 = UIAlertAction(title: "Ok", style: .cancel, handler: {(alert) -> Void in
            UIApplication.shared.openURL(URL(string: UIApplicationOpenSettingsURLString)!)
        })
        alert.addAction(action1)
        alert.addAction(action2)
        present(alert, animated: true, completion: nil)
    }
}

extension AddTrailViewController: UINavigationControllerDelegate, UIScrollViewDelegate, UIImagePickerControllerDelegate {
    
    func showLibrary() {
        checkLibraryAccess { (tORf) in
            if tORf {
                let imagePicker = UIImagePickerController()
                imagePicker.delegate = self
                imagePicker.sourceType = UIImagePickerControllerSourceType.photoLibrary
                self.present(imagePicker, animated: true, completion: nil)
            } else {
                if self.defaults.bool(forKey: "photoPermission") {
                    self.secondPermissionAlert()
                }
                PHPhotoLibrary.requestAuthorization({ (status: PHAuthorizationStatus) in
                    switch status {
                    case .authorized:
                        let imagePicker = UIImagePickerController()
                        imagePicker.delegate = self
                        imagePicker.sourceType = UIImagePickerControllerSourceType.photoLibrary
                        self.defaults.set(true, forKey: "photoPermission")
                        self.present(imagePicker, animated: true, completion: nil)
                    case .denied:
                        self.defaults.set(true, forKey: "photoPermission")
                        return
                    case .notDetermined:
                        self.defaults.set(true, forKey: "photoPermission")
                        return
                    default:
                        break
                    }
                })
            }
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            self.image = image
        }
        
        picker.dismiss(animated: true, completion: nil)
    }
    
    func checkLibraryAccess(_ completion: (Bool) -> Void) {
        let libraryAuth = PHPhotoLibrary.authorizationStatus()
        var tOrF = false
        switch libraryAuth {
        case .authorized:
            tOrF = true
            break
        case .denied:
            tOrF = false
            break
        case .notDetermined:
            tOrF = false
            break
        default:
            tOrF = false
            break
        }
        completion(tOrF)
    }
}
