import Foundation

class URLSessionMock : URLSession {
    
    typealias CompletionHandler = (Data?, URLResponse?, Error?) -> Void
    
    private let apiEndpoint = "/api/v1/"
    private let userEndpoint = "user"
    private let eventsEndpoint = "events"
    private let eventEndpoint = "event"
    private let subToEventEndpoint = "/join"
    
    override func dataTask(
        with url: URL,
        completionHandler: @escaping CompletionHandler) -> URLSessionDataTask
    {
        var error: Error?
        
        if url.path == apiEndpoint + userEndpoint {
            error = ApiError.WrongHttpMethod
        } else {
            error = ApiError.MissingAuthToken
        }
        
        return URLSessionDataTaskMock {
            completionHandler(nil, nil, error)
        }
    }
    
    override func dataTask(
        with request: URLRequest,
        completionHandler: @escaping CompletionHandler) -> URLSessionDataTask
    {
        let (data, error) = handleRequest(request: request)
        
        return URLSessionDataTaskMock {
            completionHandler(data, nil, error)
        }
    }
    
    private func handleRequest(request: URLRequest) -> (data: Data?, error: Error?) {
        var error: Error? = nil
        
        if let url = request.url {
            if url.path != apiEndpoint + userEndpoint {
                guard request.value(forHTTPHeaderField: "authToken") != nil else {
                    return (nil, ApiError.MissingAuthToken)
                }
            }
        }
        
        if let url = request.url {
            switch url.path {
            case apiEndpoint + userEndpoint:
                if request.httpMethod != "POST" {
                    return (nil, ApiError.WrongHttpMethod)
                } else {
                    return UserEndpointHandler().handle(request: request)
                }
            case apiEndpoint + eventsEndpoint:
                return EventsEndpointHandler().handleEvents(request: request)
            case let p where isSubToEventEndpoint(urlPath: p):
                return UserEndpointHandler().handleSubscription(request: request)
            default:
                error = ApiError.BadRequest
            }
        } else {
            error = ApiError.MissingURL
        }
        
        return (nil, error)
    }
    
    private func isSubToEventEndpoint(urlPath: String) -> Bool {
        return urlPath.hasPrefix(apiEndpoint + eventEndpoint)
            && urlPath.hasSuffix(subToEventEndpoint)
    }
}
