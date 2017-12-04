//
//  LeaderboardsViewController.swift
//  WikiHunt
//
//  Created by Peter Senyszyn on 1/6/17.
//  Copyright © 2017 Peter Senyszyn. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit

class LeaderboardsViewController: UIViewController
{
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        if let view = self.view as! SKView?
        {
            if let scene = SKScene(fileNamed: "LeaderboardsScene")
            {                
                // Set the scale mode to scale to fit the window
                scene.scaleMode = .aspectFill
                
                // Present the scene
                view.presentScene(scene)
            }
            
            view.ignoresSiblingOrder = true
            
            view.showsFPS = true
            view.showsNodeCount = true
        }
    }
    
    override var prefersStatusBarHidden: Bool
    {
        return true
    }
}
