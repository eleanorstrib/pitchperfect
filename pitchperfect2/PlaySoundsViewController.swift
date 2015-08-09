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
    
    //create URL for filepath
    var audioURL = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("movie_quote", ofType: "mp3")!)
    var audioPlayer = AVAudioPlayer()
    
    @IBOutlet weak var stopPlaybackButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        audioPlayer = AVAudioPlayer(contentsOfURL: audioURL, error: nil)
        audioPlayer.enableRate = true
        // Do any additional setup after loading the view.
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
