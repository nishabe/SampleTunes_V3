//
//  DownloadService.swift
//  SampleTunes
//
//  Created by Abraham, Aneesh on 8/23/18.
//  Copyright © 2018 Ammini Inc. All rights reserved.
//

import Foundation

class DownloadService {
    
    var activeDownloads: [URL: Download] = [:]
    var downloadsSession = URLSession(configuration: URLSessionConfiguration.default, delegate: nil, delegateQueue: nil)
    func startDownload(_ track: Track) {
        let download = Download(track: track)
        download.task = downloadsSession.downloadTask(with: track.previewURL)
        download.task!.resume()
        download.isDownloading = true
        activeDownloads[download.track.previewURL] = download
    }
}
