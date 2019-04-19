//
//  UIViewController+Alerts.swift
//  Snapchat-Clone
//
//  Created by Jane Zhu on 4/18/19.
//  Copyright © 2019 JaneZhu. All rights reserved.
//

import UIKit

extension UIViewController {
    public func showAlert(alert: String) {
        let alert = UIAlertController(title: "Error", message: alert, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}
