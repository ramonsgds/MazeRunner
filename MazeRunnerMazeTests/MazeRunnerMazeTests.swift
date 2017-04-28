//
//  MazeRunnerMazeTests.swift
//  MazeRunnerMazeTests
//
//  Created by Ramon Goncalves da Silva on 4/21/17.
//  Copyright © 2017 ramon. All rights reserved.
//

import XCTest
@testable import MazeRunner

class MazeRunnerMazeTests: XCTestCase {
    
    var controller : MazeViewController!
    
    override func setUp() {
        super.setUp()
        
        controller = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MazeViewController") as! MazeViewController
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        controller = nil
        super.tearDown()
    }
    
    func testCreateNode() {
        XCTAssertEqual(controller.nodes.count, 0, "Node array should be empty")
        controller.createNode()
        XCTAssertEqual(controller.nodes.count, 1, "Node should be incremented by 1")
        controller.createNode()
        XCTAssertEqual(controller.nodes.count, 2, "Node should be incremented by 1")
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testGenerateMaze(){
        XCTAssertEqual(controller.nodes.count, 0,  "Node array should be empty")
        controller.generateMaze(numberOfNodes: 26)
        XCTAssertEqual(controller.nodes.count, 26, "Node array should have 26 items")
    }
    
    
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
