//
//  FeedCell.swift
//  YouTube
//
//  Created by leanid niadzelin on 04.05.17.
//  Copyright © 2017 Leanid Niadzelin. All rights reserved.
//

import UIKit

class TrendingCell: HomeControllerCell {
    override func fetchVideos() {
        ApiService.sharedInstance.fetchCurrentVideos(url: "trending.json", completion: { (videos: [Video]) in
            self.videos = videos
            self.collectionView.reloadData()
        })
    }

}
