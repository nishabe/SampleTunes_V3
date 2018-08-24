//
//  SearchViewController+TrackCellDelegate.swift
//  SampleTunes
//
//  Created by Abraham, Aneesh on 8/23/18.
//  Copyright © 2018 Ammini Inc. All rights reserved.
//

import Foundation

extension SearchViewController: TrackCellDelegate {
    
    func downloadTapped(_ cell: TrackCell) {
        if let indexPath = tableView.indexPath(for: cell) {
            let track = searchResults[indexPath.row]
            downloadService.startDownload(track)
            print("Remote url:\(track.previewURL)")
            reload(indexPath.row)
        }
    }
    
    func reload(_ row: Int) {
        tableView.reloadRows(at: [IndexPath(row: row, section: 0)], with: .none)
    }
}
