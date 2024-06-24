//
//  ScoreManager.swift
//  NC2_AvocadoTeam
//
//  Created by Alexia Merolla on 12/12/23.
//

import SpriteKit

class ScoreManager {

    var scoreLabel: SKLabelNode!
    var distanceTraveled: CGFloat = 0.0
    var score: Int = 0
    var flowerCount: Int = 0

    init(scene: SKScene) {
        setupScoreLabel(in: scene)
        loadHighScore()
    }

    func setupScoreLabel(in scene: SKScene) {
        scoreLabel = SKLabelNode(text: "Score: 0")
        scoreLabel.fontName = "Arial"
        scoreLabel.fontSize = 30
        scoreLabel.horizontalAlignmentMode = .left
        scoreLabel.position = CGPoint(x: 20, y: scene.size.height - 55)
                
        scene.addChild(scoreLabel)
    }

    func updateScore() {
        // Update the distance traveled based on the background movement speed
        // let backgroundMoveSpeed: CGFloat = 3.0
        // distanceTraveled += backgroundMoveSpeed

        // Update the score based on the distance (you can adjust the scoring logic as needed)
        // score = Int(distanceTraveled / 100) // Adjust the divisor to control scoring rate

        score += 1
        
        // Update the score label text
        scoreLabel.text = "Score: \(score + flowerCount)"
        
        // Check for new high score
        checkAndUpdateHighScore()
    }
    
    func addScore(points: Int) {
        // Add points to the score 
        flowerCount += points * 100 // Add 100 points for each flower

        // Update the score label
        scoreLabel.text = "Score: \(score + flowerCount)"
        
        // Check for new high score
        checkAndUpdateHighScore()
    }
    
    func resetScore() {
        score = 0
        flowerCount = 0
        updateScoreLabel()
    }
    
    private func updateScoreLabel() {
        scoreLabel.text = "Score: \(score + flowerCount)"
    }
    
    // UserDefaults Key
    private let highScoreKey = "HighScore"

    // Load high score from UserDefaults
    private func loadHighScore() {
        if let savedHighScore = UserDefaults.standard.value(forKey: highScoreKey) as? Int {
            score = savedHighScore
        }
    }

    // Check and update high score
    private func checkAndUpdateHighScore() {
        let currentTotalScore = score + flowerCount

        if currentTotalScore > UserDefaults.standard.integer(forKey: highScoreKey) {
            // Update high score in UserDefaults
            UserDefaults.standard.set(currentTotalScore, forKey: highScoreKey)
            UserDefaults.standard.synchronize()
        }
    }
}
