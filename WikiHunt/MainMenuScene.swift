//
//  MainMenuScene.swift
//  WikiHunt
//
//  Created by Peter Senyszyn on 1/5/17.
//  Copyright © 2017 Peter Senyszyn. All rights reserved.
//

import SpriteKit

class Word {
    let label = SKLabelNode(fontNamed: "Hoefler Text")
    
    init() {
        let screenSize = UIScreen.main.bounds
        
        label.color = UIColor.black
        label.fontSize = 50
        label.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.left
        label.verticalAlignmentMode = SKLabelVerticalAlignmentMode.top
        
        if let wordsFilePath = Bundle.main.path(forResource: "web2", ofType: nil) {
            if let wordsString = try? String(contentsOfFile: wordsFilePath) {
                let wordLines = wordsString.components(separatedBy: (NSCharacterSet.newlines))
                
                label.text = wordLines[Int(arc4random_uniform(UInt32(wordLines.count)))]
            }
        }
        
        label.position = CGPoint(x: -Int(arc4random_uniform(UInt32(label.frame.width))) - Int(label.frame.width), y: Int(arc4random_uniform(UInt32(screenSize.size.height))))
        
        let moveWords = SKAction.moveBy(x: screenSize.width - label.position.x, y: 0, duration: TimeInterval(Int(arc4random_uniform(5) + 5)))
        
        label.run(moveWords)
    }
    
    func reset() {
        let screenSize = UIScreen.main.bounds
        
        if let wordsFilePath = Bundle.main.path(forResource: "web2", ofType: nil),
            let wordsString = try? String(contentsOfFile: wordsFilePath) {
                let wordLines = wordsString.components(separatedBy: (NSCharacterSet.newlines))
                
                label.text = wordLines[Int(arc4random_uniform(UInt32(wordLines.count)))]
        }
        
        label.position = CGPoint(x: -Int(arc4random_uniform(UInt32(label.frame.width))) - Int(label.frame.width), y: Int(arc4random_uniform(UInt32(screenSize.size.height))))
        
        let moveWords = SKAction.moveBy(x: screenSize.width + -(label.position.x), y: 0, duration: TimeInterval(Int(arc4random_uniform(5) + 7)))
        
        label.run(moveWords)
    }
}

class MainMenuScene: SKScene {
    var wordLabels = [Word]() //Array of all of the moving random words
    let queue = DispatchQueue(label: "com.petersenyszyn.WikiHunt.queues.mainmenu", qos: DispatchQoS.userInteractive)
    
    override func didMove(to view: SKView) {
        for i in 0 ..< 10 {
            wordLabels.append(Word())
            
            addChild(wordLabels[i].label)
        }
    }
    
    override func update(_ currentTime: TimeInterval) {
        let screenSize = UIScreen.main.bounds
        
        for word in self.wordLabels {
            if round(word.label.position.x) >= screenSize.width {
                word.label.position = CGPoint(x: -500, y: 0)
                
                queue.async {
                    word.reset()
                }
            }
        }
    }
}
