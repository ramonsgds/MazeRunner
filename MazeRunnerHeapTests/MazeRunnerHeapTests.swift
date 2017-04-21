//
//  MazeRunnerHeapTests.swift
//  MazeRunnerHeapTests
//
//  Created by Ramon Goncalves da Silva on 4/21/17.
//  Copyright © 2017 ramon. All rights reserved.
//

import XCTest
@testable import MazeRunner

class MazeRunnerHeapTests: XCTestCase {
    
    var heap : MazeHeap!
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        heap = MazeHeap()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        
        super.tearDown()
    }
    
    func testIsEmpty(){
        XCTAssertNotNil(heap)
        XCTAssertEqual(heap.isEmpty(), true)
    }
    
    func testAddition(){
        let node = Node(name: "example", location: CGPoint(), priority: 0.0)
        heap.add(node: node)
        XCTAssertEqual(heap.length(), 1, "Heap should have only one node")
    }
    
    func testPeek(){
        let node = Node(name: "example", location: CGPoint(), priority: 0.0)
        heap.add(node: node)
        XCTAssertEqual(heap.peek(), node)
    }
    
    func testDeletion(){
        let node = Node(name: "example", location: CGPoint(), priority: 0.0)
        heap.add(node: node)
        heap.pop()
        XCTAssertEqual(heap.length(), 0, "Heap should be empty")
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
    
}
