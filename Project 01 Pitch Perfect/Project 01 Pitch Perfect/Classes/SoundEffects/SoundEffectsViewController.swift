//
//  SoundEffectsViewController.swift
//  Project 01 Pitch Perfect
//
//  Created by Brandan McDevitt on 26/03/2020.
//  Copyright © 2020 Brandan McDevitt. All rights reserved.
//

import UIKit
import AVFoundation

class SoundEffectsViewController: UIViewController {
    var recordedAudioURL: URL?
    var audioFile:AVAudioFile!
    var audioEngine:AVAudioEngine!
    var audioPlayerNode: AVAudioPlayerNode!
    var stopTimer: Timer!

    @IBOutlet weak var stopButton: UIButton!
    @IBOutlet weak var snailButton: UIButton!
    @IBOutlet weak var rabbitButton: UIButton!
    @IBOutlet weak var chipmunkButton: UIButton!
    @IBOutlet weak var vaderButton: UIButton!
    @IBOutlet weak var echoButton: UIButton!
    @IBOutlet weak var reverbButton: UIButton!
    enum ButtonType: Int {
        case slow = 0, fast, chipmunk, vader, echo, reverb
    }
    
    override func viewDidLoad() {
        configureUI(.notPlaying)
        setupAudio()
    }
    
    @IBAction func playEffect(_ sender: UIButton) {
        switch(ButtonType(rawValue: sender.tag)!) {
        case .slow:
            playSound(rate: 0.5)
        case .fast:
            playSound(rate: 1.5)
        case .chipmunk:
            playSound(pitch: 1000)
        case .vader:
            playSound(pitch: -1000)
        case .echo:
            playSound(echo: true)
        case .reverb:
            playSound(reverb: true)
        }

        configureUI(.playing)
    }
    @IBAction func stop(_ sender: UIButton) {
        stopAudio()
    }
}
