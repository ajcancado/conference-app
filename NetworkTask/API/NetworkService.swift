
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
    
    func registerUserWith(login: String?, password: String?, success: @escaping (Data)->(), failure: @escaping (Error?) -> ()) {
        
        let url = URL(string: "htts://localhost:8080/api/v1/user")!
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        let parameters: [String: Any] = [
            "login": "ajcancado",
            "password": "121212"
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
            //create json object from data
                if let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: Any] {
                   // handle json...
                    print(json)
                    success(data)
                    
                }
            } catch let error {
                print(error.localizedDescription)
            }
        }
        
        task.resume()
    }
    
    func getAllEvents(success: @escaping (Data)->(), failure: @escaping (Error?) -> ()) {
        
        //get all events method, use self.session
    }
    
    func subscribeOnEvent(eventUUID: Int, success: @escaping (Data)->(), failure: @escaping (Error?) -> ()) {
    
        //subscribe method, use self.session
    }

}
