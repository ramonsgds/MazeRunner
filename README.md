# MazeRunner
Data Structures Intermediate Project


This project is about showing the differences in applying Dijkstra algorithm and A* Search algorithm to a graph containing 26 nodes.

After a users clicks on "Generate Map" on the first screen, a random graph is created. The user then selects a starter node, which is white, and an end node, which is black.

When "Start" is clicked, both Dijkstra and A* Search algorithm are applied to the graph and since the heuristics function is the euclidean distance to the final node, A* Search is guaranteed to find the shortest path at least as fast as Dijkstra algorithm, though both algorithms find the optimal path.

A* Search algorithm is smarter than Dijkstra because of the heuristics function, that looks for the nodes that are closest to the final node. Dijkstra algorithm, on the other hand, is a greedy algorithm and will always explore the nodes with the minimum distance independently of whether such node will lead to a path further away from the final node.

Both implements Min Heaps to sort the nodes with the shortest distances. One can see through the TableView that the heap always peek the node with the minimum priority, f, such that f = g + h (where h = 0 in Dijkstra).

Nodes on the optimal path are highlighted in different colors, from white (starter node) to black (final node), as well as the lines connecting them.

Two TableView show all nodes considered by the algorithms, and proves (in terms of number of nodes considered) that A* Search (with the chosen heuristics) is always at least as fast as Dijkstra to reach the final node.


# Usage

To import the project, add manually the files to your existing project and either initializes the classes (Node,Line, MazeHeap) through their constructors or make your view controller inherit from MazeViewController.


```swift

class MyClassViewController : MazeHeapViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let node1 = Node(name: "A", location: CGPoint(x: 150, y: 150), priority: "0")
        let node2 = Node(name: "B", location: CGPoint(x: 20, y: 400), priority: "10000")
        let lineView = Line(frame: self.view.frame, node1: node1, node2: node2, color: UIColor.white(), thickness: 1.5)
        let heap = MazeHeap()
        heap.add(node1)
        
        applyAStar()
        applyDijkstra()
    }
}
```
