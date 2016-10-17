//
//  WebViewController.swift
//  GetToTrails
//
//  Created by Jon Thornburg on 8/12/16.
//  Copyright © 2016 Jon Thornburg. All rights reserved.
//

import Foundation
import UIKit

class WebViewController: UIViewController {
    
    @IBOutlet var toolbar: UIView!
    var str: String?
    
    @IBOutlet weak var webView: UIWebView!
    override func viewDidLoad() {
        super.viewDidLoad()
        loadWebPage()
    }
    @IBAction func downTapped(_ sender: AnyObject) {
        dismiss(animated: true, completion: nil)
    }
    
    func loadWebPage() {
        let url = URL(string: str!)
        let request = URLRequest(url: url!)
        webView.loadRequest(request)
    }
}
