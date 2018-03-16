//
//  GameManager.swift
//  SKW
//
//  Copyright © 2018 Dario De Paolis. All rights reserved.
//

import SpriteKit

class GameManager {
    static let shared = GameManager()
    
    var score: Int = 0
    var appCounted: Bool = false
    var doctorIsIn = false
    var monstersKills: Int = 0
    var timerCounter: Int = 30
    
    var timer: Timer? {
        willSet {
            timer?.invalidate()
            timerCounter = 35
        }
    }
    
    var tombsPosIndex: [(i: Int, j: Int)] = [(0,0),
                         (0,0),
                         (0,0),
                         (0,0)]
    
    
    
    // Textures
    var allTextures: [SKTexture] = []
    //gameplane
    var gamePlane = CGPoint()
    var maxColums = 14
    var maxRows = 4
    var gameMatrix : [[CGPoint]] = [[CGPoint(),CGPoint(),CGPoint(),CGPoint(),CGPoint(),CGPoint(),CGPoint(),CGPoint(),CGPoint(),CGPoint(),CGPoint(),CGPoint(),CGPoint(),CGPoint()],
                                    [CGPoint(),CGPoint(),CGPoint(),CGPoint(),CGPoint(),CGPoint(),CGPoint(),CGPoint(),CGPoint(),CGPoint(),CGPoint(),CGPoint(),CGPoint(),CGPoint()],
                                    [CGPoint(),CGPoint(),CGPoint(),CGPoint(),CGPoint(),CGPoint(),CGPoint(),CGPoint(),CGPoint(),CGPoint(),CGPoint(),CGPoint(),CGPoint(),CGPoint()],
                                    [CGPoint(),CGPoint(),CGPoint(),CGPoint(),CGPoint(),CGPoint(),CGPoint(),CGPoint(),CGPoint(),CGPoint(),CGPoint(),CGPoint(),CGPoint(),CGPoint()]]
    
    
    
    func setup(view: SKView){
        gamePlane = CGPoint(x: view.frame.maxX, y: view.frame.midY)
        debugPrint("gameplane: \(gamePlane)")
        var matrixElement: CGPoint
        
        matrixElement = CGPoint(x:gamePlane.x / CGFloat(maxColums), y: gamePlane.y / CGFloat(maxRows))
        for i in 0...maxRows - 1{
            //            debugPrint("i: \(i)")
            for j in 0...maxColums - 1{
                //                debugPrint("j: \(j)")
                let newElement = CGPoint(x: matrixElement.x * CGFloat(j), y: matrixElement.y * CGFloat(i))
                //                debugPrint("new : \(newElement)")
                gameMatrix[i][j] = newElement
            }
        }
        
        for gameArray in gameMatrix{
            for element in gameArray{
                //                debugPrint("element: \(element)")
            }
        }
        
    }
    
    func restartAll(){
        tombsPosIndex = [(0,0),
        (0,0),
        (0,0),
        (0,0)]
        
        doctorIsIn = false
    }
    
    // Start Timer in Singleton thread
    func startTimer(label: SKLabelNode) {
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true, block: { t in
            self.timerCounter -= 1
            label.text = "Timer: \(self.timerCounter)"
        })
    }
    
    func loseTime(label: SKLabelNode) {
        timerCounter -= 2
            label.text = "Timer: \(self.timerCounter)"
    }
    
    func gainTime(label: SKLabelNode) {
        timerCounter += 3
        label.text = "Timer: \(self.timerCounter)"
    }
    
    
    
}

