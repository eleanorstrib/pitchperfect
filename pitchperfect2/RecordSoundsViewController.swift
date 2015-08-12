//
//  RecordSoundsViewController.swift
//  pitchperfect2
//
//  Created by Eleanor Stribling on 8/5/15.
//  Copyright (c) 2015 eleanorstrib. All rights reserved.
//

import UIKit
import AVFoundation

class RecordSoundsViewController: UIViewController, AVAudioRecorderDelegate {
    @IBOutlet weak var recordButton: UIButton!
    @IBOutlet weak var recordingInProgress: UILabel!
    @IBOutlet weak var stopRecord: UIButton!
    @IBOutlet weak var recordInstruction: UILabel!
    
    var audioRecorder:AVAudioRecorder!
    var recordedAudio:RecordedAudio!

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(animated: Bool) {
        recordButton.enabled = true
        stopRecord.hidden = true
        recordInstruction.hidden = false
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func recordAudio(sender: UIButton) {
        // show text saying recording in progress and stop button and
        // disable the mic button as soon as it is tapped
        recordInstruction.hidden = true
        recordingInProgress.hidden = false
        stopRecord.hidden = false
        recordButton.enabled = false
        // record user's voice
        // create a variable that points to a string for the documents directory for this app
        let dirPath = NSSearchPathForDirectoriesInDomains(.DocumentDirectory,
            .UserDomainMask, true)[0] as! String
        
        // create recording as a wav file, overwrite each time
        let recordingName = "user_recording.wav"
        //create an array to store filename and path
        let pathArray = [dirPath, recordingName]
        //convert array into URL, print to verify
        let filePath = NSURL.fileURLWithPathComponents(pathArray)
        
        // create audio session
        var session = AVAudioSession.sharedInstance()
        session.setCategory(AVAudioSessionCategoryPlayAndRecord, error: nil)
        // init recorder
        audioRecorder = AVAudioRecorder(URL: filePath, settings: nil, error: nil)
        
        audioRecorder.delegate = self
        audioRecorder.meteringEnabled = true
        audioRecorder.prepareToRecord()
        audioRecorder.record()
    }
    
    func audioRecorderDidFinishRecording(recorder: AVAudioRecorder!, successfully flag: Bool) {
        println("here")
        if(flag){
            // save recorded audio
            recordedAudio = RecordedAudio(filePathURL:recorder.url, fileTitle: "user_recording.wav", fileName: recorder.url.lastPathComponent!)
            println("recording successful")
            // make segue
            self.performSegueWithIdentifier("nextScreen", sender:recordedAudio)
        }else {
            println("recording failed!")
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if(segue.identifier == "nextScreen") {
            let playSoundsVC = segue.destinationViewController as! PlaySoundsViewController
            let data = sender as! RecordedAudio
            playSoundsVC.receivedAudio = data
        }
    }

    @IBAction func stopButtonPressed(sender: UIButton) {
        audioRecorder.stop()
        var audioSession = AVAudioSession.sharedInstance()
        audioSession.setActive(false, error: nil)
        recordingInProgress.hidden = true
        stopRecord.hidden = true
        recordButton.enabled = false
    }
    
}

