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
    var textureAttack: [SKTexture] = []
    
    // Manual Movement
    var destination = CGPoint()
    let velocity: CGFloat = 150
    var squarePlayerPosition = (0,0) //where the player is in the matrix
    var playerPositionAdapted =  CGPoint()
    let spacing = CGPoint(x: 5.0, y: 5)
    var lastDistance = CGPoint(x: 0, y: 0) //controls if the player moved since last frame
    
    //States
    var attacking = false
    var isBouncing = false
    var isIdle = false
    var firstTime = false
    
    
    
    init() {
        
        
        self.textureIdle = GameManager.shared.allTextures.filter { $0.description.contains("player-idle") }
        self.textureWalk = GameManager.shared.allTextures.filter { $0.description.contains("player-walk") }
        self.textureAttack = GameManager.shared.allTextures.filter { $0.description.contains("player-attack") }
        
        
        
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
        
        //        self.physicsBody = SKPhysicsBody(rectangleOf: self.size)
        //        //        self.physicsBody = SKPhysicsBody(texture: self.texture!, size: size.self)
        //        self.physicsBody?.mass = 4.0
        //        self.physicsBody?.isDynamic = true
        //        self.physicsBody?.affectedByGravity = false
        //        //        self.physicsBody?.categoryBitMask = PhysicsMask.player
        //        //        self.physicsBody?.contactTestBitMask = PhysicsMask.mushroom
        //        self.physicsBody?.collisionBitMask = 0
        //        self.physicsBody?.restitution = 0.4
        
        //set position
        self.position = plus(left: GameManager.shared.gameMatrix[0][3], right: playerPositionAdapted)
        squarePlayerPosition = (0,3)
        self.zPosition = CGFloat(GameManager.shared.maxRows - squarePlayerPosition.0)
        destination = position
        
        self.animate(type: "idle")
    }
    
    func playerBeHit(){
        let animStart = SKAction.run {
//            self.removeAllActions()
            SKAction.fadeOut(withDuration: 1)
            SKAction.fadeIn(withDuration: 1)
        }
        let animEnd = SKAction.run {
            self.animate(type: "idle")
        }
        let playerHitAnim = SKAction.sequence([
            SKAction.repeat(animStart, count: 5),
            animStart,
            animEnd])
        
        self.run(playerHitAnim)
    }
    
    func attack(){
        
        // controls if the player is already attackin
        if !attacking{
            self.animate(type: "attack")
            attacking = true
            //            let sickle = SKSpriteNode(color: SKColor.green, size: SpriteSize.sickle)
            //            sickle.name = "sickle"
            
            // Positioning
            //            sickle.position = CGPoint(x: position.x + (frame.size.width / 2), y: position.y)
            //            let sickleMovement = CGPoint(x: (position.x + (frame.size.width / 2)), y: position.y)
            
            //            let animScale = SKAction.run {
            //                SKAction.scaleX(to: self.xScale * 2, duration: 0)
            ////                SKAction.scaleX(to: self.xScale * 2, y: self.yScale, duration: 0)
            //            }
            
            //saves the position of the player
            let oldPosition = self.position
            
            //set the scale for attacking animation
            let animScaleX = SKAction.scaleX(to: self.xScale * 2, duration: 0)
            let animScaleY = SKAction.scaleY(to: self.yScale * 0.8, duration: 0)
            let animPos = SKAction.run {
                self.position.x += GameManager.shared.gameMatrix[0][1].x
                self.position.y -= 15
            }
            
            
            let animStarts = SKAction.animate(with: textureAttack, timePerFrame: 1 / 5, resize: false, restore: true)
            
            //return for idle animation
            let animRevX = SKAction.scaleX(to: self.xScale, duration: 0)
            let animRevY = SKAction.scaleY(to: self.yScale, duration: 0)
            let animEnd = SKAction.run {
                self.position = oldPosition
                self.animate(type: "idle")
                self.attacking = false
            }
            // Animation
            
            let attackAction = SKAction.sequence([
                animPos,
                animScaleX,
                animScaleY,
//                animStarts,
                SKAction.wait(forDuration: 0.5),
                animRevX,
                animRevY,
                animEnd
                ])
            self.run(attackAction)
            //            sickle.run(sickleAction)
            
            //        self.run(SKAction.playSoundFileNamed("fire.m4a", waitForCompletion: false))
            
            // Add to Scene
            //            parent?.addChild(sickle)
        }
        
        
    }
    
    func canMoveOnPosition(iPlayerPos: Int, jPlayerPos: Int) -> Bool{
        
        //check if the player is not going on a tomb
        for i in 0...3{
//            debugPrint("player pos i: \(iPlayerPos), j: \(jPlayerPos)")
//            debugPrint("pos enemy i: \(GameManager.shared.tombsPosIndex[i].i), j: \(GameManager.shared.tombsPosIndex[i].j)")
            if (GameManager.shared.tombsPosIndex[i].i == iPlayerPos && GameManager.shared.tombsPosIndex[i].j == jPlayerPos){
                return false
            }
        }
        return true
    }
    
    func moveRight(){
        if !attacking{
            if canMoveOnPosition(iPlayerPos: squarePlayerPosition.0, jPlayerPos: squarePlayerPosition.1 + 2){
                
                
                if squarePlayerPosition.1 < GameManager.shared.maxColums - 1 - (squarePlayerPosition.0 )
                {
                    
                    debugPrint("squareplayer: \(squarePlayerPosition)")
                    debugPrint("destination: \(GameManager.shared.gameMatrix[squarePlayerPosition.0 ][squarePlayerPosition.1 + 1])")
                    setDestination(destination: GameManager.shared.gameMatrix[squarePlayerPosition.0 ][squarePlayerPosition.1 + 1])
                    squarePlayerPosition.1 += 1
                    self.zPosition = CGFloat(GameManager.shared.maxRows - squarePlayerPosition.0)
                    debugPrint("player zposition: \(self.zPosition)")
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
        
        
    }
    func moveLeft(){
        if !attacking{
            if canMoveOnPosition(iPlayerPos: squarePlayerPosition.0, jPlayerPos: squarePlayerPosition.1 ){
                if squarePlayerPosition.1 > (GameManager.shared.maxRows - squarePlayerPosition.0 - 1)
                {
                    debugPrint("squareplayer: \(squarePlayerPosition)")
                    debugPrint("destination: \(GameManager.shared.gameMatrix[squarePlayerPosition.0 ][squarePlayerPosition.1 - 1])")
                    //                let orientation: CGFloat =  -1.0
                    //                self.xScale = fabs(self.xScale) * orientation
                    //
                    //                // Interpolation
                    //                let animWalk = SKAction.run { self.animate(type: "walk") }
                    //                let move = SKAction.moveTo(x: GameManager.shared.gameMatrix[squarePlayerPosition.0 ][squarePlayerPosition.1 - 1].x, duration: 0.3)
                    //                move.timingMode = .easeOut
                    //                let animIdle = SKAction.run { self.animate(type: "idle") }
                    //                let animation = SKAction.sequence([animWalk, move, animIdle])
                    //                self.run(animation)
                    setDestination(destination: GameManager.shared.gameMatrix[squarePlayerPosition.0 ][squarePlayerPosition.1 - 1])
                    squarePlayerPosition.1 -= 1
                    self.zPosition = CGFloat(GameManager.shared.maxRows - squarePlayerPosition.0)
                }else {
                    debugPrint("squareplayer: \(squarePlayerPosition)")
                    debugPrint("will not move left")
                }
            }
        }
    }
    
    func moveDown(){
        if !attacking{
            if canMoveOnPosition(iPlayerPos: squarePlayerPosition.0 - 1, jPlayerPos: squarePlayerPosition.1 + 2){
                if squarePlayerPosition.0 > 0
                {
                    debugPrint("squareplayer: \(squarePlayerPosition)")
                    debugPrint("destination: \(GameManager.shared.gameMatrix[squarePlayerPosition.0 - 1 ][squarePlayerPosition.1 + 1])")
                    //                let orientation: CGFloat =  -1.0
                    //                self.xScale = fabs(self.xScale) * orientation
                    //
                    //                // Interpolation
                    //                let animWalk = SKAction.run { self.animate(type: "walk") }
                    //                let move = SKAction.moveTo(x: GameManager.shared.gameMatrix[squarePlayerPosition.0 ][squarePlayerPosition.1 - 1].x, duration: 0.3)
                    //                move.timingMode = .easeOut
                    //                let animIdle = SKAction.run { self.animate(type: "idle") }
                    //                let animation = SKAction.sequence([animWalk, move, animIdle])
                    //                self.run(animation)
                    setDestination(destination: GameManager.shared.gameMatrix[squarePlayerPosition.0 - 1][squarePlayerPosition.1 + 1])
                    squarePlayerPosition.0 -= 1
                    squarePlayerPosition.1 += 1
                    self.zPosition = CGFloat(GameManager.shared.maxRows - squarePlayerPosition.0)
                }else {
                    debugPrint("squareplayer: \(squarePlayerPosition)")
                    debugPrint("will not move down")
                }
            }
        }
        
    }
    func moveUp(){
        if !attacking{
            if canMoveOnPosition(iPlayerPos: squarePlayerPosition.0 + 1, jPlayerPos: squarePlayerPosition.1){
                if squarePlayerPosition.0 < 3
                {
                    debugPrint("squareplayer: \(squarePlayerPosition)")
                    debugPrint("destination: \(GameManager.shared.gameMatrix[squarePlayerPosition.0 + 1 ][squarePlayerPosition.1 - 1])")
                    setDestination(destination: GameManager.shared.gameMatrix[squarePlayerPosition.0 + 1][squarePlayerPosition.1 - 1])
                    squarePlayerPosition.0 += 1
                    squarePlayerPosition.1 -= 1
                    self.zPosition = CGFloat(GameManager.shared.maxRows - squarePlayerPosition.0)
                }else {
                    
                    debugPrint("squareplayer: \(squarePlayerPosition)")
                    debugPrint("will not move up")
                }
            }
        }
    }
    
    
    func setDestination(destination: CGPoint) {
        self.destination = plus(left: destination, right: playerPositionAdapted)
            self.animate(type: "walk")
        firstTime = true
        
    }
    func stickMovement(deltaTime: TimeInterval) {
        //if the player is attacking doesn't have to do this
        if !attacking{
            
            //enters inside only the first time that he stops moving
            if !isIdle{
                self.animate(type: "idle")
                self.xScale = fabs(self.xScale)
                isIdle = true
//                self.playerBeHit()
            }
            // Calculate Distance
            let distance = CGPoint(x: fabs(destination.x - position.x), y: fabs(destination.y - position.y))
            //            debugPrint("distance: \(distance)")
            //check if the player moved in the last frame
            if distance.x == lastDistance.x{
                if firstTime{
                    firstTime = false
                    isIdle = false
                }
                
            }else{
                
                lastDistance = distance
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
                    //                isIdle = false
                    
                    //                    debugPrint("end dis \(distance)")
                }
            }
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
        let animation: SKAction
        switch type {
        case "idle":
            textureType = textureIdle
            animation = SKAction.animate(with: textureType, timePerFrame: (1.0 / 3.0))
        case "walk":
            textureType = textureWalk
            animation = SKAction.animate(with: textureType, timePerFrame: (1.0 / 12.0))
        case "attack":
            textureType = textureAttack
            animation = SKAction.animate(with: textureType, timePerFrame: (1.0 / 10.0))
            //        case "fire":
            //            textureType = textureFire
            //    case "beam":
        //      textureType = textureBeam
        default:
            textureType = textureIdle
            animation = SKAction.animate(with: textureType, timePerFrame: (1.0 / 3.0))
        }
        
        
        
        self.run(SKAction.repeatForever(animation))
    }
    
    // Swift requires this initializer
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}


