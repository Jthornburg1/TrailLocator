
//
//  CoreDataFiller.swift
//  Swoopy
//
//  Created by Jon Thornburg on 4/29/16.
//  Copyright © 2016 Jon Thornburg. All rights reserved.
//

import Foundation

/*protocol TrailsBuilder {
    func searchAPI(_ str1: String, str2: String?, str3: String?, handler:([TrailDict]!) -> Void)
}

class TrailsByCity: TrailsBuilder {
    internal func searchAPI(_ str1: String, str2: String?, str3: String?, handler: ([TrailDict]!) -> Void) {
        let trailQueue = TrailQueue()
        var trailerray = [TrailDict]()
        trailQueue.getTrails(str1, completionHandler: { (data, error) in
            if let dict: [String : AnyObject] = HttpWrapperImpl.jsonParser(resultsData) {
                if let trails = dict["places"] as? [[String : AnyObject]] {
                    for trail in trails {
                        let trailDict = TrailDict()
                        let newTrail = trailDict.fromDictionary(trail)
                        trailerray.append(newTrail)
                    }
                    DispatchQueue.main.async(execute: { () in
                        handler(trailerray)
                    })
                }
            }
        })

    }
}
*/
