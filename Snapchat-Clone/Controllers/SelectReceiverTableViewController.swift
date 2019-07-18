//
//  SelectReceiverTableViewController.swift
//  Snapchat-Clone
//
//  Created by Jane Zhu on 4/23/19.
//  Copyright © 2019 JaneZhu. All rights reserved.
//

import UIKit

class SelectReceiverTableViewController: UITableViewController {
    
    public var downloadURL = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        print(downloadURL)
        
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }

}
