//
//  AuthService.swift
//  Snapchat-Clone
//
//  Created by Jane Zhu on 4/23/19.
//  Copyright © 2019 JaneZhu. All rights reserved.
//

import Foundation
import Firebase

final class AuthService {
    public func getCurrentUser() -> User? {
        return Auth.auth().currentUser
    }
}
