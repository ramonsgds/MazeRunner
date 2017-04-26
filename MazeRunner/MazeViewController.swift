//
//  MazeViewController.swift
//  MazeRunner
//
//  Created by Ramon Goncalves da Silva on 2/18/17.
//  Copyright © 2017 ramon. All rights reserved.
//

import UIKit

class MazeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var listButton: UIButton!
    
    @IBOutlet var startBarButton: UIBarButtonItem!
    var nodes = [Node]()
    
    var locations = [CGPoint]()
    
    var nodeToButton = [String:UIButton]()
    
    var buttonToNode = [String: Node]()
    
    let size : CGFloat = 28
    
    var pathsOnNode = [String: [Node]]()
    
    var startButton : UIButton!
    
    var endButton : UIButton!
    
    var toggle = 0
    
    var loadedView = false
    
    let dkHeap = MazeHeap()
    
    let starHeap = MazeHeap()
    
    var dkPrev = [String : Node]()
    
    var starPrev = [String : Node]()
    
    var dkVisited = [String: Bool]()
    
    var starVisited = [String: Bool]()
    
    var pathNodes = [Node]()
    
    var usedLines = [Line]()
    
    var dkUsedNodes = [Node]()
    
    var starUsedNodes = [Node]()
    
    var blurView : UIVisualEffectView!
    
    @IBOutlet var dkTableView: UITableView!

    @IBOutlet var starTableView: UITableView!
    
    @IBOutlet var dkLabel: UILabel!
    
    @IBOutlet var starLabel: UILabel!
    
    @IBOutlet var totalDkLabel: UILabel!
    
    @IBOutlet var totalDkResult: UILabel!
    
    @IBOutlet var totalStarLabel: UILabel!
    
    @IBOutlet var totalStarResult: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupListView()
        // Do any additional setup after loading the view.
    }

    
    @IBAction func findPath(_ sender: Any) {
        if usedLines.count == 0 {
            
            //Alert if no start or end button were chosen.
            if (startButton == nil || endButton == nil ){
                let alert = UIAlertController(title: "Error", message: "Please select a start and end node", preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
                return
            }
            
            //Alert if trying to find a path between two nodes and at least one of the nodes are completely isolated.
            if (pathsOnNode[(buttonToNode[(startButton.titleLabel?.text)!]?.getName())!] == nil || pathsOnNode[(buttonToNode[(endButton.titleLabel?.text)!]?.getName())!] == nil) {
                let alert = UIAlertController(title: "Result", message: "There's no path between chosen nodes", preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
                return
            }
            
            
            applyAStar()
            applyDijkstra()
        }
    }
  
    
    func applyAStar(){
        for node in nodes {
            starVisited[node.getName()] = false
        }
        
        let startNode = self.buttonToNode[(startButton.titleLabel?.text)!]
        starVisited[(startNode?.getName())!] = true
        let finalNode = self.buttonToNode[(endButton.titleLabel?.text)!]
        startNode?.setPriority(f: 0 + Double((startNode?.getCenter().distance(toPoint: (finalNode?.getCenter())!))!))
        starHeap.add(node: startNode!)
        
        while (!starHeap.isEmpty()){
            let curr = starHeap.peek()
            let newNode = Node(name: curr.getName(), location: curr.getCenter(), priority: curr.getPriority())
            starUsedNodes.append(newNode) //Make a brand new copy of a node so that a node's priority is not overriden when Dijsktra, which is applied after A*, happens. Then, since A* and Dijkstra are not referencing the same nodes anymore, Dijkstra will not override the nodes' priorities that A* references.
            starHeap.pop()
            let neighbors : [Node] = pathsOnNode[(curr.getName())]!
            for (index, neighbor) in neighbors.enumerated() {
                
                let g : Double = curr.getPriority() + Double(neighbor.getCenter().distance(toPoint: (curr.getCenter())))
                let h : Double = Double(neighbor.getCenter().distance(toPoint: (finalNode!.getCenter())))
                let f : Double = g + h
                
                if starVisited[neighbor.getName()]! == false || f < neighbor.getPriority() {
                    neighbor.setPriority(f: f)
                    starPrev[neighbor.getName()] = curr
                    if starVisited[neighbor.getName()] == false{
                        starVisited[neighbor.getName()] = true
                        starHeap.add(node: neighbor)
                    }
                    else{
                        starHeap.update(node: neighbor)
                    }
                }
            }
            if curr.getName() == finalNode!.getName() {
                totalStarResult.text = "\(starUsedNodes.count)"
                starTableView.reloadData()
                printResult(startNode: startNode!, finalNode: finalNode!) //Show path on screen
            }
        }
    }
    
    func applyDijkstra() {
        
        for node in nodes {
            dkVisited[node.getName()] = false
        }
        
        
        let startNode = self.buttonToNode[(startButton.titleLabel?.text)!]
        dkVisited[(startNode?.getName())!] = true
        startNode?.setPriority(f: 0)
        dkHeap.add(node: startNode!)
        let finalNode = self.buttonToNode[(endButton.titleLabel?.text)!]
        //print("PEEK NODE = \(finalNode?.getName()) - \(finalNode?.getPriority())")
        
        while (!dkHeap.isEmpty()){
            var curr = dkHeap.peek()    // get node with minimum priority (distance from the starter node)
            
            let newNode = Node(name: curr.getName(), location: curr.getCenter(), priority: curr.getPriority()) //create a copy of a node so that a-start tableview is not overriden by dijkstra's tableview with different priorities.
            
            dkUsedNodes.append(newNode) // add copies of nodes to array of all nodes considered by dijkstra
            
            dkHeap.pop()
            let neighbors : [Node] = pathsOnNode[(curr.getName())]!
           
            for (index, neighbor) in neighbors.enumerated() {
               
                let tentativePriority : Double = curr.getPriority() + Double(neighbor.getCenter().distance(toPoint: (curr.getCenter())))
                
                if dkVisited[neighbor.getName()]! == false || tentativePriority < neighbor.getPriority() {
                    neighbor.setPriority(f: tentativePriority)
                    dkPrev[neighbor.getName()] = curr
                    if dkVisited[neighbor.getName()] == false{
                        dkVisited[neighbor.getName()] = true
                        dkHeap.add(node: neighbor)
                    }
                    else{
                        dkHeap.update(node: neighbor)
                    }
                }
            }
            if curr == finalNode! {
                totalDkResult.text = "\(dkUsedNodes.count)"
                dkTableView.reloadData()
                //Note that printResult(...) is not called here again because path is always equal (optimal) for A* and Dijkstra.
            }
        }
    }
    
    func printResult(startNode: Node, finalNode: Node){
        pathNodes.append(finalNode)
        var previous : Node = starPrev[finalNode.getName()]!
        while (previous != startNode) {
            pathNodes.append(previous)
            previous = starPrev[previous.getName()]!
        }
        pathNodes.append(startNode)
        pathNodes.reverse() // get path array in right order, from starter to end node.
        
        for i in 0...(pathNodes.count - 1) {
            let degree : Float = Float( Double(i) / Double(pathNodes.count - 1))
            let color = UIColor(colorLiteralRed: 1.0 - degree , green: 1.0 - degree , blue: 1.0 - degree , alpha: 1.0)
            nodeToButton[pathNodes[i].getName()]?.layer.borderColor = color.cgColor
            nodeToButton[pathNodes[i].getName()]?.backgroundColor = color
            nodeToButton[pathNodes[i].getName()]?.setTitleColor(UIColor(colorLiteralRed: 237.0/255.0, green: 76.0/255.0, blue: 79.0/255.0, alpha: 1.0), for: .normal)
            
            if i + 1 < pathNodes.count{ // create the emphasized lines showing the path from starter to end node.
                let lineView = Line(frame: self.view.frame, node1: pathNodes[i], node2: pathNodes[i+1], color: color, thickness: 1.5)
                lineView.isOpaque = false
                self.view.insertSubview(lineView, belowSubview: nodeToButton[nodes[0].getName()]!)
                usedLines.append(lineView)
            }
        }
        
        listButton.alpha = 1.0
        listButton.isUserInteractionEnabled = true
    }
    
    func generateMaze(numberOfNodes: Int ){
        for index in 0...numberOfNodes - 1 {
            createNode()
        }
        
        for index in 0...(Int((Double(nodes.count) * 1.5)) - 1)  {
            createPath()
        }
    }
    
    func createPath(){
        let node1 = nodes[Int(arc4random_uniform(UInt32(nodes.count)))]
        let node2 = nodes[Int(arc4random_uniform(UInt32(nodes.count)))]
        if (node1 != node2){                // Check if not trying to add a path from a node to itself
            var arr1 = pathsOnNode[node1.getName()]             // Check if there is any path on that node
            if arr1 != nil {                                    // if yes, check if trying to add a path on an existing path
                for index in 0...((arr1?.count)! - 1){
                    if node2 == arr1?[index] { //if path is duplicate, return
                        return
                    }
                }
            }
            else{                                               // if not, create a new empty array
                pathsOnNode[node1.getName()] = [Node]()
            }
        
            var arr2 = pathsOnNode[node2.getName()]             // Do the same as above for node 2
            if arr2 != nil {
                for index in 0...((arr2?.count)! - 1){
                    if node1 == arr2?[index] {
                        return
                    }
                }
            }
            else{
                pathsOnNode[node2.getName()] = [Node]()
            }
            
            pathsOnNode[node1.getName()]?.append(node2)     // add node2 to node1's array of neighbors
            pathsOnNode[node2.getName()]?.append(node1)     // add node1 to node2's array of neighbors
            
            let path = Line(frame: self.view.frame, node1: node1, node2: node2, color: UIColor.white, thickness: 0.2)
            path.isOpaque = false
            self.view.insertSubview(path, at: 1)
        }
    }
    
    func createNode(){
        let positionX = UInt32(size) + arc4random_uniform(UInt32(self.view.frame.width - size * 2 ) )
        let positionY = 64 + arc4random_uniform(UInt32(self.view.frame.height - size - 64))
        let location = CGPoint(x:CGFloat(positionX), y:  CGFloat(positionY))
        let btn = UIButton(frame: CGRect(x: CGFloat(positionX), y: CGFloat(positionY), width: size, height: size))
        btn.addTarget(self, action: #selector(tapOnButton(sender:)), for: .touchDown)
        print(btn.frame)
        btn.layer.cornerRadius = btn.frame.width / 2.0
        btn.layer.borderColor = UIColor.white.cgColor
        btn.layer.borderWidth = 1.5
        btn.titleLabel?.textColor = UIColor.white
        btn.tintColor = UIColor.white
        btn.titleLabel?.textAlignment = .center
       
        while(fixProximity(btn: btn)){ // Fix button position if it gets too close of another button's position
            let positionX = UInt32(size) + arc4random_uniform(UInt32(self.view.frame.width - size * 2 ))
            let positionY = UInt32(size/2.0) + 64 + arc4random_uniform(UInt32(self.view.frame.height - 64 - size))
            let newLoc = CGPoint(x:CGFloat(positionX), y:  CGFloat(positionY))
            btn.center = newLoc
        }
        
        
        locations.append(btn.center)
        btn.setTitle(getNextLetter(), for: .normal)
        
        let node = Node(name: (btn.titleLabel?.text)!, location: btn.center, priority: 100000000)
    
        self.nodeToButton[node.getName()] = btn
        self.buttonToNode[(btn.titleLabel?.text)!] = node
        
        self.nodes.append(node)
        self.view.addSubview(btn)
    }
    
    func tapOnButton(sender: UIButton){
        
        // Clean last search, emptying table views, restoring path buttons to normal and removing emphasized lines
        if dkUsedNodes.count > 0 || starUsedNodes.count > 0 || pathNodes.count > 0 || usedLines.count > 0{
            dkUsedNodes.removeAll()
            dkTableView.reloadData()
            starUsedNodes.removeAll()
            starTableView.reloadData()
            totalStarResult.text = ""
            totalDkResult.text = ""
            
            for line in usedLines {
                line.removeFromSuperview()
            }
            
            usedLines.removeAll()
            
            for (index, node) in pathNodes.enumerated() {
                nodeToButton[node.getName()]?.layer.borderColor = UIColor.white.cgColor
                nodeToButton[node.getName()]?.backgroundColor = UIColor.clear
                nodeToButton[node.getName()]?.setTitleColor(UIColor.white, for: .normal)
            }
            pathNodes.removeAll()

        }
        
        if toggle == 0 {    // Set start button
            if endButton != nil {
                if sender == endButton{  /* Do not allow trying to set same button as both start and end buttons */              return
                }
                endButton.backgroundColor = UIColor.black
                endButton.layer.borderColor = UIColor.black.cgColor
                endButton.setTitleColor(UIColor(colorLiteralRed: 237.0/255.0, green: 76.0/255.0, blue: 79.0/255.0, alpha: 1.0), for: .normal)
            }
            
            if startButton != nil && sender != startButton {
                startButton.backgroundColor = UIColor.clear
                startButton.layer.borderColor = UIColor.white.cgColor
                startButton.setTitleColor(UIColor.white, for: .normal)
            }
            startButton = sender
            toggle = 1
            sender.backgroundColor = UIColor.white
            sender.layer.borderColor = UIColor.white.cgColor
        }
        else{   //Set end button
            if startButton != nil {
                if sender == startButton{   /* Do not allow trying to set same button as both start and end buttons */
                    return
                }
                startButton.backgroundColor = UIColor.white
                startButton.layer.borderColor = UIColor.white.cgColor
                startButton.setTitleColor(UIColor(colorLiteralRed: 237.0/255.0, green: 76.0/255.0, blue: 79.0/255.0, alpha: 1.0), for: .normal)
            }
            if endButton != nil && sender != endButton {
                endButton.backgroundColor = UIColor.clear
                endButton.layer.borderColor = UIColor.white.cgColor
                endButton.setTitleColor(UIColor.white, for: .normal)
            }
            endButton = sender
            toggle = 0
            sender.backgroundColor = UIColor.black
            sender.layer.borderColor = UIColor.black.cgColor
        }
        sender.setTitleColor(UIColor(colorLiteralRed: 237.0/255.0, green: 76.0/255.0, blue: 79.0/255.0, alpha: 1.0), for: .normal)
    }
    
    func fixProximity(btn: UIButton) -> Bool {
        if  locations.count == 0  { // If there isn't a location yet to be considered, accept this location as valid.
            return false
        }
        print(locations.count)
        for index in 0...(locations.count - 1) {
            if btn.center.distance(toPoint: locations[index]) < size * 2.5  { // If tentative location is too close, try again.
                return true
            }
        }
        return false
    }
    
    func getNextLetter() -> String {
        let uppercaseLetters = Array(65...90).map {String(UnicodeScalar($0))}
        return uppercaseLetters[locations.count - 1]
    }
    
    
    override func viewDidLayoutSubviews() {
        if loadedView == false {
            generateMaze(numberOfNodes: 26)
            loadedView = true
            setupListView()
        }
    }
    
    @IBAction func showList(_ sender: Any) {
        if blurView.alpha == 0 {
            blurView.alpha = 1
            dkTableView.alpha = 1
            starTableView.alpha = 1
            dkLabel.alpha = 1
            starLabel.alpha = 1
            totalDkLabel.alpha = 1
            totalDkResult.alpha = 1
            totalStarLabel.alpha = 1
            totalStarResult.alpha = 1
        }
        else{
            blurView.alpha = 0
            dkTableView.alpha = 0
            starTableView.alpha = 0
            dkLabel.alpha = 0
            starLabel.alpha = 0
            totalDkLabel.alpha = 0
            totalDkResult.alpha = 0
            totalStarLabel.alpha = 0
            totalStarResult.alpha = 0
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setupListView(){
        listButton.layer.cornerRadius = 13.0
        listButton.alpha = 0.3
        listButton.isUserInteractionEnabled = false
        let blurEffect = UIBlurEffect(style: .dark)
        blurView = UIVisualEffectView(effect: blurEffect)
        blurView.alpha = 0.0
        blurView.frame = self.view.frame
        self.view.addSubview(blurView)
        dkTableView.backgroundColor = UIColor.clear
        starTableView.backgroundColor = UIColor.clear
        dkTableView.backgroundColor = UIColor.clear
        self.view.bringSubview(toFront: dkLabel)
        self.view.bringSubview(toFront: totalDkLabel)
        self.view.bringSubview(toFront: totalDkResult)
        self.view.bringSubview(toFront: dkTableView)
        self.view.bringSubview(toFront: starLabel)
        self.view.bringSubview(toFront: totalStarLabel)
        self.view.bringSubview(toFront: totalStarResult)
        self.view.bringSubview(toFront: starTableView)

        dkTableView.alpha = 0
        starTableView.alpha = 0
        dkLabel.alpha = 0
        starLabel.alpha = 0
        totalDkLabel.alpha = 0
        totalStarLabel.alpha = 0
        totalStarResult.alpha = 0
        totalDkResult.alpha = 0
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == dkTableView{
            return dkUsedNodes.count
        }
        else{
            return starUsedNodes.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell : UITableViewCell!
        var node : Node!
        if tableView == dkTableView {
            cell = dkTableView.dequeueReusableCell(withIdentifier: "cell")
            node = dkUsedNodes[indexPath.row]
            
            let startNode = self.buttonToNode[(startButton.titleLabel?.text)!]
            let roundedPriority = round(node.getPriority())
            cell?.textLabel?.text = "Node: \(node.getName()) - \(roundedPriority)"
            if node == startNode { // Special case for stater node, whose previous is nill.
                cell.detailTextLabel?.text = "previous: None"
            }
            else{
                cell.detailTextLabel?.text = "previous: \(dkPrev[node.getName()]!.getName())" // get previous node
            }
        }
        else{
            cell = starTableView.dequeueReusableCell(withIdentifier: "cell")
            node = starUsedNodes[indexPath.row]
            
            let startNode = self.buttonToNode[(startButton.titleLabel?.text)!]
            let roundedPriority = round(node.getPriority())
            cell?.textLabel?.text = "Node: \(node.getName()) - \(roundedPriority)"
            if node == startNode {
                cell.detailTextLabel?.text = "previous: None" // Special case for starter node, whose previous is nill.
            }
            else{
                cell.detailTextLabel?.text = "previous: \(starPrev[node.getName()]!.getName())" // get previous node
            }
        }
        cell?.textLabel?.textColor = UIColor.white
        cell?.backgroundColor = UIColor.clear
        cell?.textLabel?.textAlignment = .center
        return cell!
    }
}

extension CGPoint {
    
    func distance(toPoint p:CGPoint) -> CGFloat {
        return sqrt(pow(x - p.x, 2) + pow(y - p.y, 2))
    }
}
