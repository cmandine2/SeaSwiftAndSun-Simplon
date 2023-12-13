//
//  SeaSwiftAndSun_SimplonTests.swift
//  SeaSwiftAndSun-SimplonTests
//
//  Created by Keyhan Mortezaeifar on 13/12/2023.
//

import XCTest

final class SeaSwiftAndSun_SimplonTests: XCTestCase {
    func testLoadedImage() async throws {
        let spotImage = await UIImageView()
        let imageURL = URL(string: "https://source.unsplash.com/random/300x200")!
        let imageFetcher: () =  await spotImage.load(url: (imageURL))

        XCTAssertNotNil(imageFetcher)
    }
}
