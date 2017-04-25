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
        app.buttons["N"].tap()
        app.buttons["Z"].tap()
        
        let showListNavigationBar = app.navigationBars["Show List"]
        showListNavigationBar.buttons["Start"].tap()
        
        let showListButton = showListNavigationBar.buttons["Show List"]
        showListButton.tap()
        showListButton.tap()
        
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
}
