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
        for _ in 1...10{
            let node = Node(name: "example", location: CGPoint(), priority: 0.0)
            heap.add(node: node)
        }
        XCTAssertEqual(heap.length(), 10, "Heap should have only one node")
    }
    
    func testAddition100Elements(){
        for _ in 1...100{
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
    
    func testHeapifyUpSimple(){
        let node1 = Node(name: "example1", location: CGPoint(), priority: 100.0)
        let node2 = Node(name: "example2", location: CGPoint(), priority: 99.0)
    
        heap.add(node: node1)
        heap.add(node: node2)
        XCTAssertEqual(heap.length(), 2, "Heap should have two nodes")
        XCTAssertEqual(heap.peek(), node2, "Node2 should have greatest priority")
    }
    
    func testHeapifyUpComplex(){
        let node1 = Node(name: "example1", location: CGPoint(), priority: 100.0)
        let node2 = Node(name: "example2", location: CGPoint(), priority: 50.0)
        heap.add(node: node1)
        heap.add(node: node2)
        XCTAssertEqual(heap.peek(), node2, "Root should be node 2")
        let node3 = Node(name: "example3", location: CGPoint(), priority: 20.0)
        heap.add(node: node3)
        XCTAssertEqual(heap.peek(), node3, "Root should be node 3")
        let node4 = Node(name: "example4", location: CGPoint(), priority: 15.0)
        heap.add(node: node4)
        XCTAssertEqual(heap.peek(), node4, "Root should be node 4")
        let node5 = Node(name: "example5", location: CGPoint(), priority: 25.0)
        heap.add(node: node5)
        XCTAssertEqual(heap.peek(), node4, "Root should still be node 4")
        XCTAssertEqual(heap.length(), 5, "Heap should have five nodes")
    }
    
    func testHeapifyDown(){
        let node1 = Node(name: "example1", location: CGPoint(), priority: 100.0)
        let node2 = Node(name: "example2", location: CGPoint(), priority: 50.0)
        let node3 = Node(name: "example2", location: CGPoint(), priority: 25.0)
        let node4 = Node(name: "example2", location: CGPoint(), priority: 40.0)
        heap.add(node: node1)
        heap.add(node: node2)
        heap.add(node: node3)
        heap.add(node: node4)
        heap.pop()
        XCTAssertEqual(heap.peek() , node4, "Node4 should have greatest priority")
        heap.pop()
        XCTAssertEqual(heap.peek(), node2, "Node2 should be now the root")
        heap.pop()
        XCTAssertEqual(heap.peek(), node1, "Node1 should be the root")
        heap.pop()
        XCTAssertTrue(heap.isEmpty())
    }

    func testUpdate(){
        let node1 = Node(name: "example1", location: CGPoint(), priority: 100.0)
        let node2 = Node(name: "example2", location: CGPoint(), priority: 70.0)
        heap.add(node: node1)
        heap.add(node: node2)
        XCTAssertEqual(heap.peek(), node2, "Node2 is the root")
        node1.setPriority(f: 50.0)
        XCTAssertEqual(node1.getPriority(), 50, "Node1 should have new priority equal to 50")
        heap.update(node: node1)
        XCTAssertEqual(heap.peek(), node1, "Node1 now is the root")
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
}
