//
//  VideoLauncher.swift
//  YouTube
//
//  Created by leanid niadzelin on 25.05.17.
//  Copyright © 2017 Leanid Niadzelin. All rights reserved.
//

import UIKit
import AVFoundation

class VideoPlayerView: UIView {
    
    let playPauseButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "pause"), for: .normal)
        button.tintColor = .white
        button.translatesAutoresizingMaskIntoConstraints = false
        button.isHidden = true
        button.addTarget(self, action: #selector(handlePause), for: .touchUpInside)
        return button
    }()
    
    var isPlaying = false
    
    func handlePause() {
        
        if isPlaying {
            player?.pause()
            playPauseButton.setImage(#imageLiteral(resourceName: "play"), for: .normal)
        } else {
            player?.play()
            playPauseButton.setImage(#imageLiteral(resourceName: "pause"), for: .normal)
        }
        
        isPlaying = !isPlaying
    }
    
    let activityIndicatorView: UIActivityIndicatorView = {
        let aiv = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)
        aiv.startAnimating()
        aiv.translatesAutoresizingMaskIntoConstraints = false
        return aiv
    }()
    
    let controlsContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(white: 0, alpha: 1)
        return view
    }()
    
    let currentTimeLabel: UILabel = {
        let label = UILabel()
        label.text = "00:00"
        label.font = UIFont.boldSystemFont(ofSize: 13)
        label.textColor = .white
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let videoLengthLabel: UILabel = {
        let label = UILabel()
        label.text = "00:00"
        label.font = UIFont.boldSystemFont(ofSize: 13)
        label.textAlignment = .right
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let videoSlider: UISlider = {
        let slider = UISlider()
        slider.minimumTrackTintColor = .red
        slider.maximumTrackTintColor = .white
        slider.setThumbImage(#imageLiteral(resourceName: "thumb"), for: .normal)
        slider.translatesAutoresizingMaskIntoConstraints = false
        
        slider.addTarget(self, action: #selector(handleSliderChanged), for: .valueChanged)
        return slider
    }()
    
    func handleSliderChanged() {
        
        if let duration = player?.currentItem?.duration {
            let totalSeconds = CMTimeGetSeconds(duration)
            
            let value = Float64(videoSlider.value) * totalSeconds
            
            
        
        
        let seekTime = CMTime(value: Int64(value), timescale: 1)
        
        player?.seek(to: seekTime, completionHandler: { (completedSeek) in
            
        })
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .black
        setupPlayerView()
        setupGradientLayer()
        
        controlsContainerView.frame = self.frame
        addSubview(controlsContainerView)
        controlsContainerView.addSubview(activityIndicatorView)
        activityIndicatorView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        activityIndicatorView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        
        
        controlsContainerView.addSubview(playPauseButton)
        playPauseButton.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        playPauseButton.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        playPauseButton.widthAnchor.constraint(equalToConstant: 50).isActive = true
        playPauseButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        controlsContainerView.addSubview(videoLengthLabel)
        videoLengthLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -8).isActive = true
        videoLengthLabel.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        videoLengthLabel.heightAnchor.constraint(equalToConstant: 24).isActive = true
        videoLengthLabel.widthAnchor.constraint(equalToConstant: 50).isActive = true
        
        controlsContainerView.addSubview(currentTimeLabel)
        currentTimeLabel.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        currentTimeLabel.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        currentTimeLabel.heightAnchor.constraint(equalToConstant: 24).isActive = true
        currentTimeLabel.widthAnchor.constraint(equalToConstant: 50).isActive = true
        
        
        controlsContainerView.addSubview(videoSlider)
        videoSlider.leftAnchor.constraint(equalTo: currentTimeLabel.rightAnchor).isActive = true
        videoSlider.rightAnchor.constraint(equalTo: videoLengthLabel.leftAnchor).isActive = true
        videoSlider.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        videoSlider.heightAnchor.constraint(equalToConstant: 24).isActive = true
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var player: AVPlayer?
    
    func setupPlayerView() {
        let string = URL(string: "https://firebasestorage.googleapis.com/v0/b/gameofchats-762ca.appspot.com/o/message_movies%2F12323439-9729-4941-BA07-2BAE970967C7.mov?alt=media&token=3e37a093-3bc8-410f-84d3-38332af9c726")
        
        if let urlString = string {
            
            player = AVPlayer(url: urlString)
            let playerLayer = AVPlayerLayer(player: player)
            self.layer.addSublayer(playerLayer)
            playerLayer.frame = self.frame
            
            player?.play()
            
            player?.addObserver(self, forKeyPath: "currentItem.loadedTimeRanges", options: .new, context: nil)
            
            let interval = CMTime(value: 1, timescale: 2)
            
            player?.addPeriodicTimeObserver(forInterval: interval, queue: DispatchQueue.main, using: { (progressTime) in
                
                let seconds = CMTimeGetSeconds(progressTime)
                let secondsString = String(format: "%02d", Int(seconds) % 60)
                let minuteString = String(format: "%02d", Int(seconds) / 60)
                self.currentTimeLabel.text = "\(minuteString):\(secondsString)"
                
                if let duration = self.player?.currentItem?.duration {
                    let durationSeconds = CMTimeGetSeconds(duration)
                    
                    self.videoSlider.value = Float(seconds / durationSeconds)
                }
                
            })
        }
    }
    
    private func setupGradientLayer() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = bounds
        gradientLayer.colors = [UIColor.clear.cgColor, UIColor.black.cgColor]
        gradientLayer.locations = [0.8, 1.2]
        
        controlsContainerView.layer.addSublayer(gradientLayer)
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "currentItem.loadedTimeRanges" {
            activityIndicatorView.stopAnimating()
            controlsContainerView.backgroundColor = .clear
            playPauseButton.isHidden = false
            isPlaying = true
            
            if let duration = player?.currentItem?.duration {
                let seconds = CMTimeGetSeconds(duration)
                
                let secondsText = Int(seconds) % 60
                let minutesText = String(format: "%02d", Int(seconds) / 60)
                videoLengthLabel.text  = "\(minutesText):\(secondsText)"
            }
        }
    }
}

class VideoLauncher: NSObject {
    func showVideoPlayer() {
        
        if let keyWindow = UIApplication.shared.keyWindow {
            let view = UIView()
            view.backgroundColor = .white
            view.frame = CGRect(x: keyWindow.frame.width - 10, y: keyWindow.frame.height - 10, width: 10, height: 10)
            
            let videoPlayerFrame = CGRect(x: 0, y: 0, width: keyWindow.frame.width, height: keyWindow.frame.width * 9 / 16)
            let videoPlayerView = VideoPlayerView(frame: videoPlayerFrame)
            view.addSubview(videoPlayerView)
            keyWindow.addSubview(view)
            
            UIView.animate(withDuration: 0.7, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                view.frame = keyWindow.frame
                UIApplication.shared.isStatusBarHidden = true
            }, completion: { (completedAnimation) in
            })
        }
        
        print("123")
    }
}
