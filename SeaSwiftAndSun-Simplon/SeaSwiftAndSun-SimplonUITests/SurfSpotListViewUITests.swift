//
//  SurfSpotListViewUITests.swift
//  SeaSwiftAndSun-SimplonUITests
//
//  Created by Dina RAZAFINDRATSIRA on 13/12/2023.
//

import XCTest

final class SurfSpotListViewUITests: XCTestCase {
    var app: XCUIApplication!
    override func setUpWithError() throws {
        continueAfterFailure = false
        app = XCUIApplication()
        app.launch()
    }
    
    func testTitleIsPresent() throws {
        let navigationBar = app.navigationBars["SurfSpotsNavigationBar"]
        XCTAssertTrue(navigationBar.waitForExistence(timeout: 10))

        // Check if the title is present
        XCTAssertTrue(navigationBar.staticTexts["Surf Spots"].exists)
    }
    
}
