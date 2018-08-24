//
//  SearchViewController+TableViewDelegate.swift
//  SampleTunes
//
//  Created by Abraham, Aneesh on 8/22/18.
//  Copyright © 2018 Ammini Inc. All rights reserved.
//

import Foundation
import UIKit
import AVKit

extension SearchViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchResults.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "trackCell_ID", for: indexPath) as! TrackCell
        let track = searchResults[indexPath.row]
        cell.delegate = self
        cell.configure(track: track,downloaded:track.downloaded)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let track = searchResults[indexPath.row]
        if track.downloaded {
            playDownload(track)
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    // MARK: Private methods
    func playDownload(_ track: Track) {
        let playerViewController = AVPlayerViewController()
        playerViewController.entersFullScreenWhenPlaybackBegins = true
        playerViewController.exitsFullScreenWhenPlaybackEnds = true
        present(playerViewController, animated: true, completion: nil)
        let url = localFilePath(for: track.previewURL)
        print("localPath:\(url)")
        let player = AVPlayer(url: url)
        playerViewController.player = player
        player.play()
    }
    
    func localFilePath(for url: URL) -> URL {
        let documentsPath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        return documentsPath.appendingPathComponent(url.lastPathComponent)
    }
}
