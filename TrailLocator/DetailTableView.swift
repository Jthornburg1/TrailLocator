//
//  DetailTableView.swift
//  GetToTrails
//
//  Created by Jon Thornburg on 5/17/16.
//  Copyright © 2016 Jon Thornburg. All rights reserved.
//

import Foundation
import UIKit

class DetailTableView: UITableViewController {
    
    
    var trail = TrailDict()
    let sorter = PropertySorter()
    let defaults = UserDefaults.standard
    var webUrl: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        defaults.setBool(false, forKey: "Google")
//        defaults.setBool(false, forKey: "Apple")
//        defaults.setBool(false, forKey: "MapsChosen")
        
        let bundle = Bundle(identifier: "clickHereLabs.TrailLocator")
        let cellNib = UINib(nibName: "DetailCell", bundle: bundle)
        
        tableView.register(cellNib, forCellReuseIdentifier: "DetailCell")
        
        self.tableView.estimatedRowHeight = 120
        self.tableView.rowHeight = UITableViewAutomaticDimension
        
        self.tableView.setNeedsLayout()
        self.tableView.layoutIfNeeded()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        UIApplication.shared.setStatusBarHidden(false, with: .none)
    }
    
    @IBAction func mapButtonTapped(_ sender: AnyObject) {
        if defaults.bool(forKey: "MapsChosen") == false {
            self.showAlert()
        }
        if defaults.bool(forKey: "Google") {
            self.googleMaps()
        }
        if defaults.bool(forKey: "Apple") {
            self.appleMaps()
        }
    }
    
    // TableView DataSource methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    
        if let arr: NSArray = trail.actArray {
            return arr.count
        } else {
            return 1
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DetailCell") as! DetailCell
        if trail.actArray != nil {
            let trailImage = sorter.getThumbnail(trail, ind: (indexPath as NSIndexPath).row)
            cell.trailImage.downloadFrom(link: trailImage, contentMode: UIViewContentMode.scaleAspectFit)
            if cell.trailImage.image == nil {
                cell.trailImage.image = UIImage(named: "placeholder")
            }
            cell.activityLabel.text = sorter.getActivities(trail, ind: (indexPath as NSIndexPath).row)
            cell.nameLabel.text = trail.name
            let cleanText = sorter.getDescription(trail, ind: (indexPath as NSIndexPath).row).removeHTML()
            cell.descriptionLabel.text = cleanText
        } else {
            cell.trailImage.image = UIImage(named: "placeholder")
            cell.descriptionLabel.text = "There is no description of \(trail.name!)"
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if let url = sorter.getURL(trail, ind: (indexPath as NSIndexPath).row) {
            self.webUrl = url
            performSegue(withIdentifier: "webSegue", sender: self)
        } else {
            let act = sorter.getActivities(trail, ind: (indexPath as NSIndexPath).row)
            showNoUrlAlert(act, trail: trail.name!)
        }
    }
    
    func mapChosen() {
        defaults.set(true, forKey: "MapsChosen")
    }
    
    func chooseGoogle() {
        defaults.set(true, forKey: "Google")
    }
    
    func chooseApple() {
        defaults.set(true, forKey: "Apple")
    }
    
    func googleMaps() {
        let mapper = MapTrail()
        mapper.openGoogleMapsForTrail(self.trail.lat!, long: self.trail.long!, trail: self.trail.name!)

    }
    
    func appleMaps() {
        let mapper = MapTrail()
        if self.trail.lat != nil {
            if self.trail.long != nil {
                mapper.openMapForTrail(self.trail.lat!, long: self.trail.long!, trail: self.trail.name!)
            }
        }
    }
    
    func showAlert() {
        let alert = UIAlertController(title: "You have a Choice.", message: "This app supports both GoogleMaps and AppleMaps. Which would you prefer to use?", preferredStyle: .actionSheet)
        let googleAction = UIAlertAction(title: "GoogleMaps", style: .default) { (googleAction) in
            self.chooseGoogle()
            self.mapChosen()
            self.googleMaps()
        }
        let appleAction = UIAlertAction(title: "AppleMaps", style: .default) { (appleAction) in
            self.chooseApple()
            self.mapChosen()
            self.appleMaps()
        }
        alert.addAction(googleAction)
        alert.addAction(appleAction)
        let coolGreen = UIColor(red: 21/255, green: 180/255, blue: 50/255, alpha: 1)
        alert.view.tintColor = coolGreen
        self.present(alert, animated: true, completion: nil)
    }
    
    func showNoUrlAlert(_ act: String, trail: String) {
        let alert = UIAlertController(title: "Unavailable", message: "\(trail) does not have a webpage for \(act)", preferredStyle: .alert)
        let action = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
        alert.view.tintColor = UIColor.red
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "webSegue" {
            let nav = segue.destination as! UINavigationController
            let vc = nav.topViewController as! WebViewController
            vc.str = self.webUrl!
        }
    }
}
