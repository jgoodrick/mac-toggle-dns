//
//  NSView+Beep.swift
//  ToggleDNS
//
//  Created by Joseph Goodrick on 4/10/18.
//  Copyright © 2018 G.O.O.D. Corp. All rights reserved.
//

import AVKit

extension NSView{
    func beep(with soundFileName: String){
        do {
            let audioPlayer =  try AVAudioPlayer(contentsOf: NSURL(fileURLWithPath: Bundle.main.path(forResource: soundFileName, ofType: "mp3")!) as URL)
            audioPlayer.prepareToPlay()
            audioPlayer.play()
        } catch {
            print("Error playing vibrate sound..")
        }
    }
}
