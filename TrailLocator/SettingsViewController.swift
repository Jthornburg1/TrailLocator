//
//  SettingsViewController.swift
//  GetToTrails
//
//  Created by Jon Thornburg on 8/12/16.
//  Copyright © 2016 Jon Thornburg. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var toolbar: UIToolbar!
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let bundle = Bundle(identifier: "clickHereLabs.TrailLocator")
        let cellNib = UINib(nibName: "SettingsCell", bundle: bundle!)
        tableView.register(cellNib, forCellReuseIdentifier: "SettingsCell")
        tableView.rowHeight = 37
        tableView.isScrollEnabled = false
        toolbar.backgroundColor = UIColor.newGrey()
        view.backgroundColor = UIColor.newTan()
        toolbar.tintColor = UIColor.diffGreen()
    }
    
    @IBAction func backTapped(_ sender: AnyObject) {
        dismiss(animated: true, completion: nil)
    }
    
    //Datasource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 9
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        let settingsCell = tableView.dequeueReusableCell(withIdentifier: "SettingsCell") as? SettingsCell
        tableView.alwaysBounceVertical = false
        if (indexPath as NSIndexPath).row != 3 {
            cell?.selectionStyle = .none
            cell?.backgroundColor = UIColor.darkGray
            tableView.rowHeight = 44
            return cell!
        } else {
            tableView.rowHeight = 75
            settingsCell?.selectionStyle = .none
            if defaults.bool(forKey: "Google") {
                settingsCell?.segmentedControl.selectedSegmentIndex = 0
            } else if defaults.bool(forKey: "Apple") {
                settingsCell?.segmentedControl.selectedSegmentIndex = 1
            } else {
                settingsCell?.segmentedControl.selectedSegmentIndex = UISegmentedControlNoSegment
            }
            return settingsCell!
        }
    }
}
