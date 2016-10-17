//
//  Parser.swift
//  TrailLocator
//
//  Created by jonathan thornburg on 10/16/16.
//  Copyright © 2016 Jon Thornburg. All rights reserved.
//

import Foundation

struct Parser {
    
    static func parseJson(_ data: Data) -> [String : AnyObject]? {
        
        do {
            let json = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions(rawValue: 0)) as? [String : AnyObject]
            return json!
        } catch {
            print("Json parsing error!")
        }
        return nil
    }
}
