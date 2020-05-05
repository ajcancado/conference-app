
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
    
    func registerUserWith(login: String?, password: String?, success: @escaping (UserResponse)->(), failure: @escaping (Error?) -> ()) {
        
        let url = URL(string: "htts://localhost:8080/api/v1/user")!
        
        var request = URLRequest(url: url)
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
                return
            }

            guard let data = data else {
                return
            }

            do {
                let userResponse = try JSONDecoder().decode(UserResponse.self, from: data)
                print(userResponse)
                success(userResponse)
            } catch let error {
                print(error.localizedDescription)
            }
        }
        
        task.resume()
    }
    
    func getAllEvents(success: @escaping (EventResponse)->(), failure: @escaping (Error?) -> ()) {
        
        let url = URL(string: "htts://localhost:8080/api/v1/events")!
        
        var request = URLRequest(url: url)
        request.httpMethod = HTTPMethod.get.rawValue
        
        if let authToken = SessionUserManager.shared.getAuthToken() {
            request.addValue(authToken, forHTTPHeaderField: "authToken")
        }        
        
        let task = session.dataTask(with: request) { (data, response, error) in
            guard error == nil else {
                return
            }

            guard let data = data else {
                return
            }

            do {
                //create json object from data
                let eventResponse = try JSONDecoder().decode(EventResponse.self, from: data)
                print(eventResponse)
                success(eventResponse)
                
            } catch let error {
                print(error.localizedDescription)
            }
        }

        task.resume()
    }
    
    func subscribeOnEvent(eventUUID: Int, success: @escaping (Data)->(), failure: @escaping (Error?) -> ()) {
    
        let url = URL(string: "htts://localhost:8080/api/v1/event/\(eventUUID)/join")!
        
        var request = URLRequest(url: url)
        request.httpMethod = HTTPMethod.get.rawValue
        
        if let authToken = SessionUserManager.shared.getAuthToken() {
            request.addValue(authToken, forHTTPHeaderField: "authToken")
        }
        
        let task = session.dataTask(with: request) { (data, response, error) in
            guard error == nil else {
                return
            }

            guard let data = data else {
                return
            }

            do {
                //create json object from data
                let eventResponse = try JSONDecoder().decode(EventResponse.self, from: data)
                print(eventResponse)
                success(data)
                
            } catch let error {
                print(error.localizedDescription)
            }
        }

        task.resume()
    }

}
