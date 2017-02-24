//
//  Line.swift
//  MazeRunner
//
//  Created by Ramon Goncalves da Silva on 2/18/17.
//  Copyright © 2017 ramon. All rights reserved.
//

import Foundation
import UIKit

class Line : UIView {
    
    private var node1 : Node!
    
    private var node2 : Node!

    private var color : UIColor!
    
    private var thickness: CGFloat!
    
    init(frame: CGRect, node1: Node, node2: Node, color: UIColor, thickness: CGFloat) {
        super.init(frame: frame)
        self.node1 = node1
        self.node2 = node2
        self.color = color
        self.thickness = thickness
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
    override func draw(_ rect: CGRect) {
        let context = UIGraphicsGetCurrentContext()
        context!.setLineWidth(thickness)
        context!.setStrokeColor(self.color.cgColor)
        context!.move(to: node1.getCenter())
        context?.addLine(to: node2.getCenter())
        context?.strokePath()
    }
}
