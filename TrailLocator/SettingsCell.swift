//
//  SettingsCell.swift
//  GetToTrails
//
//  Created by Jon Thornburg on 8/12/16.
//  Copyright © 2016 Jon Thornburg. All rights reserved.
//

import Foundation
import UIKit

class SettingsCell: UITableViewCell {
    
    let defaults = UserDefaults.standard
    
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBAction func controlSwitched(_ sender: AnyObject) {
        if segmentedControl.selectedSegmentIndex == 0 {
            defaults.set(true, forKey: "Google")
            defaults.set(false, forKey: "Apple")
            defaults.set(true, forKey: "MapsChosen")
        } else if segmentedControl.selectedSegmentIndex == 1 {
            defaults.set(true, forKey: "Apple")
            defaults.set(false, forKey: "Google")
            defaults.set(true, forKey: "MapsChosen")
        }
    }
    
}
