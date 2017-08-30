//
//  ViewController.swift
//  memuDemo
//
//  Created by Parth Changela on 09/10/16.
//  Copyright © 2016 Parth Changela. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    
    @IBOutlet weak var btnMenuButton: UIBarButtonItem!    
    @IBOutlet var tableView: UITableView!
        
    var paramDict:[String:[String]] = Dictionary()
    
    override func viewDidLoad() {
        super.viewDidLoad()                     
        
        // Do any additional setup after loading the view, typically from a nib.
        if revealViewController() != nil {                        
            
            btnMenuButton.target = revealViewController()                        
            btnMenuButton.action = #selector(SWRevealViewController.revealToggle(_:))
            
            
            paramDict = JSONTaker.shared.loadData(API: "news", paramNames: ["title","date", "short",  "image", "text"])        
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (paramDict["title"]?.count)!
    }
        
    var dataString: [String] = []
    
    @objc(tableView:didSelectRowAtIndexPath:) func tableView(_ tableView: UITableView,didSelectRowAt indexPath: IndexPath) {
        print("You selected name : "+(self.paramDict["date"]?[indexPath.row])!)
                
        
        StringLblText   = (self.paramDict["title"]?[indexPath.row])! 
        StringText = (self.paramDict["text"]?[indexPath.row])!
        StringDataField = (self.paramDict["date"]?[indexPath.row])!
        StringUrlImg    = (self.paramDict["image"]?[indexPath.row])!  
        print(paramDict.count, "in select")
        performSegue(withIdentifier: "segue", sender: self)                       
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: FeedsCell = tableView.dequeueReusableCell(withIdentifier: "FeedsCell", for: indexPath) as! FeedsCell                        
                                
        cell.dataTime.text = JSONTaker.shared.convertDate(date: (self.paramDict["date"]?[indexPath.row])!)
        cell.titleText.text = self.paramDict["title"]?[indexPath.row]
        cell.shortText.text = self.paramDict["short"]?[indexPath.row]                        	            
        JSONTaker.shared.loadImg(imgURL: (self.paramDict["image"]?[indexPath.row])!, img: cell.img, spinner: cell.spinner)                                             
        
        //cell.shortText.sizeToFit()        
        
        return cell
    }
}

//https://www.youtube.com/watch?v=K1qrk6XOuIU
