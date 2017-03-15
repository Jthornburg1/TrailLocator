//
//  AddNewTrailViewController.swift
//  TrailLocator
//
//  Created by Ben Taitelbaum on 3/10/17.
//  Copyright © 2017 Jon Thornburg. All rights reserved.
//

import UIKit
import GooglePlaces

class AddNewTrailViewController: UIViewController {

    @IBOutlet weak var chooseCityButton: UIButton!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var stateLabel: UILabel!
    @IBOutlet weak var countryLabel: UILabel!
    @IBOutlet weak var latLabel: UILabel!
    @IBOutlet weak var longLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func didTapChooseCity(_ sender: Any) {
        let chooseVC = GMSAutocompleteViewController()
        let filter = GMSAutocompleteFilter()
        filter.type = .city
        chooseVC.autocompleteFilter = filter
        chooseVC.delegate = self
        present(chooseVC, animated: true, completion: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
