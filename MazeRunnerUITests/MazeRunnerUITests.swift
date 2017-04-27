//
//  MazeRunnerUITests.swift
//  MazeRunnerUITests
//
//  Created by Ramon Goncalves da Silva on 4/24/17.
//  Copyright © 2017 ramon. All rights reserved.
//

import XCTest

class MazeRunnerUITests: XCTestCase {
        
    override func setUp() {
        super.setUp()
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // Use recording to get started writing UI tests.
        
        let app = XCUIApplication()
        app.buttons["Generate Map"].tap()
        app.buttons["H"].tap()
        app.buttons["M"].tap()
        app.navigationBars["Show List"].buttons["Start"]
        
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testTableViewCount(){
        let app = XCUIApplication()
        app.buttons["Generate Map"].tap()
        XCTAssertEqual(app.tables.cells.count, 0, "Table views should be empty")
        app.buttons["H"].tap()
        app.buttons["M"].tap()
        app.navigationBars["Show List"].buttons["Start"].tap()
        app.navigationBars["Show List"].buttons["Show List"].tap()
        XCTAssertNotEqual(app.tables.cells.count, 0, "Table views should be filled")
    }
    
    func test(){
        //testing things
    }
}
