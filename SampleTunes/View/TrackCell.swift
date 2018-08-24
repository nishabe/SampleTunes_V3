//
//  TrackCell.swift
//  SampleTunes
//
//  Created by Abraham, Aneesh on 8/22/18.
//  Copyright © 2018 Ammini Inc. All rights reserved.
//

import UIKit

protocol TrackCellDelegate {
    func downloadTapped(_ cell: TrackCell)
}
class TrackCell: UITableViewCell {

    var delegate: TrackCellDelegate?
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var artistLabel: UILabel!
    @IBOutlet weak var progressView: UIProgressView!
    @IBOutlet weak var progressLabel: UILabel!
    @IBOutlet weak var pauseButton: UIButton!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var downloadButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    @IBAction func downloadTapped(_ sender: AnyObject) {
        delegate?.downloadTapped(self)
    }
    
    func configure(track: Track, downloaded: Bool) {
        titleLabel.text = track.name
        artistLabel.text = track.artist
        progressView.isHidden = true
        progressLabel.isHidden = true
        pauseButton.isHidden = true
        cancelButton.isHidden = true
        // If the track is already downloaded, enable cell selection and hide the Download button
        selectionStyle = downloaded ? UITableViewCellSelectionStyle.gray : UITableViewCellSelectionStyle.none
        if downloaded  {
            downloadButton.isHidden = true
        } else {
            downloadButton.isHidden = false
        }
    }
}
