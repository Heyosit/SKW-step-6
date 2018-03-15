//
//  HUD.swift
//  SKW
//
//  Copyright © 2018 Dario De Paolis. All rights reserved.
//

import SpriteKit

class HUD: SKNode {

  let scoreLabel = SKLabelNode(fontNamed:"Bradley Hand")
  let timerLabel = SKLabelNode(fontNamed:"Bradley Hand")
    
  var score: Int {
    get {
      return GameManager.shared.score
    }
    set {
      GameManager.shared.score += newValue
        if (GameManager.shared.score < 0)
        {
            GameManager.shared.score = 0
        }
      scoreLabel.text = "Score: \(GameManager.shared.score)"
    }
  }
  
  override init() {
    super.init()
    
    self.name = "HUD"
    

    scoreLabel.text = "Score: 0"
    scoreLabel.fontSize = 20
    scoreLabel.zPosition = Z.HUD
    

    timerLabel.text = "Timer: 30"
    timerLabel.fontSize = 20
    timerLabel.zPosition = Z.HUD
    
  }

  func setup(size: CGSize) {
    let spacing: CGFloat = 10
    scoreLabel.horizontalAlignmentMode = .left
    scoreLabel.position = CGPoint(x: spacing + 100, y: size.height - scoreLabel.frame.height - spacing)
    addChild(scoreLabel)

    timerLabel.horizontalAlignmentMode = .right
    timerLabel.position = CGPoint(x: size.width - 100, y: size.height - timerLabel.frame.height - spacing)
    addChild(timerLabel)

  }

  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

}
