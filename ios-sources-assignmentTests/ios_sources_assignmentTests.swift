
//  Copyright © 2018 Chegg. All rights reserved.

import XCTest
import SwiftyJSON
@testable import ios_sources_assignment

class ios_sources_assignmentTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    // change source to test the others.
    
    func test_NewsViewModel_getNewsForSource() {
        let expectation = self.expectation(description: "Fetching")
        var isWorking = false
        
        let newsViewModel = NewsViewModel()
        newsViewModel.getNewsForSource(.sourceA) { (result) in
            isWorking = result != nil
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 10, handler: nil)
        
        XCTAssertTrue(isWorking)
    }
    
    // change source to assert with other manually entered jsons.
    
    func test_Source_JSON() {
        
        let manualModel = NewsModel(title: "Interesting News!", subtitle: "You're not gonna believe this...", image: "https://pbs.twimg.com/profile_images/658218628127588352/v0ZLUBrt.jpg", source: .sourceA)
        
        let parser = JSONParser()
        let service = APIService()
        var news : [NewsModel] = []
        
        let expectation = self.expectation(description: "Fetching")
        
        service.fetch(Constants.Datasource.sourceUrl(.sourceA)()) { (data, error) in
            if error != nil || data == nil { XCTFail() }
            
            news = parser.parse(data: data!, for: .sourceA)
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 15, handler: nil)
        
        var doesExist = false
        
        for one in news {
            if one == manualModel {
                doesExist = true
                break
            }
        }
        
        XCTAssertTrue(doesExist, "The JSON entered manually doesnot conform to any of ther found by the parser in source.")
    }
    
    func test_Cache_SaveAndGet() {
        let meow = "Meow" as AnyObject
        Cache.shared.save(meow, for: meow, lifetime: 10)
        
        let meow2 = Cache.shared.get(meow) as? String
        
        XCTAssertEqual(meow as? String, meow2)
    }
    
    
    func test_Cache_RemovalAfterTimeForSource() {
        let expectation = self.expectation(description: "waitTillISaySo")
        let something = ["meow", "something"] as AnyObject
        Cache.shared.save(something, for: something[0], lifetime: 5)
        
        var isPresent = false
        
        let timer = Timer(timeInterval: 10, repeats: false) { (timer) in
            if Cache.shared.get(something[0]) != nil { isPresent = true }
            expectation.fulfill()
        }
        
        timer.fire()
        waitForExpectations(timeout: 15, handler: nil)

        XCTAssertFalse(isPresent)
    }
}
