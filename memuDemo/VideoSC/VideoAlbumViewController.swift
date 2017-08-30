//
//  VideoAlbumViewController.swift
//  memuDemo
//
//  Created by Dugar Badagarov on 29/08/2017.
//  Copyright © 2017 Parth Changela. All rights reserved.
//

import UIKit

class VideoAlbumViewController: UITableViewController {
    
    
    @IBOutlet var btnMenuButton: UIBarButtonItem!

    var paramDict:[String:[String]] = Dictionary()
    var images = [UIImage]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        if revealViewController() != nil {                        
            
            btnMenuButton.target = revealViewController()                        
            btnMenuButton.action = #selector(SWRevealViewController.revealToggle(_:))
            
            
            paramDict = JSONTaker.shared.loadData(API: "videos", paramNames: ["title", "image", "video", "description"])         
            //print (paramDict)            
        }

    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (paramDict["title"]?.count)!
    }
    
    var dataString: [String] = []
    
    @objc(tableView:didSelectRowAtIndexPath:) override func tableView(_ tableView: UITableView,didSelectRowAt indexPath: IndexPath) {
        print("You selected name : "+(self.paramDict["title"]?[indexPath.row])!)
                
        StringLblText   = (self.paramDict["title"]?[indexPath.row])!         
        StringUrlImg    = (self.paramDict["image"]?[indexPath.row])!  
        StringVideoID   = (self.paramDict["video"]?[indexPath.row])!
        StringText      = (self.paramDict["description"]?[indexPath.row])!
        performSegue(withIdentifier: "segue", sender: self)                       
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: VideoAlbumCell = tableView.dequeueReusableCell(withIdentifier: "VideoAlbumCell", for: indexPath) as! VideoAlbumCell                        
        
        cell.titleLbl.text = self.paramDict["title"]?[indexPath.row]                              	            
        JSONTaker.shared.loadImg(imgURL: (self.paramDict["image"]?[indexPath.row])!, img: cell.img, spinner: cell.spinner)                                             
        
        //cell.shortText.sizeToFit()        
        
        return cell
    }        
}
