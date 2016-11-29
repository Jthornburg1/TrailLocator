//
//  UIView+extensions.swift
//  TrailLocator
//
//  Created by Jon Thornburg on 11/29/16.
//  Copyright © 2016 Jon Thornburg. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    func withPadding(padding: UIEdgeInsets) -> UIView {
        let container = UIView()
        container.addSubview(self)
        return container
    }
}
