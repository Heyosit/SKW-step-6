//
//  Player.swift
//  4thNanoChallenge - TheOldLady
//
//  Created by Nicola Centonze on 08/03/2018.
//  Copyright © 2018 Nicola Centonze. All rights reserved.
//

import SpriteKit

class Player: SKSpriteNode {
    
    //    //Singleton
    //
    //    var gameManager = GameManager.shared
    
    // Textures
    var textureIdle: [SKTexture] = []
    var textureWalk: [SKTexture] = []
    
    // Manual Movement
    var destination = CGPoint()
    let velocity: CGFloat = 150
    var squarePlayerPosition = (0,0)
    var playerPositionAdapted =  CGPoint()
    let spacing = CGPoint(x: 5.0, y: 5)
    
    //States
    var attacking = false
    var isBouncing = false
    
    
    
    init() {
        
        
        self.textureIdle = GameManager.shared.allTextures.filter { $0.description.contains("idle") }
        self.textureWalk = GameManager.shared.allTextures.filter { $0.description.contains("walk") }
        
        
        
        
        debugPrint("texture: \(textureIdle[0])")
        super.init(texture: textureIdle[0], color: .clear, size: SpriteSize.player)
        self.xScale = fabs(self.xScale) * 0.1
        playerPositionAdapted = CGPoint(x: self.frame.width / 2, y: self.frame.height / 2)
        debugPrint("player pos: \(playerPositionAdapted)")
        
        playerPositionAdapted = plus(left: playerPositionAdapted, right: spacing)
        debugPrint("player pos: \(playerPositionAdapted)")
        self.name = "player"
        self.texture?.filteringMode = .nearest
        
    }
    
    func setup(view: SKView) {
        
        self.physicsBody = SKPhysicsBody(rectangleOf: self.size)
        //        self.physicsBody = SKPhysicsBody(texture: self.texture!, size: size.self)
        self.physicsBody?.mass = 4.0
        self.physicsBody?.isDynamic = true
        self.physicsBody?.affectedByGravity = false
        //        self.physicsBody?.categoryBitMask = PhysicsMask.player
        //        self.physicsBody?.contactTestBitMask = PhysicsMask.mushroom
        self.physicsBody?.collisionBitMask = 0
        self.physicsBody?.restitution = 0.4
        
        
        
        
        
        
        
        
        self.position = plus(left: GameManager.shared.gameMatrix[0][3], right: playerPositionAdapted)
        squarePlayerPosition = (0,3)
        destination = position
        
        self.animate(type: "idle")
    }
    
    func attack(){
        //        self.animate(type: "fire") aggiungere animazione attacco
        if !attacking{
            attacking = true
            let sickle = SKSpriteNode(color: SKColor.green, size: SpriteSize.sickle)
            sickle.name = "sickle"
            
            // Positioning
            sickle.position = CGPoint(x: position.x + (frame.size.width / 2), y: position.y)
            let sickleMovement = CGPoint(x: (position.x + (frame.size.width / 2)), y: position.y)
            let animEnd = SKAction.run {
                self.animate(type: "idle")
                self.attacking = false
            }
            // Animation
            
            let sickleAction = SKAction.sequence([
                //            SKAction.move(to: sickleMovement, duration: 0.4),
                SKAction.rotate(byAngle: -3, duration: 0.5),
                //            SKAction.move(to: sickleMovement, duration: 0.6),
                //            SKAction.wait(forDuration: 0.2),
                SKAction.removeFromParent(),
                animEnd
                ])
            sickle.run(sickleAction)
            
            //        self.run(SKAction.playSoundFileNamed("fire.m4a", waitForCompletion: false))
            
            // Add to Scene
            parent?.addChild(sickle)
        }
        
        
    }
    func moveRight(){
        if !attacking{
            if squarePlayerPosition.1 < GameManager.shared.maxColums - 1 - (squarePlayerPosition.0 )
            {
                debugPrint("squareplayer: \(squarePlayerPosition)")
                debugPrint("destination: \(GameManager.shared.gameMatrix[squarePlayerPosition.0 ][squarePlayerPosition.1 + 1])")
                setDestination(destination: GameManager.shared.gameMatrix[squarePlayerPosition.0 ][squarePlayerPosition.1 + 1])
                squarePlayerPosition.1 += 1
            }else {
//                isBouncing = true
//                debugPrint("squareplayer: \(squarePlayerPosition)")
//                debugPrint("will not move right")
//                let animStart = SKAction.run { self.animate(type: "walk") }
//                let jumpUpAction = SKAction.moveBy(x: (SpriteSize.player.width * 1.5), y: 0,  duration: 0.2)
//                //                let jumpDownAction = SKAction.moveBy(x: -(SpriteSize.player.width * 1.5), y: 0,  duration: 0.2)
//                let animEnd = SKAction.run {
//                    self.animate(type: "idle")
//                    self.isBouncing = false
//                }
//                let jumpSequence = SKAction.sequence([animStart, jumpUpAction, animEnd])
//                
//                self.run(jumpSequence)
            }
        }
        
        
    }
    func moveLeft(){
        if !attacking{
            if squarePlayerPosition.1 > (GameManager.shared.maxRows - squarePlayerPosition.0 - 1)
            {
                debugPrint("squareplayer: \(squarePlayerPosition)")
                debugPrint("destination: \(GameManager.shared.gameMatrix[squarePlayerPosition.0 ][squarePlayerPosition.1 - 1])")
                setDestination(destination: GameManager.shared.gameMatrix[squarePlayerPosition.0 ][squarePlayerPosition.1 - 1])
                squarePlayerPosition.1 -= 1
            }else {
                debugPrint("squareplayer: \(squarePlayerPosition)")
                debugPrint("will not move left")
            }
        }
    }
    
    func moveDown(){
        if !attacking{
            if squarePlayerPosition.0 > 0
            {
                debugPrint("squareplayer: \(squarePlayerPosition)")
                debugPrint("destination: \(GameManager.shared.gameMatrix[squarePlayerPosition.0 - 1 ][squarePlayerPosition.1 + 1])")
                setDestination(destination: GameManager.shared.gameMatrix[squarePlayerPosition.0 - 1][squarePlayerPosition.1 + 1])
                squarePlayerPosition.0 -= 1
                squarePlayerPosition.1 += 1
            }else {
                debugPrint("squareplayer: \(squarePlayerPosition)")
                debugPrint("will not move down")
            }
        }
        
    }
    func moveUp(){
        if !attacking{
            if squarePlayerPosition.0 < 3
            {
                debugPrint("squareplayer: \(squarePlayerPosition)")
                debugPrint("destination: \(GameManager.shared.gameMatrix[squarePlayerPosition.0 + 1 ][squarePlayerPosition.1 - 1])")
                setDestination(destination: GameManager.shared.gameMatrix[squarePlayerPosition.0 + 1][squarePlayerPosition.1 - 1])
                squarePlayerPosition.0 += 1
                squarePlayerPosition.1 -= 1
            }else {
                
                debugPrint("squareplayer: \(squarePlayerPosition)")
                debugPrint("will not move up")
            }
        }
    }
    
    
    
    func setDestination(destination: CGPoint) {
        self.destination = plus(left: destination, right: playerPositionAdapted)
        self.animate(type: "walk")
    }
    func stickMovement(deltaTime: TimeInterval) {
        // Calculate Distance
        let distance = CGPoint(x: fabs(destination.x - position.x), y: fabs(destination.y - position.y))
        //        debugPrint("distance: \(distance)")
        // Change Orientation
        let orientation: CGFloat = destination.x >= position.x ? 1.0 : -1.0
        self.xScale = fabs(self.xScale) * orientation
        let orientationY: CGFloat = destination.y >= position.y ? 1.0 : -1.0
        
        let deltaMove = velocity * CGFloat(deltaTime)
        if (distance.x > deltaMove || distance.y > deltaMove) {
            if(distance.x > deltaMove){
                //          position.x += (orientation * deltaMove) - position.y
                position.x += (orientation * deltaMove)
                //                debugPrint("pos \(position.x) dis \(distance)")
            }
            if(distance.y > deltaMove){
                position.y += orientationY * deltaMove
                //            position.x -= position.y
                
                //                debugPrint("pos \(position.y) dis \(distance)")
            }
            
            
        } else
            //            if distance.x < 0.4 && distance.y < 4.5
        {
            position.x = destination.x
            position.y = destination.y
            if orientation == -1.0 {
                self.xScale = fabs(self.xScale)
            }
            
            self.animate(type: "idle")
            //                  debugPrint("end dis \(distance)")
        }
    }
    
    func update(deltaTime: TimeInterval) {
        stickMovement(deltaTime: deltaTime)
        
    }
    
    
    //    let textureOfTheNode: SKTexture
    //
    //    init() {
    //        self.textureOfTheNode = #imageLiteral(resourceName: "theOldLadyProfile")
    //    }
    func animate(type: String) {
        var textureType: [SKTexture]
        switch type {
        case "idle":
            textureType = textureIdle
        case "walk":
            textureType = textureWalk
            //        case "jump":
            //            textureType = textureJump
            //        case "fire":
            //            textureType = textureFire
            //    case "beam":
        //      textureType = textureBeam
        default:
            textureType = textureIdle
        }
        let animation = SKAction.animate(with: textureType, timePerFrame: (1.0 / 15.0))
        self.run(SKAction.repeatForever(animation))
    }
    
    // Swift requires this initializer
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func plus(left: CGPoint, right: CGPoint) -> CGPoint{
        return CGPoint(x: left.x + right.x, y: left.y + right.y)
    }
    
}


