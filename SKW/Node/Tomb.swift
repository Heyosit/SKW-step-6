//
//  Enemy.swift
//  SKW
//
//  Copyright © 2018 Dario De Paolis. All rights reserved.
//

import SpriteKit

class Tomb: SKSpriteNode {

  let textureIdle = SKTexture(imageNamed: "brick")


  init() {
    super.init(texture: textureIdle, color: .white, size: SpriteSize.tomb)
    self.name = "tomb"

    // Physics
//    self.physicsBody = SKPhysicsBody(rectangleOf: self.frame.size)
//    self.physicsBody!.isDynamic = false
//    self.physicsBody!.categoryBitMask = PhysicsMask.enemy
//    self.physicsBody!.contactTestBitMask = PhysicsMask.bullet
//    self.physicsBody!.collisionBitMask = 0
  }

  // Swift requires this initializer
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

}
