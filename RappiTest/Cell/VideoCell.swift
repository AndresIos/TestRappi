//
//  VideoCell.swift
//  RappiTest
//
//  Created by Andres Marin on 3/5/19.
//  Copyright © 2019 Andres Marin. All rights reserved.
//

import UIKit
import WebKit

class VideoCell: UICollectionViewCell {
    static let Identifier = "VideoCell"
    @IBOutlet weak var videoTypeLbl: UILabel!
    @IBOutlet weak var videoNameLbl: UILabel!
    @IBOutlet weak var videoWebView: WKWebView!
    
    func configureWithVideo(video:VideoResults)
    {
        self.videoNameLbl.text = video.name
        self.videoTypeLbl.text = video.type
        self.videoWebView.scrollView.isScrollEnabled = false
        if let url = URL(string: "\(youtubeUrl)\(video.key ?? "-")")
        {
            self.videoWebView.load(URLRequest(url: url))
        }
    }
}
