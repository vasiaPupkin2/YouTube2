//
//  HomeControllerCell.swift
//  YouTube
//
//  Created by leanid niadzelin on 02.05.17.
//  Copyright © 2017 Leanid Niadzelin. All rights reserved.
//

import UIKit

class HomeControllerCell: BaseCell, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    var videos: [Video]?
    let cellId = "CellId"
    
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.delegate = self
        cv.dataSource = self
        cv.backgroundColor = .white
        cv.translatesAutoresizingMaskIntoConstraints = false
        return cv
    }()
    
    
    override func setupViews() {
        super.setupViews()
        
        addSubview(collectionView)
        collectionView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        collectionView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        collectionView.heightAnchor.constraint(equalTo: heightAnchor).isActive = true
        collectionView.widthAnchor.constraint(equalTo: widthAnchor).isActive = true
        collectionView.register(HomeCell.self, forCellWithReuseIdentifier: cellId)
        fetchVideos()
        
        
    }
    
    func fetchVideos() {
        ApiService.sharedInstance.fetchCurrentVideos(url: "home.json", completion: { (videos: [Video]) in
            self.videos = videos
            self.collectionView.reloadData()
        })
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return videos?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! HomeCell
        cell.video = videos?[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height = (frame.width - 16 - 16) * 9 / 16
        return CGSize(width: frame.width, height: height + 106)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let videoLauncher = VideoLauncher()
        videoLauncher.showVideoPlayer()
    }
    
    
}
