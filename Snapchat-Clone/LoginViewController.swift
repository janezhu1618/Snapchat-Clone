//
//  LoginViewController.swift
//  Snapchat-Clone
//
//  Created by Jane Zhu on 4/18/19.
//  Copyright © 2019 JaneZhu. All rights reserved.
//

import UIKit

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

    @IBAction func topButtonPressed(_ sender: UIButton) {
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

