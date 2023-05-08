//
//  GameSettings.swift
//  BloodyPath
//
//  Created by Дмитрий on 08.05.2023.
//

import UIKit

class GameSettings: NSObject {
    
    let userDefaults = UserDefaults.standard
    
    var highScores: [Int] = []
    var currentScore = 0
    let highScoresKey = "highScore"
    
    override init() {
        super.init()
        
        loadScores()
    }
    
    func saveScores() {
        highScores.append(currentScore)
        highScores = Array(highScores.sorted { $0 > $1 }.prefix(5))
        
        userDefaults.set(highScores, forKey: highScoresKey)
        userDefaults.synchronize()
    }
    
    func loadScores() {
        guard userDefaults.value(forKey: highScoresKey) != nil else { return }
        highScores = userDefaults.array(forKey: highScoresKey) as! [Int]
    }
}
