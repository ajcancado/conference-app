//
//  SessionManager.swift
//  NetworkTask
//
//  Created by Arthur Junqueira Cançado on 05/05/20.
//  Copyright © 2020 Devskiller. All rights reserved.
//

import UIKit

class SessionManager {

    static let shared = SessionManager()

    var userResponse: UserResponse?

    private init() {}

    func getAuthToken() -> String? {
        return userResponse?.user?.authToken
    }
    
    func alreadySubscribeOnEvent(eventUUID: Int) -> Bool {
        
        guard let events = userResponse?.user?.events else { return false }
        
        return events.contains { event in
            event.uuid == eventUUID
        }
        
    }
}
