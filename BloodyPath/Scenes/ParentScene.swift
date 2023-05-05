//
//  ParentScene.swift
//  BloodyPath
//
//  Created by Дмитрий on 05.05.2023.
//

import SpriteKit

class ParentScene: SKScene {

    let sceneManager = SceneManager.shared
    var backScene: SKScene?
    
    func setupBackgtound() {
        self.backgroundColor = SKColor(red: 0.15, green: 0.15, blue: 0.3, alpha: 1.0)
    }
    
    func setHeader(withName name: String?, andBackground backgroundName: String) {
        
        let header = ButtonNode(title: name, backgroundName: backgroundName)
        header.position = CGPoint(x: self.frame.midX,
                                  y: self.frame.midY + 150)
        self.addChild(header)
    }
    
    func setButtons(titles: [String]) {
        for (index, title) in titles.enumerated() {
            let button = ButtonNode(title: title,
                                    backgroundName: "button_background")
            button.position = CGPoint(x: self.frame.midX,
                                      y: self.frame.midY - CGFloat(100 * index))
            button.name = title
            button.label.name = title
            addChild(button)
        }
    }
}
