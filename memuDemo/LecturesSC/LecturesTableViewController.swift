//
//  LecturesTableViewController.swift
//  memuDemo
//
//  Created by Dugar Badagarov on 29/08/2017.
//  Copyright © 2017 Parth Changela. All rights reserved.
//

import UIKit

class LecturesTableViewController: UITableViewController {

    
    @IBOutlet var btnMenuButton: UIBarButtonItem!
    
    var paramDict:[String:[String]] = Dictionary()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if revealViewController() != nil {                        
            
            btnMenuButton.target = revealViewController()                        
            btnMenuButton.action = #selector(SWRevealViewController.revealToggle(_:))
            
            
            paramDict = JSONTaker.shared.loadData(API: "lectures", paramNames: ["title", "date", "short",  "image", "text"])
            //loadAstrologicalData(baseURL: "file:///Users/dugar/Downloads/feed.json")            
            //print (paramDict)            
        }

        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 140
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (paramDict["title"]?.count)!
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("You selected name : "+(self.paramDict["date"]?[indexPath.row])!)
                
        StringLblText   = (self.paramDict["title"]?[indexPath.row])! 
        StringText = (self.paramDict["text"]?[indexPath.row])!
        StringDataField = (self.paramDict["date"]?[indexPath.row])!          
        performSegue(withIdentifier: "segue", sender: self)         
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: LectureTableViewCell = tableView.dequeueReusableCell(withIdentifier: "LectureTableViewCell", for: indexPath) as! LectureTableViewCell

        cell.dateLbl.text = JSONTaker.shared.convertDate(date: (self.paramDict["date"]?[indexPath.row])!)
        //cell.dateLbl.text = JSONTaker.shared.convertDate(date: (self.paramDict["date"]?[indexPath.row])!)
        cell.titleLbl.text = self.paramDict["title"]?[indexPath.row]
        cell.shortTextLbl.setHTML(html: (self.paramDict["short"]?[indexPath.row])!)
        
        JSONTaker.shared.loadImg(imgURL: (self.paramDict["image"]?[indexPath.row])!, 
                                 img: cell.img, 
                                 spinner: cell.spinner,
                                 imgHeightConstraint: cell.imgHeight)        

        
        
        return cell
    }
}
