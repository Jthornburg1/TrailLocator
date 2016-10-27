//
//  FirebaseGet.swift
//  GetToTrails
//
//  Created by Jon Thornburg on 8/3/16.
//  Copyright © 2016 Jon Thornburg. All rights reserved.
//

import Foundation
import Firebase
import FirebaseDatabase

protocol FirebaseSnapshot{
    func getSnapshot(_ node: String, completion: (_ dict: [String : AnyObject]) -> Void)
}

protocol FirebaseFillArray {
    func parseTrails(_ cityName: String, completion: (_ trails: [TrailDict]) -> Void)
}

protocol AddTrails {
    func addNewArray(_ city: String, trailArray: [TrailDict])
}

struct SprayFirebase: AddTrails {
    
    // provides a reference to the database
    let ref = FIRDatabase.database().reference()
    let digger = JsonDigger()
    
    func addNewArray(_ city: String, trailArray: [TrailDict]) {
        //Create an enormous nested dictionary
        
        var dict = [String : AnyObject]()
        var surfaceDict = [String : AnyObject]()
        var insideDict = [String : AnyObject]()
        for trail in trailArray {
            if let state = trail.state {
                insideDict["state"] = state as AnyObject?
            }
            if let desc1 = trail.described1 {
                insideDict["description1"] = desc1 as AnyObject?
            }
            if let desc2 = trail.described2 {
                insideDict["description2"] = desc2 as AnyObject?
            }
            if let desc3 = trail.described3 {
                insideDict["description3"] = desc3 as AnyObject?
            }
            if let act1 = trail.activities1 {
                insideDict["activities1"] = act1 as AnyObject?
            }
            if let act2 = trail.activities2 {
                insideDict["activities2"] = act2 as AnyObject?
            }
            if let act3 = trail.activities3 {
                insideDict["activities3"] = act3 as AnyObject?
            }
            if let thumb1 = trail.thumbnail1 {
                insideDict["thumbnail1"] = thumb1 as AnyObject?
            }
            if let thumb2 = trail.thumbnail2 {
                insideDict["thumbnail2"] = thumb2 as AnyObject?
            }
            if let thumb3 = trail.thumbnail3 {
                insideDict["thumbnail3"] = thumb3 as AnyObject?
            }
            if let u1 = trail.url1 {
                insideDict["url1"] = u1 as AnyObject?
            }
            if let u2 = trail.url2 {
                insideDict["url2"] = u2 as AnyObject?
            }
            if let u3 = trail.url3 {
                insideDict["url3"] = u3 as AnyObject?
            }
            
            surfaceDict[(trail.name?.prepareStringForFirebase())!] = insideDict as AnyObject?
        }
        dict[city] = surfaceDict as AnyObject?
        // Create a pathString
        let pathString = "cities/\(city)"
        let childUpdates = surfaceDict
        ref.child(pathString).setValue(childUpdates)
    }
    func practiceWrite() {
        let pathString = "this/is/a/test"
        let dict = ["Drives_a_thousand_miles_an_hour" : true]
        let childUpdates = [pathString : dict]
        ref.updateChildValues(childUpdates)
    }
    
    func getEveryTrail(completion: @escaping (_ trails: [String : AnyObject]?, _ error: NSError?) -> Void) {
        var dict = [String : AnyObject]()
        ref.child("cities").observe(FIRDataEventType.value, with: { (snapShot) in
            if let dct = snapShot.value as? [String : AnyObject] {
                dict = dct
                for (id, value) in dict {
                    print(id)
                    
                }
            }
        })
    }
}
