//
//  HttpWrapperImp.swift
//  Swoopy
//
//  Created by Jon Thornburg on 4/20/16.
//  Copyright © 2016 Jon Thornburg. All rights reserved.
//

import Foundation

/*protocol HttpWrapper {
    static func sendRequest(_ request: URLRequest, completion: (Data?, NSError?) -> Void) -> ()
}

open class HttpWrapperImpl: HttpWrapper {
    
    internal static func sendRequest(_ request: URLRequest, completion: (Data?, NSError?) -> Void) {
        let session = URLSession.shared
        let task = session.dataTask(with: request, completionHandler: { (data, error) in
            
            if error != nil{
                
                DispatchQueue.main.async(execute: { () -> Void in
                    
                    print("sendRequest error")
                    completion(data, error)
                })
                return
            }
            DispatchQueue.main.async(execute: { () -> Void in
                
                if let httpResponse = response as? HTTPURLResponse {
                    if httpResponse.statusCode == 200 || httpResponse.statusCode == 201 {
                        completion(data, nil)
                    }else{
                        let responseError: NSError = NSError(domain: "HTTPHelperError", code: httpResponse.statusCode, userInfo: nil)
                        completion(data, responseError)
                    }
                }
                
            })
            } as! (Data?, URLResponse?, Error?) -> Void)
        task.resume()

    }

    open class func jsonParser(_ data: Data) -> [String : AnyObject]? {
        do {
            let json = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions(rawValue: 0)) as? [String : AnyObject]
            return json
        }catch let error as NSError {
            print("The following JSON parsing error has occurred: \(error)")
        }
        return nil
    }
    
}

*/
