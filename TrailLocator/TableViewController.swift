//
//  ViewController.swift
//  Swoopy
//
//  Created by Jon Thornburg on 4/20/16.
//  Copyright © 2016 Jon Thornburg. All rights reserved.
//

import UIKit

typealias Persin = (String, Int, Bool)

class TableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate {

    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    var items = [TrailDict]()
    var itemsIndex: Int?
    let fbGetter = SprayFirebase()
    var loggedIn = false
    let svndftch = SaveAndFetch()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: "CustomCell", bundle: nil), forCellReuseIdentifier: "CustomCell")
        self.tableView.estimatedRowHeight = 80
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.isHidden = true
        self.tableView.setNeedsLayout()
        self.tableView.layoutIfNeeded()
        self.textField.backgroundColor = UIColor(red: 140/255, green: 140/255, blue: 140/255, alpha: 0.6)
        self.title = "Get To Trails"
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName : UIColor.diffGreen()]
    }
    
    // Textfield delegate methods
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        tableView.isHidden = false
        if textField.text != "" {
            let last = textField.text?.removeSpaceAtEnd()
            print(last!)
            
            if Reachable.isConnectedToNetwork() {
                MakeTrailArray.makeTrails(term: last!, completion: { (trails) in
                    self.items = trails
                    self.tableView.reloadData()
                })
            } else {
                showNoConnectionAlert()
            }
        }
        if textField.text == "" {
            self.items.removeAll()
            self.tableView.isHidden = true
        }
        return true
    }
    
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        self.items.removeAll()
        self.tableView.reloadData()
        tableView.isHidden = true
        return true
    }

    // TableView DataSource Methods
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CustomCell") as! CustomCell
        cell.config(self.items[(indexPath as NSIndexPath).row])
        cell.backgroundColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 0.75)
        return cell
    }

    // TableView delegate methods
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.itemsIndex = (indexPath as NSIndexPath).row
        tableView.deselectRow(at: indexPath, animated: true)
        self.performSegue(withIdentifier: "showDetail", sender: tableView)
    }
        
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as? DetailTableView
        vc?.trail = items[itemsIndex!]
    }
    
    @IBAction func addTrailClicked(_ sender: AnyObject) {
        if self.loggedIn {
            
        } else {
            showLoginAlert()
        }
    }
    
    func showLoginAlert() {
        let alert = UIAlertController(title: "Not Logged In", message: "To add to our database, users must create an account", preferredStyle: .actionSheet)
        let noThanksAction = UIAlertAction(title: "No thanks", style: .cancel, handler: nil)
        let signInAction = UIAlertAction(title: "Ok", style: .default) { (signInAction) in
            print("will perform segue.")
            self.performSegue(withIdentifier: "registerSegue", sender: self)
        }
        alert.view.tintColor = UIColor.diffGreen()
        alert.addAction(noThanksAction)
        alert.addAction(signInAction)
        present(alert, animated: true, completion: nil)
    }
    
    func showNoConnectionAlert() {
        let alert = UIAlertController(title: "No Connection", message: "You are not connected to the internet. Try your search again when you are.", preferredStyle: .alert)
        let action = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
        alert.view.tintColor = UIColor.red
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
    }
}

