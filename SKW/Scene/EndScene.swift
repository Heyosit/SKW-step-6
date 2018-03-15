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
    endSceneVictoryBackground.zPosition = -1
    
    let endSceneLoseBackground = SKSpriteNode(imageNamed: "endSceneLose")
    endSceneLoseBackground.position = CGPoint(x: size.width / 2, y: size.height / 2)
    endSceneLoseBackground.zPosition = -1
    
    if GameManager.shared.score <= 0 {
        addChild(endSceneLoseBackground)
    } else {
        addChild(endSceneVictoryBackground)
    }
    
    
    

    let wait = SKAction.wait(forDuration: 6.0)
    let block = SKAction.run {
      let scene = MenuScene(size: self.size)
      scene.scaleMode = .aspectFill
      let transitionType = SKTransition.flipHorizontal(withDuration: 0.5)
      self.view?.presentScene(scene, transition: transitionType)
    }
    self.run(SKAction.sequence([wait, block]))

  }

}


