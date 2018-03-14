//
//  MenuScene.swift
//  SKW
//
//  Copyright © 2018 Dario De Paolis. All rights reserved.
//

import SpriteKit

class MenuScene: SKScene {
    
//let sound = SKAudioNode(fileNamed: "menuAudio.mp3")
    

  override func didMove(to view: SKView) {

    debugPrint("view: \(view.frame)")
    backgroundColor = .white

    let background = SKSpriteNode(imageNamed: "backgroundMenuScene")
    background.position = CGPoint(x: size.width / 2, y: size.height / 1.5)
    background.zPosition = Z.background
    addChild(background)

    playBackgroundMusic(filename: "menuAudio.mp3")

    let gameLabel = SKLabelNode(fontNamed: "Courier")
    gameLabel.fontSize = 40
    gameLabel.fontColor = .red
    gameLabel.text = "UnNamed"
    gameLabel.position = CGPoint(x: size.width / 2, y: size.height / 1.2)
    addChild(gameLabel)

    let buttonStart = SKSpriteNode(imageNamed: "start")
    buttonStart.name = "buttonStart"
    buttonStart.position = CGPoint(x: size.width / 2, y: size.height / 2.8)
    buttonStart.size = SpriteSize.button
    buttonStart.zPosition = Z.HUD
    addChild(buttonStart)

  }


  func touchDown(atPoint pos: CGPoint) {
//    debugPrint("menu down: \(pos)")
    let touchedNode = self.atPoint(pos)
    if touchedNode.name == "buttonStart" {
      let button = touchedNode as! SKSpriteNode
      button.texture = SKTexture(imageNamed: "startPressed")
    }
  }

  func touchUp(atPoint pos: CGPoint) {
//    debugPrint("menu up: \(pos)")

    let touchedNode = self.atPoint(pos)

    if let button = childNode(withName: "buttonStart") as? SKSpriteNode {
      button.texture = SKTexture(imageNamed: "start")
    }

    if touchedNode.name == "buttonStart" {
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
