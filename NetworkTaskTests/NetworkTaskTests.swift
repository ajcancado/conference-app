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
            XCTAssertNotNil(responseData.user?.authToken, "AuthToken is nil")
            
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
                
                let firstEventName = responseData.events.first!.name
                    
                XCTAssertTrue(firstEventName == "What's New in App Store Connect")
                
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
                
                let events = responseData.user?.events
                
                XCTAssertNotNil(events, "Events is nil")
                XCTAssertTrue(events!.count == 1)
                
            }) { (error) in
                expectation.fulfill()
                XCTFail((error?.localizedDescription)!)
            }
        }
    }
    
    private func registerUser(expectation: XCTestExpectation, success: @escaping () -> ()) {
        NetworkService.sharedService.registerUserWith(login: "testUser", password: "secretPass", success: { (userResponse) in
            SessionManager.shared.userResponse = userResponse
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
