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
    
    /* говнокод
    var day: [String] = []
    var shortText: [String] = []        
    var imgURL: [String] = []
   // var image : UIImageView
    var titleText: [String] = []
    var text: [String] = []
     */
    
   // var json:[String: AnyObject] = [:]    
  //  let dateString = "2015-10-22 07:45"
    var paramDict:[String:[String]] = Dictionary()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()     

        // Do any additional setup after loading the view, typically from a nib.
        if revealViewController() != nil {                        
            
            btnMenuButton.target = revealViewController()
            
            //news/zurhay[1',1..19]
            
            btnMenuButton.action = #selector(SWRevealViewController.revealToggle(_:))
            
            
            paramDict = JSONTaker.shared.loadData(baseURL: "file:///Users/dugar/Downloads/feed.json", paramNames: ["title","date", "short",  "image", "text"])
            //loadAstrologicalData(baseURL: "file:///Users/dugar/Downloads/feed.json")
            
            //print (paramDict)
            
             print(paramDict.count, "in load")
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         print(paramDict["title"]?.count, "in numberOfRows")
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
    
    override func viewDidAppear(_ animated: Bool) {
        print(paramDict.count, "in appear")
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: FeedsCell = tableView.dequeueReusableCell(withIdentifier: "FeedsCell", for: indexPath) as! FeedsCell                        
        
        
        print (indexPath.row, "INDEXXXXXXXXX")                
                                
        cell.dataTime.text = JSONTaker.shared.convertDate(date: (self.paramDict["date"]?[indexPath.row])!)
        cell.titleText.text = self.paramDict["title"]?[indexPath.row]
        cell.shortText.text = self.paramDict["short"]?[indexPath.row]                        	            
        cell.img.image = JSONTaker.shared.loadImg(url: (self.paramDict["image"]?[indexPath.row])!)                                             
        
        //cell.shortText.sizeToFit()
        
        return cell
    }
}

//https://www.youtube.com/watch?v=K1qrk6XOuIU
