//
//  UIColor + Extensions.swift
//  GetToTrails
//
//  Created by Jon Thornburg on 8/12/16.
//  Copyright © 2016 Jon Thornburg. All rights reserved.
//

import Foundation
import UIKit

extension UIColor {
    convenience init(r: CGFloat, g: CGFloat, b: CGFloat) {
        self.init(red: r/255, green: g/255, blue: b/255, alpha: 1)
    }
    
    class func newGrey() -> UIColor {
        let newGrey = UIColor(r: 190, g: 120, b: 66)
        return newGrey
    }
    
    class func newTan() -> UIColor {
        let newTan = UIColor(r: 247, g: 222, b: 201)
        return newTan
    }

    class func diffGreen() -> UIColor {
        let diffGreen = UIColor(r: 85, g: 187, b: 85)
        return diffGreen
    }
}
