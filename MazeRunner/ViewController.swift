//
//  ViewController.swift
//  MazeRunner
//
//  Created by Ramon Goncalves da Silva on 2/18/17.
//  Copyright © 2017 ramon. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBAction func generateMap(_ sender: Any) {
        
    }
    @IBOutlet var mapButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewDidLayoutSubviews() {
        mapButton.layer.cornerRadius = 10
        mapButton.backgroundColor = UIColor.white
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

