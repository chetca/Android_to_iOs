//
//  CurrentVideoLectionController.swift
//  memuDemo
//
//  Created by Dugar Badagarov on 29/08/2017.
//  Copyright © 2017 Parth Changela. All rights reserved.
//

import UIKit

class CurrentVideoController: UIViewController {        
    
    
    @IBOutlet var videoFrame: UIWebView!
    @IBOutlet var titleLbl: UILabel!
    @IBOutlet var descriptionLbl: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
                 
        titleLbl.text = StringLblText
        descriptionLbl.text = StringText                
            
        JSONTaker.shared.loadVideo(videoCode: StringVideoID, myWebView: videoFrame)
        
        if !videoFrame.isLoading {
            videoFrame.isHidden = false
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

//https://www.youtube.com/watch?v=RmHqOSrkZnk
