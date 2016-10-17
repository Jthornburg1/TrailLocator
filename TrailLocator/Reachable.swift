//
//  Reachable.swift
//  Maker Lab
//
//  Created by Jon Thornburg on 3/31/16.
//  Copyright © 2016 Click Here Labs. All rights reserved.
//

import Foundation
import UIKit
import SystemConfiguration

open class Reachable: NSObject{
    
    static func isUrlAvailable(_ urlString: String) -> Bool {
        
        let url = URL(string: urlString)
        let request = NSMutableURLRequest(url: url!)
        
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        return true
    }
    
    static func isConnectedToNetwork() -> Bool{
      
        var zeroAddress = sockaddr_in()
        zeroAddress.sin_len = UInt8(MemoryLayout<sockaddr_in>.size)
        zeroAddress.sin_family = sa_family_t(AF_INET)
        
        guard let defaultRouteReachability = withUnsafePointer(to: &zeroAddress, {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {
                SCNetworkReachabilityCreateWithAddress(nil, $0)
            }
        }) else {
            return false
        }
        
        var flags: SCNetworkReachabilityFlags = []
        if !SCNetworkReachabilityGetFlags(defaultRouteReachability, &flags) {
            return false
        }
        
        let isReachable = flags.contains(.reachable)
        let needsConnection = flags.contains(.connectionRequired)
        
        return (isReachable && !needsConnection)
    }
    
    
}


