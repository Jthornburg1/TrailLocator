//
//  MapTrail.swift
//  GetToTrails
//
//  Created by Jon Thornburg on 6/7/16.
//  Copyright © 2016 Jon Thornburg. All rights reserved.
//

import Foundation
import CoreLocation
import MapKit
import GoogleMaps

struct MapTrail {
    func openMapForTrail(_ lat: NSNumber?, long: NSNumber?, trail: String?) {
        let latitude: CLLocationDegrees = (lat?.doubleValue)!
        let longitude: CLLocationDegrees = (long?.doubleValue)!
        
        let regionDistance: CLLocationDistance = 10000
        let coordinates = CLLocationCoordinate2DMake(latitude, longitude)
        let regionSpan = MKCoordinateRegionMakeWithDistance(coordinates, regionDistance, regionDistance)
        let options = [MKLaunchOptionsMapCenterKey: NSValue(mkCoordinate: regionSpan.center), MKLaunchOptionsMapSpanKey: NSValue(mkCoordinateSpan: regionSpan.span)]
        let placemark = MKPlacemark(coordinate: coordinates, addressDictionary: nil)
        let mapItem = MKMapItem(placemark: placemark)
        mapItem.name = trail
        mapItem.openInMaps(launchOptions: options)
    }
    
    func openGoogleMapsForTrail(_ lat: NSNumber?, long: NSNumber?, trail: String?) {
        if (UIApplication.shared.canOpenURL(URL(string: "comgooglemaps://")!)) {
            UIApplication.shared.openURL(URL(string: "comgooglemaps://?saddr=&daddr=\(lat!),\(long!)&directionsmode=driving")!)
        } else {
            print("Can't use comgooglemaps://")
        }
    }
}
