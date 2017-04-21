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
        heap = nil
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
    
    func testAdditionTwoElements(){
        let node = Node(name: "example", location: CGPoint(), priority: 0.0)
        let node2 = Node(name: "example2", location: CGPoint(), priority: 10.0)
        heap.add(node: node)
        heap.add(node: node2)
        XCTAssertEqual(heap.length(), 2, "Heap should have only one node")
    }
    
    func testAdditionTenElements(){
        for index in 1...10{
            let node = Node(name: "example", location: CGPoint(), priority: 0.0)
            heap.add(node: node)
        }
        XCTAssertEqual(heap.length(), 10, "Heap should have only one node")
    }
    
    func testAddition100Elements(){
        for index in 1...100{
            let node = Node(name: "example", location: CGPoint(), priority: 0.0)
            heap.add(node: node)
        }
        XCTAssertEqual(heap.length(), 100, "Heap should have one hundred nodes")
    }
    
    func testPeek(){
        let node = Node(name: "example", location: CGPoint(), priority: 0.0)
        heap.add(node: node)
        XCTAssertEqual(heap.peek().getName(), node.getName())
    }
    
    func testDeletion(){
        let node = Node(name: "example", location: CGPoint(), priority: 0.0)
        heap.add(node: node)
        heap.pop()
        XCTAssertEqual(heap.isEmpty(), true, "Heap should be empty")
    }
    
    func testHeapifyUp(){
        
    }
    
    func testHeapifyDown(){
        
    }
    
    func testUpdate(){
        
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
}
