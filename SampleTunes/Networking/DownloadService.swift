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
    
    func pauseDownload(_ track: Track) {
        guard let download = activeDownloads[track.previewURL] else { return }
        if download.isDownloading {
            download.task?.cancel(byProducingResumeData: { data in
                download.resumeData = data
            })
            download.isDownloading = false
            print("Paused")
        }
    }
    
    func cancelDownload(_ track: Track) {
        if let download = activeDownloads[track.previewURL] {
            download.task?.cancel()
            activeDownloads[track.previewURL] = nil
            print("Cancelled")
        }
    }
    
    func resumeDownload(_ track: Track) {
        guard let download = activeDownloads[track.previewURL] else { return }
        if let resumeData = download.resumeData {
            download.task = downloadsSession.downloadTask(withResumeData: resumeData)
        } else {
            download.task = downloadsSession.downloadTask(with: download.track.previewURL)
        }
        print("Resumed")
        download.task!.resume()
        download.isDownloading = true
    }

}
