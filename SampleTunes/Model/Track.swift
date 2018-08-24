//
//  Track.swift
//  SampleTunes
//
//  Created by Abraham, Aneesh on 8/22/18.
//  Copyright © 2018 Ammini Inc. All rights reserved.
//

import Foundation

class Track {
    
    let name: String
    let artist: String
    let previewURL: URL
    let index: Int
    var downloaded = false
    
    init(name: String, artist: String, previewURL: URL, index: Int) {
        self.name = name
        self.artist = artist
        self.previewURL = previewURL
        self.index = index
    }
    
}
