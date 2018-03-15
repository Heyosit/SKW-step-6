//
//  Constants.swift
//  4thNanoChallenge - TheOldLady
//
//  Created by Alessio Perrotti on 13/03/2018.
//  Copyright © 2018 Nicola Centonze. All rights reserved.
//

import SpriteKit

enum PhysicsMask {
    static let player: UInt32 = 0x1 << 1 //2
    static let bullet: UInt32 = 0x1 << 2 // 4
    static let enemy: UInt32 = 0x1 << 3 //8
    static let mushroom: UInt32 = 0x1 << 4 //16
    static let world: UInt32 = 0x1 << 5 // 32
    
}

enum Z {
    static let background: CGFloat = -1.0
    static let sprites: CGFloat = 10.0
    static let HUD: CGFloat = 100.0
}

enum SpriteSize {
    static let player = CGSize(width: 1000, height: 150)
    static let tomb = CGSize(width: 50, height: 50)
    static let doctor = CGSize(width: 80, height: 100)
    static let sickle = CGSize(width: 20, height: 30)
    static let bullet = CGSize(width: 10, height: 10)
    static let mushroom = CGSize(width: 20, height: 20)
    static let button = CGSize(width: 200, height: 175)
}

enum Scores {
    static let bonus = 10
    static let malus = -10
}


