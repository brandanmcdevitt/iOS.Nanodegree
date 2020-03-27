//
//  RecordViewController.swift
//  Project 01 Pitch Perfect
//
//  Created by Brandan McDevitt on 26/03/2020.
//  Copyright © 2020 Brandan McDevitt. All rights reserved.
//

import UIKit
import AVFoundation

class RecordViewController: UIViewController {
    @IBOutlet weak var recordButton: UIButton!
    @IBOutlet weak var stopButton: UIButton!
    @IBOutlet weak var recordingLabel: UILabel!
    
    var audioRecorder: AVAudioRecorder?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        stopButton.isEnabled = false
        recordingLabel.alpha = 0
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showEffects" {
            let destinationVC = segue.destination as! SoundEffectsViewController
            let recordedAudioURL = sender as! URL
            destinationVC.recordedAudioURL = recordedAudioURL
        }
    }

    @IBAction func record(_: UIButton) {
        self.recordButton.isEnabled = false
        self.stopButton.isEnabled = true
        UIView.animate(withDuration: 0.5) {
            self.recordingLabel.alpha = 1
        }
        
        let dirPath = NSSearchPathForDirectoriesInDomains(.documentDirectory,.userDomainMask, true)[0] as String
        let recordingName = "recordedVoice.wav"
        let pathArray = [dirPath, recordingName]
        let filePath = URL(string: pathArray.joined(separator: "/"))

        let session = AVAudioSession.sharedInstance()
        try! session.setCategory(AVAudioSession.Category.playAndRecord, mode: AVAudioSession.Mode.default, options: AVAudioSession.CategoryOptions.defaultToSpeaker)

        try! audioRecorder = AVAudioRecorder(url: filePath!, settings: [:])
        audioRecorder?.delegate = self
        audioRecorder?.isMeteringEnabled = true
        audioRecorder?.prepareToRecord()
        audioRecorder?.record()
    }
    
    @IBAction func stop(_: UIButton) {
        self.recordButton.isEnabled = true
        self.stopButton.isEnabled = false
        UIView.animate(withDuration: 0.2) {
            self.recordingLabel.alpha = 0
        }
        audioRecorder?.stop()
        let audioSession = AVAudioSession.sharedInstance()
        try! audioSession.setActive(false)
    }
}

extension RecordViewController: AVAudioRecorderDelegate {
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        performSegue(withIdentifier: "showEffects", sender: audioRecorder?.url)
    }
}

