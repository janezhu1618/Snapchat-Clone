//
//  SelectReceiverTableViewController.swift
//  Snapchat-Clone
//
//  Created by Jane Zhu on 4/23/19.
//  Copyright © 2019 JaneZhu. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth

class SelectReceiverTableViewController: UITableViewController {
    
    public var downloadURL = ""
    public var snapDescription = ""
    public var imageName = ""
    var snapUsers: [SnapUser] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        Database.database().reference().child("users").observe(.childAdded) { (snapshot) in
            let user = SnapUser()
            if let userDictionary = snapshot.value as? NSDictionary {
                if let email = userDictionary["email"] as? String {
                    user.uid = snapshot.key
                    user.email = email
                    self.snapUsers.append(user)
                    self.tableView.reloadData()
                }
            }
        }
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return snapUsers.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        let user = snapUsers[indexPath.row]
        cell.textLabel?.text = user.email
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let userSelected = snapUsers[indexPath.row]
        if let fromEmail = Auth.auth().currentUser?.email {
            let snap = ["from":fromEmail,
                        "description": snapDescription,
                        "imageURL": downloadURL,
                        "imageName": imageName]
            Database.database().reference().child("users").child(userSelected.uid).child("snaps").childByAutoId().setValue(snap)
            navigationController?.popToRootViewController(animated: true)
        }
        
    }
}
