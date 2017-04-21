//
//  MazeRunnerGeneralTests.swift
//  MazeRunnerGeneralTests
//
//  Created by Ramon Goncalves da Silva on 4/21/17.
//  Copyright © 2017 ramon. All rights reserved.
//

import XCTest
@testable import MazeRunner

class MazeRunnerGeneralTests: XCTestCase {
    
    var controller : ViewController!
    
    override func setUp() {
        super.setUp()
        controller = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ViewController") as! ViewController
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        controller = nil
        super.tearDown()
    }
    
    func testButton(){
        //XCTAssertEqual(controller.mapButton.layer.cornerRadius, 10, "CornerRadius should be 10")
        //XCTAssertEqual(controller.mapButton.backgroundColor, UIColor.white, "BackgroundColor should be white")
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
