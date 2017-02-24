# MazeRunner
Data Structures Intermediate Project


This project is about showing the differences in applying Dijkstra algorithm and A* Search algorithm to a graph containing 26 nodes.

After a users clicks on "Generate Map" on the first screen, a random graph is created. The user then selects a starter node, which is white, and an end node, which is black.

When "Start" is clicked, both Dijkstra and A* Search algorithm are applied to the graph and since the heuristics function is the euclidean distance to the final node, A* Search is guaranteed to find the shortest path at least as fast as Dijkstra algorithm, though both algorithms find the optimal path.

A* Search algorithm is smarter than Dijkstra because of the heuristics function, that looks for the nodes that are closest to the final node. Dijkstra algorithm, on the other hand, is a greedy algorithm and will always explore the nodes with the minimum distance independently of whether such node will lead to a path further away from the final node.

Both implements Min Heaps to sort the nodes with the shortest distances. One can see through the TableView that the heap always peek the node with the minimum priority, f, such that f = g + h (where h = 0 in Dijkstra).

Nodes on the optimal path are highlighted in different colors, from white (starter node) to black (final node), as well as the lines connecting them.

Two TableView show all nodes considered by the algorithms, and proves (in terms of number of nodes considered) that A* Search (with the chosen heuristics) is always at least as fast as Dijkstra to reach the final node.




