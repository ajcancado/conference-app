
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
        
        //register user method, use self.session
    }
    
    func getAllEvents(success: @escaping (Data)->(), failure: @escaping (Error?) -> ()) {
        
        //get all events method, use self.session
    }
    
    func subscribeOnEvent(eventUUID: Int, success: @escaping (Data)->(), failure: @escaping (Error?) -> ()) {
    
        //subscribe method, use self.session
    }

}
