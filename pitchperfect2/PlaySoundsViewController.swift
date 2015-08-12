//
//  PlaySoundsViewController.swift
//  pitchperfect2
//
//  Created by Eleanor Stribling on 8/8/15.
//  Copyright (c) 2015 eleanorstrib. All rights reserved.
//

import UIKit
import AVFoundation

class PlaySoundsViewController: UIViewController {
    
    // create global object variable to invoke AVAudioPlayer
    var audioPlayer:AVAudioPlayer!
    // created global object variable for the user recording
    var receivedAudio:RecordedAudio!
    // create global object variable for the audio engine (effect playback)
    var audioEngine:AVAudioEngine!
    // create global object variable for AVAudioFile (needed to run effect playback)
    var audioFile:AVAudioFile!

    @IBOutlet weak var stopPlaybackButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        // load audio player as instance of AVAudio player and point to the user recording
        audioPlayer = AVAudioPlayer(contentsOfURL: receivedAudio.filePathURL, error: nil)
        // enables rate to manipulate for fast and slow playback
        audioPlayer.enableRate = true
        // load audioEngine as an instance of AVAudioEngine
        audioEngine = AVAudioEngine()
        // load audioFile as an instance of AVAudioFile, pass in user recording
        audioFile = AVAudioFile(forReading: receivedAudio.filePathURL, error: nil)
    }
    
    override func viewWillAppear(animated: Bool) {
        stopPlaybackButton.hidden = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // this section controls the player for the rate effects
    // (snail and rabbit in UI)
    func playAudioWithVariableRate(audioRate: Float) {
        // stop the audio and change the rate
        audioEngine.stop()
        audioEngine.reset()
        audioPlayer.rate = audioRate
        // play the sound
        audioPlayer.play()
        //show stop button as soon as sound begins to play
        stopPlaybackButton.hidden = false
    }
    
    @IBAction func playSlow(sender: UIButton) {
        playAudioWithVariableRate(0.5)
    }

    @IBAction func playFast(sender: UIButton) {
        playAudioWithVariableRate(1.5)
    }
    
    // this section controls the player for the pitch effects
    // (chipmunk and Darth Vader in UI)
    
    func playAudioWithVariablePitch(pitch: Float){
        // stop all playback before applying effect
        // audioPlayer command needed here to stop rate and pitch 
        // effects from running over each other
        audioPlayer.stop()
        audioEngine.stop()
        audioEngine.reset()
        
        // attach player node to audioEngine
        var audioPlayerNode = AVAudioPlayerNode()
        audioEngine.attachNode(audioPlayerNode)
        
        // instantiate pitch effect and attach to audioEngine
        var changePitchEffect = AVAudioUnitTimePitch()
        changePitchEffect.pitch = pitch
        audioEngine.attachNode(changePitchEffect)
        
        // connect audio player node to pitch effect in engine
        audioEngine.connect(audioPlayerNode, to: changePitchEffect, format:nil)
        // connect pitch effect to the device output
        audioEngine.connect(changePitchEffect, to: audioEngine.outputNode, format:nil)
        // this step required use of AVAudioFile class, see above
        audioPlayerNode.scheduleFile(audioFile, atTime: nil, completionHandler: nil)
        //play the file
        audioEngine.startAndReturnError(nil)
        audioPlayerNode.play()
        
        //show stop button
        stopPlaybackButton.hidden = false
    }
    
    @IBAction func playChipmunk(sender: UIButton) {
        playAudioWithVariablePitch(1500)
    }
    
    @IBAction func playVader(sender: UIButton) {
        playAudioWithVariablePitch(-1200)
    }

    
    @IBAction func stopPlayback(sender: UIButton) {
        //stopping audioEngine, hiding button
        audioEngine.stop()
        audioEngine.reset()
        stopPlaybackButton.hidden = true
    }

}
