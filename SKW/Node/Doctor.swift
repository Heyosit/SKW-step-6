//
//  Doctor.swift
//  SKW
//
//  Created by Alessio Perrotti on 15/03/2018.
//  Copyright © 2018 Dario De Paolis. All rights reserved.
//

import Foundation
import SpriteKit

class Doctor: SKSpriteNode {
    
//    let textureIdle = SKTexture(imageNamed: "brick")
    var textureWalk: [SKTexture] = []
    var doctorPositionAdapted =  CGPoint()
    let spacing = CGPoint(x: 5.0, y: 5)
    
    init() {
        
        self.textureWalk = GameManager.shared.allTextures.filter { $0.description.contains("doctor-walk") }
        super.init(texture: textureWalk[0], color: .white, size: SpriteSize.doctor)
        self.name = "doctor"
        doctorPositionAdapted = CGPoint(x: self.frame.width / 2, y: self.frame.height / 2)
//        debugPrint("player pos: \(playerPositionAdapted)")
        self.zPosition = 50
        doctorPositionAdapted = plus(left: doctorPositionAdapted, right: spacing)
        
        // Physics
        //    self.physicsBody = SKPhysicsBody(rectangleOf: self.frame.size)
        //    self.physicsBody!.isDynamic = false
        //    self.physicsBody!.categoryBitMask = PhysicsMask.enemy
        //    self.physicsBody!.contactTestBitMask = PhysicsMask.bullet
        //    self.physicsBody!.collisionBitMask = 0
    }
    
    func setup(view: SKView){
        let randI = Int(arc4random_uniform(4))
        let yPos = GameManager.shared.gameMatrix[randI][0].y
        
        self.zPosition = CGFloat(randI)
        self.position = CGPoint (x: view.frame.maxX + self.size.width, y: yPos )
        self.position = plus(left: self.position, right: doctorPositionAdapted)
        moveDoctor()
        
        
        
    }
    
    func moveDoctor(){
        debugPrint("doctor zPosition is: \(self.zPosition) ")
        let walkAnim = SKAction.run {
            self.animate(type: "walk")
            self.xScale = fabs(self.xScale) * -1.0
        }
        let endAnim = SKAction.run {
            GameManager.shared.doctorIsIn = false
        }
        let doctorAction = SKAction.sequence([
            walkAnim,
            SKAction.moveTo(x: 0 - self.size.width, duration: 6),
            SKAction.removeFromParent(),
            endAnim
            ])
        self.run(doctorAction)
        
        
        
    }
    
    func doctorHitPlayer(){
        let animStart = SKAction.run {
//            self.removeAllActions()
            SKAction.fadeOut(withDuration: 1.5)
        }
       
        let animEnd = SKAction.run {
            
            self.removeFromParent()
            SKAction.wait(forDuration: 0.2)
            GameManager.shared.doctorIsIn = false
        }
        let doctorLeave = SKAction.sequence([
                animStart,
                animEnd])
        
        self.run(doctorLeave)
        
    }
    
//    func spawnMushroom() {
//        
//        // Invalidate Collision
//        //     self.physicsBody!.contactTestBitMask = 0
//        
//        // Flipcoin
//        //    let mushroomType = arc4random_uniform(2) == 1 ? (type: "good", color: SKColor.green) : (type: "bad", color: SKColor.red)
//        let mushroomType = arc4random_uniform(2) == 1 ? (type: "good", texture: textureMushroomGood) : (type: "bad", texture: textureMushroomBad)
//        
//        // Create Mushrrom
//        //    let mushroom = SKSpriteNode(color: mushroomType.color, size: SpriteSize.mushroom)
//        let mushroom = SKSpriteNode(texture: mushroomType.texture, color: .clear, size: SpriteSize.mushroom)
//        mushroom.name = "mushroom-\(mushroomType.type)"
//        
//        // Physics
//        mushroom.physicsBody = SKPhysicsBody(rectangleOf: mushroom.frame.size)
//        mushroom.physicsBody!.isDynamic = true
//        mushroom.physicsBody!.affectedByGravity = true
//        mushroom.physicsBody!.categoryBitMask = PhysicsMask.mushroom
//        mushroom.physicsBody!.contactTestBitMask = PhysicsMask.player
//        mushroom.physicsBody!.collisionBitMask = PhysicsMask.player
//        
//        // Positioning
//        mushroom.position = CGPoint(x: self.position.x, y: self.position.y)
//        
//        parent?.addChild(mushroom)
//        
//        // Enemy explode
//        let enemyAction = SKAction.sequence([
//            SKAction.playSoundFileNamed("brick.m4a", waitForCompletion: false),
//            SKAction.scale(by: 2.0, duration: 0.2),
//            SKAction.wait(forDuration: 0.2),
//            SKAction.removeFromParent()
//            ])
//        self.run(enemyAction)
//        
//    }
    
    // Swift requires this initializer
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func animate(type: String) {
        var textureType: [SKTexture]
        let animation: SKAction
        switch type {
//        case "idle":
//            textureType = textureIdle
//            animation = SKAction.animate(with: textureType, timePerFrame: (1.0 / 3.0))
        case "walk":
            textureType = textureWalk
            animation = SKAction.animate(with: textureType, timePerFrame: (1.0 / 12.0))
//        case "attack":
//            textureType = textureAttack
//            animation = SKAction.animate(with: textureType, timePerFrame: (1.0 / 12.0))
//            //        case "fire":
//            //            textureType = textureFire
            //    case "beam":
        //      textureType = textureBeam
        default:
            textureType = textureWalk
            animation = SKAction.animate(with: textureType, timePerFrame: (1.0 / 3.0))
        }
        
        
        
        self.run(SKAction.repeatForever(animation))
    }
    
}
