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
        // Dispose of any resources that can be recreated.
    }
    
    func playerFunc(audioRate: Float, audioSpeed: String) {
        audioPlayer.stop()
        audioPlayer.rate = audioRate
        audioPlayer.play()
        stopPlaybackButton.hidden = false
        println("playing audio " + audioSpeed)
    }
    
    @IBAction func playSlow(sender: UIButton) {
        playerFunc(0.5, audioSpeed:"slow")
    }

    @IBAction func playFast(sender: UIButton) {
        playerFunc(1.5, audioSpeed: "fast")
    }
    
    @IBAction func playChipmunk(sender: UIButton) {
        playAudioWithVariablePitch(1500, effect: "chipmunk")
    }
    
    @IBAction func playVader(sender: UIButton) {
        playAudioWithVariablePitch(-1200, effect:"vader")
    }
    func playAudioWithVariablePitch(pitch: Float, effect: String){
        // stop all playback before applying effect
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
        
        println(effect, " playback")
    }
    
    @IBAction func stopPlayback(sender: UIButton) {
        audioPlayer.stop()
        println("stopping audio")
        stopPlaybackButton.hidden = true
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
