//
//  HistoryTableViewController.swift
//  memuDemo
//
//  Created by Dugar Badagarov on 25/08/2017.
//  Copyright © 2017 Parth Changela. All rights reserved.
//

import UIKit

class HistoryTableViewController: UITableViewController 
{
    @IBOutlet var btnMenuButton: UIBarButtonItem!
    var paramDict: [String:[String]] = Dictionary()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        if revealViewController() != nil {                        
            
            btnMenuButton.target = revealViewController()
            btnMenuButton.action = #selector(SWRevealViewController.revealToggle(_:))
        } 
        
        
        paramDict = JSONTaker.shared.loadData(baseURL: "file:///Users/dugar/Downloads/history.json", paramNames: ["title","date","short","image","text"])
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(paramDict.count, "in numberOfRows")
        return self.paramDict["title"]!.count
    }
    
    var dataString: [String] = []
    
    @objc(tableView:didSelectRowAtIndexPath:) override func tableView(_ tableView: UITableView,didSelectRowAt indexPath: IndexPath) {
        print("You selected name : "+(self.paramDict["date"]?[indexPath.row])!)
        
        
        StringLblText   = (self.paramDict["title"]?[indexPath.row])! 
        StringText  = (self.paramDict["text"]?[indexPath.row])!
        StringDataField = (self.paramDict["date"]?[indexPath.row])!
        StringUrlImg    = (self.paramDict["image"]?[indexPath.row])!  
        print(paramDict.count, "in select")
        performSegue(withIdentifier: "segue", sender: self)                       
    }
    
    override func viewDidAppear(_ animated: Bool) {
        print(paramDict.count, "in appear")
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: HistoryTableViewCell = tableView.dequeueReusableCell(withIdentifier: "HistoryTableViewCell", for: indexPath) as! HistoryTableViewCell                        
        
        
        print (indexPath.row, "INDEXXXXXXXXX")
        
        
                                
        cell.dataTime.text = JSONTaker.shared.convertDate(date: (self.paramDict["date"]?[indexPath.row])!)
        cell.titleLbl.text = self.paramDict["title"]?[indexPath.row]
        cell.shortText.text = self.paramDict["short"]?[indexPath.row]                        	            
        cell.img.image = JSONTaker.shared.loadImg(url: (self.paramDict["image"]?[indexPath.row])!)                                             
        
        //cell.shortText.sizeToFit()
        
        return cell
    }


}
