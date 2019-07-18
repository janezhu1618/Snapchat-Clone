//
//  SnapsTableViewController.swift
//  Snapchat-Clone
//
//  Created by Jane Zhu on 4/18/19.
//  Copyright © 2019 JaneZhu. All rights reserved.
//

import UIKit
import FirebaseAuth

class SnapsTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func logOutTapped(_ sender: UIBarButtonItem) {
        print("logout pressed")
        do {
            try Auth.auth().signOut()
            dismiss(animated: true, completion: nil)
        } catch {
            showAlert(alert: error.localizedDescription)
        }
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }

}
