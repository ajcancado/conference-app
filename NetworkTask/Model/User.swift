//
//  User.swift
//  NetworkTask
//
//  Created by Arthur Junqueira Cançado on 05/05/20.
//  Copyright © 2020 Devskiller. All rights reserved.
//

import UIKit

struct UserResponse: Codable {
    var user: User?
}

struct User: Codable {
    var name: String?
    var password: String?
    var authToken: String?
    var events: [Event]
}
