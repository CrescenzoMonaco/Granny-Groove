//
//  GameViewController.swift
//  NC2_AvocadoTeam
//
//  Created by Ricardo Jorge Rodriguez Trevino on 12/12/23.
//

import UIKit
import SpriteKit

class GameViewController: UIViewController {

    var gameScene: GameScene!

    override func viewDidLoad() {
        super.viewDidLoad()

        if let view = self.view as! SKView? {
            // Load the MainMenuScene initially
            let scene = MainMenuScene(size: view.bounds.size)
            scene.scaleMode = .aspectFill

            view.presentScene(scene)
            view.ignoresSiblingOrder = true
            view.showsFPS = true
            view.showsNodeCount = true
        }
    }
    
    func presentGameScene() {
        if let view = self.view as! SKView? {
            // Create and configure the GameScene
            gameScene = GameScene(size: view.bounds.size)
            gameScene.scaleMode = .aspectFill
            gameScene.gameViewController = self

            // Present the scene
            view.presentScene(gameScene)
        }
    }

    // Handle the transition from MainMenuScene to GameScene
    func transitionToGameScene() {
        presentGameScene()
    }
}

