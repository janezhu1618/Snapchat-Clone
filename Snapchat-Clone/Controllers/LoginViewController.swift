//
//  LoginViewController.swift
//  Snapchat-Clone
//
//  Created by Jane Zhu on 4/18/19.
//  Copyright © 2019 JaneZhu. All rights reserved.
//

import UIKit
import FirebaseAuth

class LoginViewController: UIViewController {

    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var topButton: UIButton!
    @IBOutlet weak var bottomButton: UIButton!
    
    private var signupMode = false
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    private func showAlert(alert: String) {
        let alert = UIAlertController(title: "Error", message: alert, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        present(alert, animated: true, completion: nil)
    }

    @IBAction func topButtonPressed(_ sender: UIButton) {
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
                } else {
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
    
    @IBAction func bottomButtonPressed(_ sender: UIButton) {
        if signupMode {
            // switch to log in
            topButton.setTitle("Log In", for: .normal)
            bottomButton.setTitle("Switch to Sign Up", for: .normal)
        } else {
            // swtich to register
            topButton.setTitle("Sign Up", for: .normal)
            bottomButton.setTitle("Switch to Log In", for: .normal)
        }
        signupMode = !signupMode
    }
}

