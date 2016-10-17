//
//  File.swift
//  TrailLocator
//
//  Created by jonathan thornburg on 10/16/16.
//  Copyright © 2016 Jon Thornburg. All rights reserved.
//

import Foundation

public struct APIService {
    
    public static func getDictionary(urlString: String, completion: @escaping (_ dictionary: [String : AnyObject]?) -> Void) {
        
        let url = URL(string: urlString)
        let request = URLRequest(url: url!)
        let session = URLSession.shared
        let dataTask = session.dataTask(with: request) { (data, response, error) in
            if error != nil {
                print("URLSession error: \(error?.localizedDescription)")
                DispatchQueue.main.async(execute: { 
                    completion(nil)
                })
            } else {
                if let httpResponse = response as? HTTPURLResponse {
                    if httpResponse.statusCode == 200 || httpResponse.statusCode == 201 {
                        print("Success!")
                        let returnDict = Parser.parseJson(data!)
                        DispatchQueue.main.async(execute: { 
                            completion(returnDict!)
                        })
                    }
                }
            }
        }
        dataTask.resume()
    }
}
