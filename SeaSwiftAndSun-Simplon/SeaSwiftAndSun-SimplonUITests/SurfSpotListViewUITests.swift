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
    
    func testTableViewIsPresent() throws {
        let tableView = app.tables["SurfSpotsTableView"]
        XCTAssertTrue(tableView.waitForExistence(timeout: 10))
    }
    
    func testSectionHeaderIsPresent() throws {
        let tableView = app.tables["SurfSpotsTableView"]
        let sectionHeader = tableView.otherElements["SectionHeader"]
        XCTAssertTrue(sectionHeader.exists)
    }
    
    func testCellsArePresent() throws {
        let tableView = app.tables["SurfSpotsTableView"]
        XCTAssertTrue(tableView.waitForExistence(timeout: 10))
        
        let cellsQuery = tableView.cells.matching(identifier: "SpotCell")
        XCTAssertTrue(cellsQuery.count > 0)
        
        let firstCell = cellsQuery.element(boundBy: 0)
        XCTAssertTrue(firstCell.waitForExistence(timeout: 5))
        
        firstCell.tap()
    }
    
    
}
