//
//  PropertySorter.swift
//  GetToTrails
//
//  Created by Jon Thornburg on 5/19/16.
//  Copyright © 2016 Jon Thornburg. All rights reserved.
//

import Foundation

public struct PropertySorter {
    
    func getDescription(_ trail: TrailDict, ind: Int) -> String {
        if ind == 0 {
            if let des1 = trail.described1 {
                return des1
            } else {
                return "There is no description for this activity at \(trail.name!)"
            }
        }
        if ind == 1 {
            if let des1 = trail.described2 {
                return des1
            } else {
                return "There is no description for this activity at \(trail.name!)"
            }
        }
        if ind == 2 {
            if let des1 = trail.described3 {
                return des1
            } else {
                return "There is no description for this activity at \(trail.name!)"
            }
        }
        return ""
    }
    
    func getActivities(_ trail: TrailDict, ind: Int) -> String {
        if ind == 0 {
            if let act1 = trail.activities1 {
                return act1
            } else {
                return ""
            }
        }
        if ind == 1 {
            if let act1 = trail.activities2 {
                return act1
            } else {
                return ""
            }
        }
        if ind == 2 {
            if let act1 = trail.activities3 {
                return act1
            } else {
                return ""
            }
        }
        return ""
    }

    func getThumbnail(_ trail: TrailDict, ind: Int) -> String {
        if ind == 0 {
            if let pic1 = trail.thumbnail1 {
                return pic1
            } else {
                return ""
            }
        }
        if ind == 1 {
            if let pic1 = trail.thumbnail2 {
                return pic1
            } else {
                return ""
            }
        }
        if ind == 2 {
            if let pic1 = trail.thumbnail3 {
                return pic1
            } else {
                return ""
            }
        }
        return ""
    }

    func getURL(_ trail: TrailDict, ind: Int) -> String? {
        if ind == 0 {
            if let str = trail.url1 {
                return str
            } else {
                return ""
            }
        }
        if ind == 1 {
            if let str = trail.url2 {
                return str
            } else {
                return ""
            }
        }
        if ind == 2 {
            if let str = trail.url3 {
                return str
            } else {
                return ""
            }
        }
        return ""
    }

}
