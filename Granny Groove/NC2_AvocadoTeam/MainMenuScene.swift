//
//  MenuView.swift
//  NC2_AvocadoTeam
//
//  Created by Isabella Di Lorenzi on 15/12/23.
//

import SpriteKit
import AVFAudio

class MainMenuScene: SKScene {
    
    var backgroundMusic: SKAudioNode!
    var animationGhost1: SKSpriteNode!
    var animationGhost2: SKSpriteNode!
    
    override func didMove(to view: SKView) {
        addBackground()
        createMainMenu()
    }

    
    // Background
    func addBackground() {
        // Add your background image or color here
        let background = SKSpriteNode(imageNamed: "mainmenubackground")
        
        // Set the size of the background to match the scene
        background.size = size
        background.position = CGPoint(x: size.width / 2, y: size.height / 2)
        background.zPosition = -1  // Place it at the bottom-most layer
        
        addChild(background)
    }
    
    func gameTitle(title: String, scaleRatio: CGFloat) {
        let topImage = SKSpriteNode(imageNamed: title)
        topImage.position = CGPoint(x: size.width / 2, y: size.height - topImage.size.height / 2 - 40)
        
        // Apply scaling action
        let scaleAction = SKAction.scale(to: scaleRatio, duration: 0.0)
        topImage.run(scaleAction)
        
        addChild(topImage)
    }
    
    func createGhostAnimation1(nodeName: String, imageName: String, verticalOffset: CGFloat, xPosition: CGFloat, yPosition: CGFloat) {
        let node1 = SKSpriteNode(imageNamed: imageName)
        node1.position = CGPoint(x: size.width / 2 + xPosition, y: size.height / 2 + yPosition)
        addChild(node1)
        
        let node2 = SKSpriteNode(imageNamed: imageName)
        node2.position = CGPoint(x: size.width / 2 + xPosition, y: size.height / 2 + yPosition)
        addChild(node2)
        
        // Define the movement actions
        let moveUp = SKAction.move(by: CGVector(dx: 0, dy: verticalOffset), duration: 1.5)
        let moveDown = SKAction.move(by: CGVector(dx: 0, dy: -verticalOffset), duration: 1.5)
        
        // Randomly decide the order of movements
        let shouldMoveUpFirst = Bool.random()
        let actions = shouldMoveUpFirst ? [moveUp, moveDown] : [moveDown, moveUp]
        
        // Create a sequence of actions
        let sequence = SKAction.sequence(actions)
        
        // Repeat the sequence forever
        let repeatAction = SKAction.repeatForever(sequence)
        
        // Run the action on both nodes
        node1.run(repeatAction)
        node2.run(repeatAction, withKey: "offset")
    }
    
    func createGhostAnimation2(nodeName: String, imageName: String, verticalOffset: CGFloat, xPosition: CGFloat, yPosition: CGFloat) {
        let node1 = SKSpriteNode(imageNamed: imageName)
        node1.position = CGPoint(x: size.width / 2 + xPosition, y: size.height / 2 + yPosition)
        addChild(node1)
        
        let node2 = SKSpriteNode(imageNamed: imageName)
        node2.position = CGPoint(x: size.width / 2 + xPosition, y: size.height / 2 + yPosition)
        addChild(node2)
        
        // Define the movement actions
        let moveUp = SKAction.move(by: CGVector(dx: 0, dy: verticalOffset), duration: 1.5)
        let moveDown = SKAction.move(by: CGVector(dx: 0, dy: -verticalOffset), duration: 1.5)
        
        // Randomly decide the order of movements
        let shouldMoveUpFirst = Bool.random()
        let actions = shouldMoveUpFirst ? [moveDown, moveUp] : [moveUp, moveDown]
        
        // Create a sequence of actions
        let sequence = SKAction.sequence(actions)
        
        // Repeat the sequence forever
        let repeatAction = SKAction.repeatForever(sequence)
        
        // Run the action on both nodes
        node1.run(repeatAction)
        node2.run(repeatAction, withKey: "offset")
    }
    
    func playButton(title: String, scaleRatio: CGFloat, xPosition: CGFloat, yPosition: CGFloat) {
        let playButton = SKSpriteNode(imageNamed: title)
        playButton.position = CGPoint(x: size.width + xPosition, y: playButton.frame.size.height + yPosition)
        playButton.name = "playButton"
        playButton.setScale(scaleRatio)
        addChild(playButton)
    }
    
    func bestScore(title: String, scaleRatio: CGFloat, xPosition: CGFloat, yPosition: CGFloat) {
        let scoreImage = SKSpriteNode(imageNamed: title)
        scoreImage.position = CGPoint(x: size.width / 2 + xPosition, y: scoreImage.frame.size.height / 2 + yPosition)
        
        // Apply scaling action
        let scaleAction = SKAction.scale(to: scaleRatio, duration: 0.0)
        scoreImage.run(scaleAction)
        
        addChild(scoreImage)
        
        // Get the best score from UserDefaults
        let bestScore = UserDefaults.standard.integer(forKey: "HighScore")
        
        // Create a label to display the best score
        let bestScoreLabel = SKLabelNode(fontNamed: "Arial")
        bestScoreLabel.fontSize = 20
        bestScoreLabel.text = "\(bestScore)"
        bestScoreLabel.position = CGPoint(x: scoreImage.position.x + scoreImage.size.width / 6, y: scoreImage.position.y - 10)
        bestScoreLabel.horizontalAlignmentMode = .left
        
        addChild(bestScoreLabel)
    }

    
    func backgroundMus(song: String, ext: String) {
        if let musicURL = Bundle.main.url(forResource: song, withExtension: ext) {
            backgroundMusic = SKAudioNode(url: musicURL)
            addChild(backgroundMusic)
        }
    }
    
    func createMainMenu() {
        // Create the game title on the top of the screen
        gameTitle(title: "namegame1", scaleRatio: 0.8)
        
        // Create and add an animation in the middle
        /*createGhostAnimation1(nodeName: "animationGhost1", imageName: "ghost1", verticalOffset: -15, xPosition: -80, yPosition: -35)*/
        
        createGhostAnimation1(nodeName: "animationGhost1", imageName: "ghostFlower", verticalOffset: -15, xPosition: -80, yPosition: -35)
        
        createGhostAnimation2(nodeName: "animationGhost2", imageName: "ghostLove", verticalOffset: -15, xPosition: 80, yPosition: -30)
        
        // Create a Play button at the bottom right
        playButton(title: "play", scaleRatio: 0.3, xPosition: -120, yPosition: -32)
        
        // Create the score image at the bottom left
        bestScore(title: "bestscore", scaleRatio: 0.3, xPosition: -280, yPosition: 15)
        
        // Add background music
        backgroundMus(song: "initialmenu", ext: "mp3")
    
        // Configure audio session
        do {
            try AVAudioSession.sharedInstance().setCategory(.ambient, mode: .default, options: [])
            try AVAudioSession.sharedInstance().setActive(true)
        } catch {
            print("Error configuring audio session: \(error.localizedDescription)")
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)
            let touchedNode = atPoint(location)
            
            if touchedNode.name == "playButton" {
                let scaleUpAction = SKAction.scale(to: 0.3, duration: 0.1)
                touchedNode.run(scaleUpAction)
            }
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)
            let touchedNode = atPoint(location)
            
            if touchedNode.name == "playButton" {
                // Scale up the play button when touch ends
                let scaleDownAction = SKAction.scale(to: 0.4, duration: 0.1)
                touchedNode.run(scaleDownAction)
                
                // Transition to the GameScene when the Play button is tapped
                let gameScene = GameScene(size: size)
                gameScene.scaleMode = scaleMode
                view?.presentScene(gameScene)
            }
        }
    }
}

