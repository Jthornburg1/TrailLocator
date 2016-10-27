//
//  TrailDict.swift
//  Swoopy
//
//  Created by Jon Thornburg on 4/20/16.
//  Copyright © 2016 Jon Thornburg. All rights reserved.
//

import Foundation

open class TrailDict {
    
    var city: String?
    var state: String?
    var name: String?
    var lat: NSNumber?
    var long: NSNumber?
    var described1: String?
    var described2: String?
    var described3: String?
    var activities1: String?
    var activities2: String?
    var activities3: String?
    var thumbnail1: String?
    var thumbnail2: String?
    var thumbnail3: String?
    var url1: String?
    var url2: String?
    var url3: String?
    var actArray: NSArray?
    
    
    
    open func fromDictionary(_ dictionary: [String : AnyObject]) -> TrailDict{
        
        if let city = dictionary["city"] as? String {
            self.city = city
        }
        
        if let state = dictionary["state"] as? String {
            self.state = state
        }
        
        if let name = dictionary["name"] as? String {
            self.name = name
        }
        
        if let lat = dictionary["lat"] as? NSNumber {
            self.lat = lat
        }
        
        if let long = dictionary["lon"] as? NSNumber {
            self.long = long
        }
        
        self.actArray = JsonDigger.getNestedArray(dictionary, key: "activities")
        
        print(actArray!.count)
        
        self.activities1 = JsonDigger.getNestedValues(actArray!, index: 0, key: "activity_type_name")
        
        self.activities2 = JsonDigger.getNestedValues(actArray!, index: 1, key: "activity_type_name")
        
        self.activities3 = JsonDigger.getNestedValues(actArray!, index: 2, key: "activity_type_name")
        
        self.described1 = JsonDigger.getNestedValues(actArray!, index: 0, key: "description")
        
        self.described2 = JsonDigger.getNestedValues(actArray!, index: 1, key: "description")
        
        self.described3 = JsonDigger.getNestedValues(actArray!, index: 2, key: "description")
        
        self.thumbnail1 = JsonDigger.getNestedValues(actArray!, index: 0, key: "thumbnail")
        
        self.thumbnail2 = JsonDigger.getNestedValues(actArray!, index: 1, key: "thumbnail")
        
        self.thumbnail3 = JsonDigger.getNestedValues(actArray!, index: 2, key: "thumbnail")
        
        self.url1 = JsonDigger.getNestedValues(actArray!, index: 0, key: "url")
        
        self.url2 = JsonDigger.getNestedValues(actArray!, index: 1, key: "url")
        
        self.url3 = JsonDigger.getNestedValues(actArray!, index: 2, key: "url")


        return self
    }
}
