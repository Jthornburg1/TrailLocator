//
//  DetailCell.swift
//  GetToTrails
//
//  Created by Jon Thornburg on 5/19/16.
//  Copyright © 2016 Jon Thornburg. All rights reserved.
//

import Foundation
import UIKit

class DetailCell: UITableViewCell, ConfigureCell {
    @IBOutlet weak var trailImage: UIImageView!
    @IBOutlet weak var activityLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    func config(_ trail: TrailDict) {
    }
    
}
