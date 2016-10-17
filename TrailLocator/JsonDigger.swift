//
//  JsonDigger.swift
//  GetToTrails
//
//  Created by Jon Thornburg on 5/13/16.
//  Copyright © 2016 Jon Thornburg. All rights reserved.
//

import Foundation
fileprivate func < <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
  switch (lhs, rhs) {
  case let (l?, r?):
    return l < r
  case (nil, _?):
    return true
  default:
    return false
  }
}

fileprivate func > <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
  switch (lhs, rhs) {
  case let (l?, r?):
    return l > r
  default:
    return rhs < lhs
  }
}


public struct JsonDigger {
    
    public static func getNestedValues(_ arr: NSArray?, index: Int, key: String) -> String? {
        print("gettingValue")
        if arr?.count > index {
            if let actIndex = arr![index] as? [String : AnyObject] {
                print("have dictionary")
                if let value = actIndex[key] as? String? {
                    print("Value: \(value!)")
                    return value
                } else {
                    return nil
                }
            } else {
                return nil
            }
        } else {
            return nil
        }
    }
    
    public static func getNestedArray(_ dict: [String : AnyObject], key: String) -> NSArray? {
        
        if let arr = dict[key] as? NSArray {
            return arr
        } else {
            return nil
        }
    }
    
    func arrayToString(_ arr: [String]) -> String {
        
        let str = arr.joined(separator: ",")
        return str
    }
    
    func stringToArray(_ str: String) -> [String] {
        let arr = str.components(separatedBy: ",")
        return arr
    }
}
