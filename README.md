# MazeRunner
Data Structures Intermediate Project

![](https://github.com/ramonsgds/MazeRunner/blob/master/Images/map1.png)


## Overview

This project is about showing the differences in applying Dijkstra algorithm and A* Search algorithm to a graph containing 26 nodes.

After a users clicks on "Generate Map" on the first screen, a random graph is created. The user then selects a starter node, which is white, and an end node, which is black.

When "Start" is clicked, both Dijkstra and A* Search algorithm are applied to the graph and since the heuristics function is the euclidean distance to the final node, A* Search is guaranteed to find the shortest path at least as fast as Dijkstra algorithm, though both algorithms find the optimal path.

A* Search algorithm is smarter than Dijkstra because of the heuristics function, that looks for the nodes that are closest to the final node. Dijkstra algorithm, on the other hand, is a greedy algorithm and will always explore the nodes with the minimum distance independently of whether such node will lead to a path further away from the final node.

Both implements Min Heaps to sort the nodes with the shortest distances. One can see through the TableView that the heap always peek the node with the minimum priority, f, such that f = g + h (where h = 0 in Dijkstra).

Nodes on the optimal path are highlighted in different colors, from white (starter node) to black (final node), as well as the lines connecting them.

Two TableView show all nodes considered by the algorithms, and proves (in terms of number of nodes considered) that A* Search (with the chosen heuristics) is always at least as fast as Dijkstra to reach the final node.

## Testing
   Extensive Unit and UI tests have been done to ensure quality. Unit and UI tests are supported in the native IDE for iOS: Xcode. To setup Unit or UI tests in Xcode, one should go to Xcode  Test Navigator, and click on the "+" sign, and then on "New Unit Test Target..." or "New UI Test Target...". Once the type of testing is chosen, one should name the test file, choose its specifications, and click "Ok". Now the first thing to be done before writing any test methods is to write ```@testable import <NAME_OF_THE_PROJECT>```, which in this case would be: ```@testable import MazeRunner```. This allows the test class, which is in a different module, to import all classes from the target specified in <NAME_OF_THE_PROJECT>, and therefore import all project's classes.
   
   Once the class has been created, since it inherits from ```XCTestCase ```, two methods are automatically inherited: ```override func setUp()```  and ```override func tearDown() ```. These methods are meant for initialization and destruction of any instances used in tests, the SUT (System Under Test). This means that any test will call ```setUp()``` before calling its own methods and call ```tearDown()``` after its own execution. Therefore, these methods would be similar to a constructor and destructor if single test methods were classes. 
   
   A good practice in TDD (Test-Driven Development) is to create the SUT in```setUp()``` and release it in ```tearDown()```, to ensure a clean state for every test. The latter, is, unfortunately, still not practiced by all developers. Please refer to http://qualitycoding.org/teardown/ to know more about it. **To create a test in Unit or UI tests, one must write functions/methods that begin with the word "test".** Therefore all of these are methods the IDE is going to recognize as test methods and that thus are going to be run when executing tests: ```func test()```, ``` func testExample()```, ```func testingAnything()```, etc. 
   
   To write a Unit test, the SUT should be declared in the class scope. It should be initialized in ```setUp()```, and released in ```TearDown()```. Inside the test method, SUT's methods and instances are accessed to ensure that its methods produce the expected outcome. This is done through assertion methods like ```XCAssertTrue(expression:Bool)```, ```XCAssertFalse(expression:Bool)```, ```XCTAssertEqual(expression1: [Equatable], expression2: [Equatable])```, ```XCAssertNil(expression: Any?)```, etc. A string can also be passed as an additional parameter in all these XCAssert functions to print a message in case the test fails. An example of a real implementation can be found below:
  
   ```swift
import XCTest
@testable import MazeRunner

class MazeRunnerHeapTests : XCTestCase {
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
}
```
  
 UI Tests have exactly the same syntax of Unit tests and are meant for interactions with the User Interface. Since iOS UI testing is still in its infancy, most of it is used to check appearance/existence of UILabels, UIViews, etc..
 To create a UI Test, one should follow the same steps for Unit testing. The only difference is that, once inside the test method, one should click on the red circle button on the bottom part of the IDE in order to start recording touchs. Once all touches are recorded, the stop button should be pressed (on the same place of the red circle button) in order to finish the recording. Once tests are run, the simulator emulates all touches that were recorded and through XCAssert statements, UI tests verify the expectations related to UI.
 
 Both iOS Unit and UI tests have still somewhat of a limited scope, and for this reason, workarounds like Mock objects or Studs are used.
 It is important to mention that both Unit and UI test methods should be independently from others, so that a failure in one test cannot cause another test to fail. In this way, developing tests to be independent, one can ensure that a failure of a test is related to only a single hypothesis, i.e, a SUT's specific method or variable is wrong.
 
 Finally, to run a single test, press on the play button next to its name. To run all tests in the project, press Cmd+U or press the "Run button" (Play symbol) on the top left corner, and a menu will open. Select "Test" (Screwdriver symbol) and click on it. Tests will then run. If a test succeeds, it will get a green checkmark. Otherwise, a red X will appear next to it, indicating it failed. If all of them pass, the overall test suite succeeded, and a "Tests succeeded" figure will appear. If at least one of them fail, the overall test suite failed and a "Tests failed" will appear.

## Implementation
  The project is structured in two ```UIViewController```s, namely ```ViewController``` - which is the initial view controller (screen) in which the user taps to generate the map - and ```MazeViewController```, which is the view controller in which most of the tasks happen. 
  
  First, all nodes and links between them are created in the ```GenerateMaze()``` method, which calls ```CreateNode()``` 26 times, and create links in the ```CreatePath()``` method, which creates about 1.5 more links than nodes, connecting about 3 times as many cities as there are in the system. A Node is represented by its class ```Node```. To make communication between UI and the ```Node``` class, ```UIButton``` is used to receive user input and dictionaries are implemented to pass data between ```UIButton```s in the screen  and ```Node``` instances. A ```Line``` class is used similarly to make the visual representation of a link between two ```UIButton```s, while the actual link is stored in a dictionary relating a ```Node``` instance to another ```Node``` instance. 
  
  ```MazeHeap.swift``` file is used for creating the heap. A heap is used to sort the next node to come while considering the candidate nodes for the shortest-path. All functions related to the heap structure are implemented and tested, both public - as  ```add(node: Node)```, ```Peek()```, ```Pop()```, ```update(node: Node)```, ```isEmpty()``` -  and private, as ```heapifyUp(pos: Int)```, ```heapifyDown(pos: Int)```, ```swap()```, etc.
  
  ```Main.storyboard``` is the main ```UIStoryboard```, a visual representation of the user interface, showing screens of content and the connections between those screens. ```NavigationController``` is a special kind of view controller that manages a stack of view controllers and their corresponding views. It's an ideal way to display hierarchical data. The Navigation Controller is always initialized with a root view controller; this will be the starting view at the bottom of the stack.
  
    
  After user interaction (selection of start and end nodes, and "Start" clicked) both Dijkstra and A-Star algorithms run.
  
  Time complexity of Dijkstra algorithm is O((|V| + |E|) * log|V|) as a Min-Heap is used. The time complexity of A-Star algorithm is also polynomial with the chosen heuristics (Euclidean distance), but better or at least equal to Dijkstra in all cases. The algorithms run with no bottlenecks or performance instability, for the small number of nodes, 26, requires little computer power. In this project, V = 26, and E = 26* 1.5 = 39.
  

## Usage

To use this project, please first install the IDE, XCode, by clicking on the following link: https://itunes.apple.com/us/app/xcode/id497799835?mt=12.

Once installed, clone the project manually to your local environment in a destination of your choice.

Then open Xcode, and a initialization menu will appear, in which you are able to see projects that are available. MazeRunner will be available in the list. Another option is to go directly to the MazeRunner folder in your chosen directory and open the file MazeRunner.xcodeproj, which is the executable that Xcode will run and that contains all the project.

To Run the project, press Cmd+R or click on the top-left corner in the "Run button", with a "Play" symbol. If a simulator is chosen, it will be loaded (only for the first time) and run the project. If a device is chosen, the iPhone will load the app and run it. Then, click on "Generate Map" to generate the map, which will segue to the next screen. Choose two circles, or nodes. The first one will be white, indicating the "origin city" or starting point, and the second will be black, indicating the "destination city" or end point. Click on "Start" button on top-right corner, and both ```ApplyDijkstra()``` and ```ApplyAStar()``` will be called, running Dijkstra and A-Star algorithms considering the start and end points selected by the user by touch beforehand. Lines with different colors will appear indicating the path from the start node to end node (The darker the line the closest to the destination node), and since these algorithms were applied, this path is certain to be the minimum. Click on "Show List" to see the list of nodes considered by these algorithms (with each node indicating the previous node that originated that node) and check how A-Star with the chosen heuristics is at least as fast as Dijkstra.
