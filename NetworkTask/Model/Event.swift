//
//  Event.swift
//  NetworkTask
//
//  Created by Arthur Junqueira Cançado on 05/05/20.
//  Copyright © 2020 Devskiller. All rights reserved.
//

import UIKit

struct EventResponse: Codable {
    var events: [Event]
}

struct Event: Codable {
    var uuid: Int
    var name: String?
}
