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
       /* var zeroAddress = sockaddr_in()
        zeroAddress.sin_len = UInt8(MemoryLayout.size(ofValue: zeroAddress))
        zeroAddress.sin_family = sa_family_t(AF_INET)
        let defaultRouteReachability = withUnsafePointer(to: &zeroAddress){
            SCNetworkReachabilityCreateWithAddress(nil, UnsafePointer($0))
        }
        var flags = SCNetworkReachabilityFlags()
        if !SCNetworkReachabilityGetFlags(defaultRouteReachability!, &flags) {
            return false
        }
        let isReachable = (flags.rawValue & UInt32(kSCNetworkFlagsReachable)) != 0
        let needsConnection = (flags.rawValue & UInt32(kSCNetworkFlagsConnectionRequired)) != 0
        return(isReachable && !needsConnection)*/
        return true
    }
    
    
}


