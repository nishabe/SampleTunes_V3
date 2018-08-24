//
//  Download.swift
//  SampleTunes
//
//  Created by Abraham, Aneesh on 8/23/18.
//  Copyright © 2018 Ammini Inc. All rights reserved.
//

import Foundation

class Download {
    var track: Track
    init(track: Track) {
        self.track = track
    }
    var task: URLSessionDownloadTask? // Download service sets these values
    var isDownloading = false
}
