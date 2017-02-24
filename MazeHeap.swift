//
//  MazeHeap.swift
//  MazeRunner
//
//  Created by Ramon Goncalves da Silva on 2/19/17.
//  Copyright © 2017 ramon. All rights reserved.
//

import Foundation

class MazeHeap {
    
    private var arr = [Node]()
    
    private var indexDic = [String: Int]()

    func add(node: Node){
        arr.append(node)
        indexDic[node.getName()] = arr.count - 1
        heapifyUp(pos: arr.count - 1)
    }
    
    private func heapifyUp(pos: Int){
        if pos > 0 && arr[pos].getPriority() < arr[(pos-1)/2].getPriority() {
            swap(pos1: pos, pos2: (pos-1)/2)
            heapifyUp(pos: (pos-1)/2)
        }
    }
    
    func peek() -> Node {
        return arr[0];
    }
    
    func pop(){
        swap(pos1: 0, pos2: arr.count - 1)
        arr.remove(at: arr.count - 1)
        heapifyDown(pos: 0)
    }
    
    private func heapifyDown(pos: Int){
        
        let leftChildPos = 2*pos + 1
        let rightChildPos = 2*pos + 2
        var smallest = pos
        
        if leftChildPos < arr.count && arr[leftChildPos].getPriority() < arr[smallest].getPriority(){
            smallest = leftChildPos
        }
        if rightChildPos < arr.count && arr[rightChildPos].getPriority() < arr[smallest].getPriority(){
            smallest = rightChildPos
        }
        
        if smallest != pos {
            swap(pos1: smallest, pos2: pos)
            heapifyDown(pos: smallest)
        }
    }
    
    private func swap(pos1: Int, pos2: Int){
        indexDic[arr[pos1].getName()] = pos2
        indexDic[arr[pos2].getName()] = pos1
        
        var temp = arr[pos1]
        arr[pos1] = arr[pos2]
        arr[pos2] = temp
    }
    
    func update(node: Node){
        let index = indexDic[node.getName()]!
        arr[index].setPriority(f: node.getPriority())
        heapifyUp(pos: index)
    }
    
    
    func isEmpty() -> Bool{
        return arr.count == 0
    }
    
    func printHeap(){
        while !isEmpty() {
            let item : Node = peek()
            print(" \(item.getName()) - \(item.getCenter()) - \(item.getPriority())")
            pop()
        }
    }
    
}
