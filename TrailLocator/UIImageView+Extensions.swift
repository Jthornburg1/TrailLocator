//
//  UIImageView+Extensions.swift
//  GetToTrails
//
//  Created by Jon Thornburg on 5/19/16.
//  Copyright © 2016 Jon Thornburg. All rights reserved.
//

import Foundation
import UIKit


    
    extension UIImageView {
        public func downloadFrom(link:String?, contentMode mode: UIViewContentMode) {
            contentMode = mode
            image = UIImage(named: "default")
            if link != nil, let url = URL(string: link!) {
                URLSession.shared.dataTask(with: url, completionHandler: { data, response, error in
                    guard let data = data , error == nil else {
                        print("\nerror on download \(error)")
                        return
                    }
                    if let httpResponse = response as? HTTPURLResponse , httpResponse.statusCode != 200 {
                        print("statusCode != 200; \(httpResponse.statusCode)")
                        return
                    }
                    DispatchQueue.main.async {
                        print("\ndownload completed \(url.lastPathComponent)")
                        self.image = UIImage(data: data)
                    }
                    }) .resume()
            } else {
                self.image = UIImage(named: "default")
            }
        }
    
}
