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
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showEffects" {
            let destinationVC = segue.destination as! SoundEffectsViewController
            let recordedAudioURL = sender as! URL
            destinationVC.recordedAudioURL = recordedAudioURL
        }
    }

    @IBAction func record(_: UIButton) {
        configureUI(recording: true)
        
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
        configureUI(recording: false)
        audioRecorder?.stop()
        let audioSession = AVAudioSession.sharedInstance()
        try! audioSession.setActive(false)
    }
    
    func configureUI(recording: Bool) {
        // when you set recording as true, this will assign the first value to true and the second to false (i.e. !true or not true)
        stopButton.isEnabled = recording
        recordButton.isEnabled = !recording
        // here, you're changing the the label text based on the value of the recording parameter, if it's true, the first string is applied otherwise, the second string is applied.
        recordingLabel.text = recording ? "Recording in Progress..." : "Tap to Record"
    }
}

extension RecordViewController: AVAudioRecorderDelegate {
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        performSegue(withIdentifier: "showEffects", sender: audioRecorder?.url)
    }
}

