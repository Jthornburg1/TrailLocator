//
//  CustomCell.swift
//  Swoopy
//
//  Created by Jon Thornburg on 4/20/16.
//  Copyright © 2016 Jon Thornburg. All rights reserved.
//

import Foundation
import UIKit

open class CustomCell: UITableViewCell, ConfigureCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    func config(_ trail: TrailDict) {

        if let trailName = trail.name {
            self.nameLabel.text = trailName
        }
        if let trailCity = trail.city {
            if let trailState = trail.state {
                self.locationLabel.text = "\(trailCity), \(trailState)"
            }
        }
        if trail.actArray != nil {
            if let desc = trail.described1 {
                let cleanDesc = desc.removeHTML()
                self.descriptionLabel.text = cleanDesc.trunc(200)
            } else if let desc2 = trail.described2 {
                self.descriptionLabel.text = desc2
            } else if let desc3 = trail.described3 {
                self.descriptionLabel.text = desc3
            } else {
                self.descriptionLabel.text = "There is no description for \(trail.name!)"
            }
        } else {
            self.descriptionLabel.text = "There is no description for \(trail.name!)"
        }
    }
}

