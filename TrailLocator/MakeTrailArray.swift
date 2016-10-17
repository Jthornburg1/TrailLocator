//
//  File.swift
//  TrailLocator
//
//  Created by jonathan thornburg on 10/16/16.
//  Copyright © 2016 Jon Thornburg. All rights reserved.
//

import Foundation

struct MakeTrailArray {
    
    static func makeTrails(term: String, completion: @escaping (_ trails: [TrailDict]) -> Void) {
        let trail = TrailDict()
        var trails = [TrailDict]()
        if let encodedTerm = term.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed) {
            let trailSearchString = "https://outdoor-data-api.herokuapp.com/api.json?api_key=d6d33ee90666c461d901c731cc104b79&q[city_cont]=\(encodedTerm)"
            APIService.getDictionary(urlString: trailSearchString) { (dictionary) in
                if let dict = dictionary {
                    if let places = dict["places"] as? [[String : AnyObject]]{
                        for place in places {
                            let newTrail = trail.fromDictionary(place)
                            trails.append(newTrail)
                        }
                        DispatchQueue.main.async(execute: {
                            completion(trails)
                        })
                    }
                }
            }
        }
    }
}
