//
//  TrailOperation.swift
//  Swoopy
//
//  Created by Jon Thornburg on 4/20/16.
//  Copyright © 2016 Jon Thornburg. All rights reserved.
//

import Foundation

class TrailOperation: Operation {

    let city: String
    
    fileprivate let handler: (_ resultData: Data?, _ error: NSError?) -> Void
 
    init(query: String, handler:@escaping (_ resultData: Data?, _ error: NSError?) -> Void) {
        self.city = query
        self.handler = handler
    }
    override func main() {
        let unEncodedUrl = "https://outdoor-data-api.herokuapp.com/api.json?api_key=d6d33ee90666c461d901c731cc104b79&q[city_cont]=\(self.city)"
        let url = unEncodedUrl.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)
        let request = HttpRequest.createRequest(url!)
        
//        HttpWrapperImpl.sendRequest(request, completion: {(data, error) in
//            self.handler(data, error)
//        })
    }
}
