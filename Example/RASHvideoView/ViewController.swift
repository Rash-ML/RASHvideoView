//
//  ViewController.swift
//  RASHvideoView
//
//  Created by rash1ironpunch@Gmail.com on 03/30/2017.
//  Copyright (c) 2017 rash1ironpunch@Gmail.com. All rights reserved.
//

import UIKit
import RASHvideoView

class ViewController: UIViewController {


    
    var videoView: RASHvideoView?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
        
        let videoUrl = URL(string: "http://dev2.yoozlabs.com:2020/api/files/videos/download/fit.mp4")
        let videoView = RASHvideoView.init(url: videoUrl!)
        
        self.view.addSubview(videoView)
        videoView.frame = self.view.frame
        
    }
    
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        videoView?.frame = self.view.frame
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

