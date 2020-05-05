import Foundation

class EventsEndpointHandler {
    
    private let eventsDbFileName = "events.db"
    
    func handleEvents(request: URLRequest) -> (data: Data?, error: Error?) {
        
        if let eventsDbPath = Bundle.main.path(forResource: eventsDbFileName, ofType: "json") {
            do {
                let dbData = try Data(contentsOf: URL(fileURLWithPath: eventsDbPath), options: .mappedIfSafe)
                return (dbData, nil)
            } catch {
                print(error)
                return (nil, ApiError.InternalServerError)
            }
        } else {
            print("Missing events.db.json file.")
            return (nil, ApiError.InternalServerError)
        }
    }
}
