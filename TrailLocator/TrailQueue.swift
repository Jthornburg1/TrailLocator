//
//  TrailQueue.swift
//  Swoopy
//
//  Created by Jon Thornburg on 4/20/16.
//  Copyright © 2016 Jon Thornburg. All rights reserved.
//

import Foundation

struct TrailQueue {
    
    let downloadQueue: OperationQueue = {
        var queue = OperationQueue()
        queue.name = "Download Queue"
        queue.maxConcurrentOperationCount = 1
        return queue
    }()
    
    func getTrails(_ city: String, completionHandler: @escaping (_ resultData: Data?, _ error: NSError?) -> Void) {
        print("Get Trails")
        
//        let operation = TrailOperation(query: city, handler: completionHandler)
//        downloadQueue.addOperation(operation)
        
    }
    
}
