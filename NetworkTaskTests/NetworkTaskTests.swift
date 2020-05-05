import XCTest
@testable import NetworkTask

class NetworkTaskTests: XCTestCase {
    
    var expectation: XCTestExpectation?
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testUserRegistrationMethod() {
        let expectation: XCTestExpectation = self.expectation(description: "user registration")
        
        let login: String = "testUser"
        let password: String = "pass"
        
        NetworkService.sharedService.registerUserWith(login: login, password: password, success: { (responseData) in
            expectation.fulfill()
            XCTAssertNotNil(responseData, "Data is nil")
            
            do {
                let json = try JSONSerialization.jsonObject(with: responseData, options:[]) as! [String : Any?]
                let authToken: String = json["authToken"] as! String
                
                XCTAssertNotNil(authToken, "AuthToken is nil")
                
            } catch let error {
                print(error)
            }
        }) { (error) in
            expectation.fulfill()
            XCTFail((error?.localizedDescription)!)
        }
        
        waitForExpectations(timeout: 4) { (error) in
            if error != nil {
                print(error!)
            }
        }
    }
    
    func testGetAllEventsMethod() {
        let expectation: XCTestExpectation = self.expectation(description: "getEvents")
        
        registerUser(expectation: expectation) {
            NetworkService.sharedService.getAllEvents(success: { (responseData) in
                
                expectation.fulfill()
                XCTAssertNotNil(responseData, "Data is nil")
                
                do {
                    let json = try JSONSerialization.jsonObject(with: responseData, options: []) as! [String: Any?]
                    let events = json["events"] as! [[String: Any?]]
                    let firstEvent = events.first!
                    let firstEventName = firstEvent["name"] as! String
                    
                    XCTAssertTrue(firstEventName == "What's New in App Store Connect")
                    
                } catch let error {
                    print(error)
                }
            }) { (error) in
                expectation.fulfill()
                XCTFail((error?.localizedDescription)!)
            }
        }
    }
    
    func testSubscribeOnEventMethod() {
        let expectation: XCTestExpectation = self.expectation(description: "subscribe")
        let eventId = 7655
        
        registerUser(expectation: expectation) {
            NetworkService.sharedService.subscribeOnEvent(eventUUID: eventId, success: { (responseData) in
                
                expectation.fulfill()
                XCTAssertNotNil(responseData, "Data is nil")
                
                do {
                    let json = try JSONSerialization.jsonObject(with: responseData, options: []) as! [String: Any?]
                    let user = json["user"] as! [String: Any]
                    let events = user["events"] as! [[String: Any]]
                    
                    XCTAssertTrue(events.count == 1)
                    
                } catch let error {
                    print(error)
                }
                
            }) { (error) in
                expectation.fulfill()
                XCTFail((error?.localizedDescription)!)
            }
        }
    }
    
    private func registerUser(expectation: XCTestExpectation, success: @escaping () -> ()) {
        NetworkService.sharedService.registerUserWith(login: "testUser", password: "secretPass", success: { (data) in
            success()
        }) { (error) in
            expectation.fulfill()
            XCTFail((error?.localizedDescription)!)
        }
        
        self.waitForExpectations(timeout: 4) { (error) in
            if error != nil {
                print(error!)
            }
        }
    }
}
