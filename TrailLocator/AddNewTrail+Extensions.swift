//
//  AddNewTrail+Extensions.swift
//  TrailLocator
//
//  Created by Ben Taitelbaum on 3/10/17.
//  Copyright © 2017 Jon Thornburg. All rights reserved.
//

import Foundation
import UIKit
import GooglePlaces

extension AddNewTrailViewController : GMSAutocompleteViewControllerDelegate {
    
    func viewController(_ viewController: GMSAutocompleteViewController, didAutocompleteWith place: GMSPlace) {
        
        //let stringArray = place.name.components(separatedBy: <#T##String#>)
        
        if let components = place.addressComponents {
            for item in components {
                switch item.type {
                case kGMSPlaceTypeLocality:
                    nameLabel.text = item.name
                case kGMSPlaceTypeCountry:
                    countryLabel.text = item.name
                case kGMSPlaceTypeAdministrativeAreaLevel1:
                    stateLabel.text = item.name
                default:
                    break
                }
                
            }
        }
        
        let lat = String(describing: place.coordinate.latitude)
        let long = String(describing: place.coordinate.longitude)
        latLabel.text = lat
        longLabel.text = long
        
        print("Place: \(place.formattedAddress)")
        dismiss(animated: true, completion: nil)
    }
    
    func viewController(_ viewController: GMSAutocompleteViewController, didFailAutocompleteWithError error: Error) {
        
    }
    
    func wasCancelled(_ viewController: GMSAutocompleteViewController) {
        dismiss(animated: true, completion: nil)
    }
}
