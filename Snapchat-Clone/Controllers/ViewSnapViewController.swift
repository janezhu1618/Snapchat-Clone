//
//  ViewSnapViewController.swift
//  Snapchat-Clone
//
//  Created by Jane Zhu on 7/18/19.
//  Copyright © 2019 JaneZhu. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth
import SDWebImage
import FirebaseStorage

class ViewSnapViewController: UIViewController {

    @IBOutlet weak var snapImageView: UIImageView!
    @IBOutlet weak var descriptionlabel: UILabel!
    
    public var snap: DataSnapshot!
    private var imageName = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let snapDictionary = snap.value as? NSDictionary {
            if let description = snapDictionary["description"] as? String {
                descriptionlabel.text = description
            }
            if let imageURL = snapDictionary["imageURL"] as? String {
                if let url = URL(string: imageURL) {
                    snapImageView.sd_setImage(with: url, completed: nil)
                }
            }
            if let imageName = snapDictionary["imageName"] as? String {
                self.imageName = imageName
            }
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        if let currentUserUid = Auth.auth().currentUser?.uid {
            Database.database().reference()
                .child("users")
                .child(currentUserUid)
                .child("snaps")
                .child(snap.key)
                .removeValue()
            Storage.storage().reference()
                .child("images")
                .child(imageName)
                .delete(completion: nil)
        }
        
    }

}
