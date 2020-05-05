//
//  SessionUserManager.swift
//  NetworkTask
//
//  Created by Arthur Junqueira Cançado on 05/05/20.
//  Copyright © 2020 Devskiller. All rights reserved.
//

import UIKit

class SessionUserManager {

    static let shared = SessionUserManager()

    var userResponse: UserResponse?

    private init() {}

    func getAuthToken() -> String? {
        return userResponse?.user?.authToken
    }
}
