//
//  RASHVideoView.swift
//  RASHvideoView
//
//  Created by Admin on 3/30/17.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import Foundation
import UIKit
import AVFoundation

public class RASHvideoView: UIView {
    
    
    var videoURL: URL?
    var videoPlayer: AVPlayer!
    var videoLayer: AVPlayerLayer!
    var videoItem: AVPlayerItem!
    
    var dimView: UIView!
    
    
    convenience init(url: URL) {
        self.init()
        if self != nil {
            
            self.videoURL = url
            self.videoPlayer = AVPlayer(url: videoURL!)
            self.videoLayer = AVPlayerLayer(player: videoPlayer!)
            
            
            self.alpha = 0.0
            
            //default backGround Color
            self.backgroundColor = .white
            
            //create Dim View
            self.dimView = UIView(frame: self.bounds)
            dimView.backgroundColor = UIColor.black.withAlphaComponent(0.4)
            
        }
        
        
    }
    
    
    required public init?(coder aDecoder: NSCoder) {
        //        fatalError("init(coder:) has not been implemented")
        super.init(coder: aDecoder)
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    
    func prepareVideoView() {
        
        videoItem = AVPlayerItem(url: videoURL!)
        videoPlayer.replaceCurrentItem(with: videoItem!)
        videoItem.addObserver(self,
                              forKeyPath: "status",
                              options: .new,
                              context: nil)
        
        videoPlayer.actionAtItemEnd = .pause
        
        
        addObserverForVideoStatus()
        
        
        //add to layer
        self.layer.insertSublayer(videoLayer, at: 0)
    }
    
    //MARK: - Layout subviews
    override public func layoutSubviews() {
        
        self.videoLayer.frame = self.bounds
        self.dimView.frame = self.bounds
    }
    
    //MARK: - Register For video change status
    func addObserverForVideoStatus() {
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(RASHvideoView.videoEnded),
                                               name: NSNotification.Name.AVPlayerItemDidPlayToEndTime,
                                               object: self.videoPlayer.currentItem
        )
    }
    
    
    //MARK: - Video Status Methods
    func videoEnded(notification: NSNotification) {
        
        let playerItemTMP = notification.object as! AVPlayerItem
        playerItemTMP.seek(to: kCMTimeZero)
        self.videoPlayer.play()
        
        
    }
    
    
    //MARK: - View Observer
    public override func observeValue(forKeyPath keyPath: String?,
                                      of object: Any?,
                                      change: [NSKeyValueChangeKey : Any]?,
                                      context: UnsafeMutableRawPointer?) {
        
        if object as! AVPlayerItem == self.videoPlayer.currentItem
        {
            
            if self.videoPlayer.currentItem?.status == AVPlayerItemStatus.readyToPlay
            {
                self.videoPlayer.play()
                UIView.animate(withDuration: 0.4,
                               animations: {
                                
                                
                                self.alpha = 1.0
                                
                    },
                               completion: { (finished: Bool) in
                                
                })
                
            }
            
            
        }
        
    }
    
    
    public func playVideo()
    {
        self.videoPlayer.play()
    }
    
    public func pauseVideo()
    {
        self.videoPlayer.pause()
        
        
        
        
    }
    
}
