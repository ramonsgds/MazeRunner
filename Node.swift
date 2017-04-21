//
//  Node.swift
//  MazeRunner
//
//  Created by Ramon Goncalves da Silva on 2/19/17.
//  Copyright © 2017 ramon. All rights reserved.
//

import Foundation
import UIKit

class Node : Equatable {
    private var name: String!
    private var location : CGPoint!
    private var f : Double!
    
    init(name: String, location: CGPoint, priority: Double) {
        self.name = name
        self.location = location
        self.f = priority
    }
    
    func setName(name:String){
        self.name = name
    }
    
    func getName() -> String{
        return self.name
    }
    
    func getCenter() -> CGPoint{
        return location
    }
    
    func getPriority() -> Double {
        return f;
    }
    
    func setPriority(f: Double){
        self.f = f
    }

}

func ==(lhs: Node, rhs: Node) -> Bool {
    return lhs.getName() == rhs.getName()
}
