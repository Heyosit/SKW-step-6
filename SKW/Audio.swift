//
//  Audio.swift
//  4thNanoChallenge - TheOldLady
//
//  Created by Nicola Centonze on 12/03/2018.
//  Copyright © 2018 Nicola Centonze. All rights reserved.
//

import Foundation
import AVFoundation
import SpriteKit

var backgroundMusicPlayer: AVAudioPlayer!

let alarm = SKAudioNode(fileNamed: "scene1Audio.mp3")


func playBackgroundMusic(filename: String) {
    let resourceUrl = Bundle.main.url(forResource:
        filename, withExtension: nil)
    guard let url = resourceUrl else {
        print("Could not find file: \(filename)")
        return
    }
    do {
        try backgroundMusicPlayer =       AVAudioPlayer(contentsOf: url)
        backgroundMusicPlayer.numberOfLoops = -1
        backgroundMusicPlayer.prepareToPlay()
        backgroundMusicPlayer.play()
    } catch {
        print("Could not create audio player!")
        return
    } }

var player: AVAudioPlayer?

func playSound(fileName: String) {
    guard let url = Bundle.main.url(forResource: fileName, withExtension: nil) else { return }
    
    do {
        try AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayback)
        try AVAudioSession.sharedInstance().setActive(true)
        
        player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.mp3.rawValue)
        
        guard let player = player else { return }
        
        player.play()
        
    } catch let error {
        print(error.localizedDescription)
    }
}



