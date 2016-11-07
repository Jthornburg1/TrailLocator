//
//  String + extensions.swift
//  GetToTrails
//
//  Created by Jon Thornburg on 5/18/16.
//  Copyright © 2016 Jon Thornburg. All rights reserved.
//

import Foundation

extension String {
    
    
    func trunc(_ length: Int, trailing: String = "...") -> String {
        if self.characters.count > length {
            return self.substring(to: self.characters.index(self.startIndex, offsetBy: length)) + (trailing )
        } else {
            return self
        }
    }
    
    func removeHTML() -> String{
        let cleanString = self.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil)
        let cleanerString = cleanString.replacingOccurrences(of: "&quot", with: "", options: .regularExpression, range: nil)
        return cleanerString
    }
    
    func prepareStringForFirebase() -> String {
        
        var newString = self
        newString = newString.replacingOccurrences(of: "/", with: " ")
        newString = newString.replacingOccurrences(of: ".", with: "")
        newString = newString.replacingOccurrences(of: "#", with: "")
        newString = newString.replacingOccurrences(of: "$", with: "")
        newString = newString.replacingOccurrences(of: "[", with: "")
        newString = newString.replacingOccurrences(of: "]", with: "")
        return newString
    }
    
    mutating func removeSpaceAtEnd() -> String {
        let num = self.characters.count
        print(num)
        let lastSpace = self[self.characters.index(self.startIndex, offsetBy: num - 1)]
        if lastSpace == " " {
            self = String(self.characters.dropLast())
        }
        print(self)
        return self
    }
}
