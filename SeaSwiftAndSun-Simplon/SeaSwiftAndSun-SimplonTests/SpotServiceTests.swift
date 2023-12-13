//
//  SpotServiceTests.swift
//  SeaSwiftAndSun-SimplonTests
//
//  Created by Keyhan Mortezaeifar on 13/12/2023.
//

//import XCTest
//
//final class SpotServiceTests: XCTestCase {
//
//    override func setUpWithError() throws {
//        // Put setup code here. This method is called before the invocation of each test method in the class.
//    }
//
//    override func tearDownWithError() throws {
//        // Put teardown code here. This method is called after the invocation of each test method in the class.
//    }
//
//    func testExample() throws {
//        // This is an example of a functional test case.
//        // Use XCTAssert and related functions to verify your tests produce the correct results.
//        // Any test you write for XCTest can be annotated as throws and async.
//        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
//        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
//    }
//
//    func testPerformanceExample() throws {
//        // This is an example of a performance test case.
//        self.measure {
//            // Put the code you want to measure the time of here.
//        }
//    }
//
//}

import XCTest
@testable import SeaSwiftAndSun_Simplon

class SpotServiceTests: XCTestCase {
    
    // Mock URLSession for testing purposes
    class MockURLSession: URLSession {
        var mockData: Data?
        var mockResponse: URLResponse?
        var mockError: Error?
        
        init(mockData: Data? = nil, mockResponse: URLResponse? = nil , mockError: Error? = nil) {
            self.mockData = mockData
            self.mockResponse = mockResponse
            self.mockError = mockError
        }
        
        override func dataTask(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
            let task = MockURLSessionDataTask()
            task.completionHandler = completionHandler
            task.mockData = mockData
            task.mockResponse = mockResponse
            task.mockError = mockError
            return task
        }
    }
    
    class MockURLSessionDataTask: URLSessionDataTask {
        var mockData: Data?
        var mockResponse: URLResponse?
        var mockError: Error?
        var completionHandler: ((Data?, URLResponse?, Error?) -> Void)?
        
        override func resume() {
            completionHandler?(mockData, mockResponse, mockError)
        }
    }
    
    func testGetSpotSuccess() {
        let spotService = SpotService(session: MockURLSession(mockData: FakeResponseData.correctData, mockResponse: FakeResponseData.responseOK, mockError: nil))
        // When
        let expectation = XCTestExpectation(description: "Wait to be on the main queue")
        spotService.getSpot { error, spot in
            // Then
            XCTAssertNil(error)
            XCTAssertNotNil(spot)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 1)
    }
    
    func testGetSpotFailedWithError() {
        // Given
        let quoteService = SpotService(session: MockURLSession(mockData: nil, mockResponse: FakeResponseData.responseKO, mockError: FakeResponseData.error))
        // When
        let expectation = XCTestExpectation(description: "Wait to be on the main queue")
        quoteService.getSpot { error, spot in
            // Then
            XCTAssertNotNil(error)
            XCTAssertNil(spot)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 1)
    }
}
