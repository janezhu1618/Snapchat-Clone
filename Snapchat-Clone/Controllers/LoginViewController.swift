//
//  LoginViewController.swift
//  Snapchat-Clone
//
//  Created by Jane Zhu on 4/18/19.
//  Copyright © 2019 JaneZhu. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase
import FirebaseFirestore

class LoginViewController: UIViewController {

    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var signInButton: UIButton!
    
    private var signupMode = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }

    @IBAction func signInButtonPressed(_ sender: UIButton) {
        guard let email = emailTextField.text,
            let password = passwordTextField.text,
            !email.isEmpty,
            !password.isEmpty else {
                return
        }
        if signupMode {
            Auth.auth().createUser(withEmail: email, password: password) { (user, error) in
                if let error = error {
                    self.showAlert(alert: error.localizedDescription)
                } else if let user = user {
                    Database.database().reference()
                        .child("users")
                        .child(user.user.uid)
                        .child("email").setValue(user.user.email)
                    print(user.user.email ?? "")
                    self.performSegue(withIdentifier: "goToSnaps", sender: self)
                }
            }
        } else {
            Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
                if let error = error {
                    self.showAlert(alert: error.localizedDescription)
                } else {
                    self.performSegue(withIdentifier: "goToSnaps", sender: self)
                }
            }
        }
    }
    
    @IBAction func signInMethodSegmentedControl(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            signupMode = false
            signInButton.setTitle("Log In", for: .normal)
        } else {
            signupMode = true
            signInButton.setTitle("Sign Up", for: .normal)
        }
    }
}

