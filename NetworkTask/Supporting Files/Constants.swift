//
//  Constants.swift
//  NetworkTask
//
//  Created by Arthur Junqueira Cançado on 05/05/20.
//  Copyright © 2020 Devskiller. All rights reserved.
//

import UIKit

struct Constants {
    
    struct APP {
        static let name = "Conference App"
        static let events = "Events"
    }

    struct API {
        static let baseURL = "https://localhost:8080"
        static let authorizationHeader = "authToken"
    }
    
    struct Messages {
        static let ok = "OK"
        static let yes = "Yes"
        static let no = "No"
        static let registerDiscription = "Dear user to be able to register for an event from our amazing conference first we need your registration. Enjoy"
        static let registerError = "Dear user, for your registration we need you to fill in all the fields"
        static let subscribeQuestion = "Dear user, would you like to register for event ?"
    }
}
