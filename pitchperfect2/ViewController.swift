//
//  ViewController.swift
//  pitchperfect2
//
//  Created by Eleanor Stribling on 8/5/15.
//  Copyright (c) 2015 eleanorstrib. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var recordButton: UIButton!
    @IBOutlet weak var recordingInProgress: UILabel!
    @IBOutlet weak var stopRecord: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(animated: Bool) {
        recordButton.enabled = true
        stopRecord.hidden = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func recordAudio(sender: UIButton) {
        //TODO: show text saying recording in progress
        recordingInProgress.hidden = false
        stopRecord.hidden = false
        //TODO: Record user's voice
        println("in record audio")
    }

    @IBAction func stopButtonPressed(sender: UIButton) {
        recordingInProgress.hidden = true
        stopRecord.hidden = true
        recordButton.enabled = false
    }
    
}

