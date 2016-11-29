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
    
    func addTestNode() {
        let pathString = "Jon/wants/to/see/if/he/can/post/while/logged/out"
        let dict = ["Maybe" : false]

        let update = [pathString : dict]
        ref.updateChildValues(update)
    }
    
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
    
    // Storage
    func storImageToFirebase(image: UIImage, pathString: String, completion: @escaping (Bool, URL?) -> Void) {
        let storageRef = FIRStorage.storage().reference().child(pathString)
        let smallImage = image.resizeWithPercentage(percentage: 0.2)
        if let uploadData = UIImagePNGRepresentation(smallImage!) {
            storageRef.put(uploadData, metadata: nil, completion: { (metaData, error) in
                if error != nil {
                    DispatchQueue.main.async(execute: { 
                        completion(false, nil)
                    })
                } else {
                    let str = metaData?.downloadURL()
                    DispatchQueue.main.async(execute: { 
                        completion(true, str)
                    })
                }
            })
        }
    }
    
    func addNewTrail(trail: TrailDict) {
        
    }
}



//fireCalls.authenticate(email, password: password) { (success, uid) in
//    if success {
//        var imag: UIImage?
//        
//        if self.photoChosen == true {
//            if let img = self.profileImageView.image {
//                imag = img
//                self.fireCalls.storeImageToFirebase(imag!, pathString: uid!, completion: { (success, urlString) in
//                    if success {
//                        let str = String(urlString!)
//                        self.fireCalls.addUserToDatabase(uid!, name: name, password: password, email: email, image: str, completion: { (success, error) in
//                            if success {
//                                print("success")
//                                let notif = NSNotification(name: "registered", object: nil)
//                                self.noifications.postNotification(notif)
//                                self.dismissViewControllerAnimated(true, completion: nil)
//                            } else {
//                                self.showAlert("Failed to save", message: "Please re-enter the data")
//                                self.clearFields()
//                            }
//                        })
//                    }
//                })
//            }
//        } else {
//            self.fireCalls.addUserToDatabase(uid!, name: name, password: password, email: email, image: "", completion: { (success, error) in
//                if success {
//                    print("success")
//                    let notif = NSNotification(name: "registered", object: nil)
//                    self.noifications.postNotification(notif)
//                    self.dismissViewControllerAnimated(true, completion: nil)
//                } else {
//                    self.showAlert("Failed to save", message: "Please re-enter the data")
//                    self.clearFields()
//                }
//            })
//            
//        }
//    } else {
//        self.showAlert("Failure.", message: "You'll never cut it on this app because you produced an error!")
//    }
//}
//
