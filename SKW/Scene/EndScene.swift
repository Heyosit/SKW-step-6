//
//  EndScene.swift
//  SKW
//
//  Copyright © 2018 Dario De Paolis. All rights reserved.
//

import SpriteKit

class EndScene: SKScene {

  override func didMove(to view: SKView) {

    backgroundColor = .black

    let endSceneVictoryBackground = SKSpriteNode(imageNamed: "endSceneVictory")
    endSceneVictoryBackground.position = CGPoint(x: size.width / 2, y: size.height / 2)
    endSceneVictoryBackground.zPosition = Z.background
    endSceneVictoryBackground.scale(to: view.frame.size)
    
    let endSceneLoseBackground = SKSpriteNode(imageNamed: "endSceneLose")
    endSceneLoseBackground.position = CGPoint(x: size.width / 2, y: size.height / 2)
    endSceneLoseBackground.zPosition = Z.background
    endSceneLoseBackground.scale(to: view.frame.size)
    
    if GameManager.shared.score <= 0 {
        addChild(endSceneLoseBackground)
        playBackgroundMusic(filename: "loseMusic.mp3")
    } else {
        addChild(endSceneVictoryBackground)
        playBackgroundMusic(filename: "winMusic.mp3")
    }
    
    let continueButton = SKSpriteNode(imageNamed: "continueButton")
    continueButton.name = "continueButton"
    continueButton.position = CGPoint(x: view.frame.midX , y: size.height - 80)
    continueButton.size = CGSize(width: 200, height: 100)
    continueButton.zPosition = Z.HUD
    addChild(continueButton)
    

//    let wait = SKAction.wait(forDuration: 6.0)
//    let block = SKAction.run {
//      let scene = MenuScene(size: self.size)
//      scene.scaleMode = .aspectFill
//      let transitionType = SKTransition.flipHorizontal(withDuration: 0.5)
//
//      self.view?.presentScene(scene, transition: transitionType)
//    }
//    self.run(SKAction.sequence([wait, block]))
//    //restart the var in singleton for a new game
    GameManager.shared.restartAll()

  }
    
    func touchDown(atPoint pos: CGPoint) {
        //    debugPrint("menu down: \(pos)")
        let touchedNode = self.atPoint(pos)
        if touchedNode.name == "continueButton" {
            let button = touchedNode as! SKSpriteNode
            button.texture = SKTexture(imageNamed: "continueButtonPressed")
        }
    }
    
    func touchUp(atPoint pos: CGPoint) {

        let touchedNode = self.atPoint(pos)
        
        if let button = childNode(withName: "continueButton") as? SKSpriteNode {
            button.texture = SKTexture(imageNamed: "continueButton")
        }
        
        if touchedNode.name == "continueButton" {
            self.run(SKAction.playSoundFileNamed("startScream.mp3", waitForCompletion: false))
            
            backgroundMusicPlayer.setVolume(0, fadeDuration: 5)
            
            let scene = GameScene(size: size)
            scene.scaleMode = scaleMode
            let transitionType = SKTransition.doorsOpenHorizontal(withDuration: 5)
            view?.presentScene(scene, transition: transitionType)
        }
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        self.touchDown(atPoint: touch.location(in: self))
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        self.touchUp(atPoint: touch.location(in: self))
    }

}


