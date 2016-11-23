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
    
    var str: String?
    
    @IBOutlet var webView: UIWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadWebPage()
        title = "TRAIL LOCATOR"
        navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName : UIColor.tryBlue(), NSFontAttributeName: UIFont(name: "COCOGOOSELETTERPRESS", size: 20)!]
    }
    
    override func viewWillAppear(_ animated: Bool) {
        UIApplication.shared.setStatusBarHidden(false, with: .none)
    }
    
    func loadWebPage() {
        let url = URL(string: str!)
        let request = URLRequest(url: url!)
        webView.loadRequest(request)
    }
    @IBAction func dismissTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}
