//
//  SeaSwiftAndSun_SimplonTests.swift
//  SeaSwiftAndSun-SimplonTests
//
//  Created by Keyhan Mortezaeifar on 13/12/2023.
//

import XCTest

final class SeaSwiftAndSun_SimplonTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    func testLoadedImage() async throws {
        var spotImage = await UIImageView()
        let imageURL = URL(string: "https://source.unsplash.com/random/300x200")!
        let imageFetcher: () =  await spotImage.load(url: (imageURL))

        XCTAssertNotNil(imageFetcher)
    }
    
    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        measure {
            // Put the code you want to measure the time of here.
        }
    }

}
