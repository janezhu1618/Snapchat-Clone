//
//  SnapsTableViewController.swift
//  Snapchat-Clone
//
//  Created by Jane Zhu on 4/18/19.
//  Copyright © 2019 JaneZhu. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class SnapsTableViewController: UITableViewController {
    
    private var snaps: [DataSnapshot] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        if let currentUserUid = Auth.auth().currentUser?.uid {
            Database.database().reference()
                .child("users")
                .child(currentUserUid)
                .child("snaps").observe(.childAdded) { (snapshot) in
                    self.snaps.append(snapshot)
                    self.tableView.reloadData()
            }
                Database.database().reference()
                    .child("users")
                    .child(currentUserUid)
                    .child("snaps").observe(.childRemoved) { (snapshot) in
                        for (index, snap) in self.snaps.enumerated() {
                            if snap.key == snapshot.key {
                                self.snaps.remove(at: index)
                            }
                        }
                        self.tableView.reloadData()
                }
        }
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
        if snaps.isEmpty {
            return 1
        } else {
            return snaps.count
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        if snaps.isEmpty {
            cell.textLabel?.text = "You have no snaps ☹️"
        } else {
            let snap = snaps[indexPath.row]
            if let snapDictionary = snap.value as? NSDictionary {
                if let fromEmail = snapDictionary["from"] as? String {
                    cell.textLabel?.text = fromEmail
                }
            }
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if !snaps.isEmpty {
            let snap = snaps[indexPath.row]
            performSegue(withIdentifier: "ViewSnapSegue", sender: snap)
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ViewSnapSegue" {
            if let viewVC = segue.destination as? ViewSnapViewController {
                viewVC.snap = sender as? DataSnapshot
            }
        }
    }
    
    
}
