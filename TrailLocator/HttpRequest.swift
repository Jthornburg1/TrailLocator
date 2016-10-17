//
//  HttpRequest.swift
//  Swoopy
//
//  Created by Jon Thornburg on 4/20/16.
//  Copyright © 2016 Jon Thornburg. All rights reserved.
//

import Foundation

public struct HttpRequest {
    
    static func createRequest(_ urlString: String) -> URLRequest {
        
        let url = URL(string: urlString)
        let request = NSMutableURLRequest(url: url!)
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        return request as URLRequest
    }
    
}
