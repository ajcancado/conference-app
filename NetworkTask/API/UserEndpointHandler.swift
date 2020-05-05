import Foundation

class UserEndpointHandler {
    
    private let usersDbFileName = "user.db"
    
    public func handle(request: URLRequest) -> (data: Data?, error: Error?) {
        do {
            let body = request.httpBody
            let params = try JSONSerialization.jsonObject(with: body!, options: []) as! [String: Any]
            
            if let name = params["login"], let pass = params["password"] {
                if let userDbPath = Bundle.main.path(forResource: usersDbFileName, ofType: "json") {
                 
                    let userData = try registerUserToFile(name: name, password: pass, userDbPath: userDbPath)
                    return (userData, nil)
                    
                } else {
                    print("Missing users.db.json file.")
                    return (nil, ApiError.InternalServerError)
                }
            } else {
                return (nil, ApiError.MissingParameter)
            }
        } catch {
            print(error)
            return (nil, ApiError.InternalServerError)
        }
    }
    
    public func handleSubscription(request: URLRequest) -> (data: Data?, error: Error?) {
        
        guard let authToken = request.value(forHTTPHeaderField: "authToken") else {
            return (nil, ApiError.MissingAuthToken)
        }
        
        guard let eventId = providedEventId(request: request) else {
            return (nil, ApiError.MissingParameter)
        }
        
        guard let userDbPath = Bundle.main.path(forResource: usersDbFileName, ofType: "json") else {
            print("Missing users.db.json file.")
            return (nil, ApiError.InternalServerError)
        }
        
        guard let eventsData = EventsEndpointHandler().handleEvents(request: request).data else {
            print("Cannot read events file.")
            return (nil, ApiError.InternalServerError)
        }
        
        do {
            let isEventIdValid = try validateEventId(request: request, eventId: eventId, eventsData: eventsData)
            if !isEventIdValid {
                return (nil, ApiError.WrongEventId)
            }
        } catch {
            return (nil, ApiError.InternalServerError)
        }
        
        do {
            guard let dbJson = try getUserData(userDbPath: userDbPath) else {
                return (nil, ApiError.UserNotFound)
            }
            
            var user = dbJson["user"] as! [String: Any]
            
            if authToken != user["authToken"] as! String {
                return (nil, ApiError.InvalidToken)
            }
            
            var userEvents = user["events"] as! [[String: Any?]]
            userEvents.append(["uuid": eventId])
            user["events"] = userEvents
            
            let newUserData = try writeUserData(userDbPath: userDbPath, user: user)
            return (newUserData, nil)
        } catch {
            print(error)
            return (nil, ApiError.InternalServerError)
        }
    }
    
    private func registerUserToFile(name: Any, password: Any, userDbPath: String) throws -> Data {
        let authToken = "\(name)_\(password)_secret_token"
        let userObject = ["user": ["name": name, "password": password, "authToken": authToken, "events": []]]
        let userData = try JSONSerialization.data(withJSONObject: userObject, options: [])
        try userData.write(to: URL(fileURLWithPath: userDbPath))
        
        return userData
    }
    
    private func providedEventId(request: URLRequest) -> Int? {
        guard let url = request.url else { return nil }
        
        let components = url.pathComponents
        let eventId: Int? = Int(components[4])
        
        if components.count != 6 || eventId == nil {
            return nil
        }
        
        return eventId
    }
    
    private func getUserData(userDbPath: String) throws -> [String: Any]? {
        let dbData = try Data(contentsOf: URL(fileURLWithPath: userDbPath), options: .mappedIfSafe)
        if dbData.isEmpty {
            return nil
        }
        
        let dbJson = try JSONSerialization.jsonObject(with: dbData, options: [])
        return dbJson as? [String: Any]
    }
    
    private func writeUserData(userDbPath: String, user: [String: Any]) throws -> Data {
        let newUserData = try JSONSerialization.data(withJSONObject: ["user": user], options: [])
        try newUserData.write(to: URL(fileURLWithPath: userDbPath))
        return newUserData
    }
    
    private func validateEventId(request: URLRequest, eventId: Int, eventsData: Data) throws -> Bool {
        let eventsJson = try JSONSerialization.jsonObject(with: eventsData, options: []) as! [String: Any?]
        let events = eventsJson["events"] as! [[String: Any?]]
        
        if events.contains(where: {($0["uuid"] as! Int) == eventId}) {
            return true
        } else {
            return false
        }
    }
}
