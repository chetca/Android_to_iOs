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

            paramDict = JSONTaker.shared.loadData(API: "videos", paramNames: ["title", "date", "text"])         
            //print (paramDict)            
        }
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (paramDict["title"]?.count)!
    }    
    
    @objc(tableView:didSelectRowAtIndexPath:) override func tableView(_ tableView: UITableView,didSelectRowAt indexPath: IndexPath) {
        //print("You selected name : "+(self.paramDict["title"]?[indexPath.row])!)
                
        StringLblText   = (self.paramDict["title"]?[indexPath.row])!           
        StringVideoID   = JSONTaker.shared.fromHTMLToAdequate(HTML: (paramDict["text"]?[indexPath.row])!)
        performSegue(withIdentifier: "segue", sender: self)                       
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: VideoAlbumCell = tableView.dequeueReusableCell(withIdentifier: "VideoAlbumCell", for: indexPath) as! VideoAlbumCell                        
        
        cell.titleLbl.text = self.paramDict["title"]?[indexPath.row]                              	                                                         
        let adequateVideoURL = JSONTaker.shared.fromHTMLToAdequate(HTML: (paramDict["text"]?[indexPath.row])!)        
        JSONTaker.shared.loadImg(imgURL: "https://img.youtube.com/vi/\(adequateVideoURL)/hqdefault.jpg", img: [cell.img], spinner: cell.spinner)
        //cell.shortText.sizeToFit()        
        
        return cell
    }        
}
