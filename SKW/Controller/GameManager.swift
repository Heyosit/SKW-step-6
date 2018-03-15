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
    var tombsPosIndex: [(i: Int, j: Int)] = [(0,7),
                         (1,4),
                         (2,10),
                         (3,6)]
    
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
    
    
    
}

