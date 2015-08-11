//
//  recordedAudio.swift
//  pitchperfect2
//
//  Created by Eleanor Stribling on 8/9/15.
//  Copyright (c) 2015 eleanorstrib. All rights reserved.
//

import Foundation

class RecordedAudio: NSObject {
    var filePathURL: NSURL!
    var fileName: String!
    
    init(filePathURL: NSURL, fileName: String) {
        self.filePathURL = filePathURL
        self.fileName = fileName
    }
}