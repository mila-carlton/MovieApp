//
//  YoutubeCell.swift
//  MovieApp
//
//  Created by PASGON TEXTILE on 27.02.24.
//

import UIKit
import YouTubeiOSPlayerHelper

class YoutubeCell: UICollectionViewCell {
    
    @IBOutlet weak var youtubePlayerView: YTPlayerView!
    
    func configure(video: VideoResult) {
        
        youtubePlayerView.load(withVideoId: video.key ?? "")
        youtubePlayerView.playVideo()
    }
    
}
