
import Foundation

class NetworkService: NSObject {
    
    private let session: URLSession
    
    init(session: URLSession) {
        self.session = session
    }
    
    //token for requests
    var authToken: String?
    
    //MARK: Singleton
    
    static var sharedService: NetworkService = NetworkService(session: URLSessionMock())
    
    //MARK: Requests
    
    func registerUserWith(login: String, password: String, success: @escaping (UserResponse)->(), failure: @escaping (Error?) -> ()) {
        
        let url = URL(string: Constants.API.baseURL)!
        var request = URLRequest(url: url.appendingPathComponent("/api/v1/user"))
        
        request.httpMethod = HTTPMethod.post.rawValue
        
        let parameters: [String: Any] = [
            "login": login,
            "password": password
        ]
        
        do {
            // pass dictionary to nsdata object and set it as request body
            request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
        } catch let error {
            print(error.localizedDescription)
        }
        
        let task = self.session.dataTask(with: request) { (data, response, error) in
            
            guard error == nil else {
                failure(error)
                return
            }

            guard let data = data else { return }

            do {
                let userResponse = try JSONDecoder().decode(UserResponse.self, from: data)
                success(userResponse)
            } catch let error {
                failure(error)
            }
        }
        
        task.resume()
    }
    
    func getAllEvents(success: @escaping (EventResponse)->(), failure: @escaping (Error?) -> ()) {
        
        let url = URL(string: Constants.API.baseURL)!
        var request = URLRequest(url: url.appendingPathComponent("/api/v1/events"))
        
        request.httpMethod = HTTPMethod.get.rawValue
        
        if let authToken = SessionManager.shared.getAuthToken() {
            request.addValue(authToken, forHTTPHeaderField: Constants.API.authorizationHeader)
        }        
        
        let task = session.dataTask(with: request) { (data, response, error) in
            
            guard error == nil else {
                failure(error)
                return
            }

            guard let data = data else { return }

            do {
                let eventResponse = try JSONDecoder().decode(EventResponse.self, from: data)
                success(eventResponse)
            } catch let error {
                failure(error)
            }
        }

        task.resume()
    }
    
    func subscribeOnEvent(eventUUID: Int, success: @escaping (UserResponse)->(), failure: @escaping (Error?) -> ()) {
    
        let url = URL(string: Constants.API.baseURL)!
        var request = URLRequest(url: url.appendingPathComponent("/api/v1/event/\(eventUUID)/join"))
        
        request.httpMethod = HTTPMethod.get.rawValue
        
        if let authToken = SessionManager.shared.getAuthToken() {
            request.addValue(authToken, forHTTPHeaderField: Constants.API.authorizationHeader)
        }
        
        let task = session.dataTask(with: request) { (data, response, error) in
            
            guard error == nil else {
                failure(error)
                return
            }

            guard let data = data else { return }

            do {
                let userResponse = try JSONDecoder().decode(UserResponse.self, from: data)
                success(userResponse)
            } catch let error {
                failure(error)
            }
        }

        task.resume()
    }

}
