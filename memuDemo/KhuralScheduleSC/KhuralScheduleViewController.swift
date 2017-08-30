//
//  MessageViewController.swift
//  memuDemo
//
//  Created by Parth Changela on 09/10/16.
//  Copyright © 2016 Parth Changela. All rights reserved.
//

import UIKit

class KhuralScheduleViewController: UITableViewController,UINavigationBarDelegate,UINavigationControllerDelegate {
    
    @IBOutlet var btnMenuButton: UIBarButtonItem!        
    
    var paramDict:[String:[String]] = Dictionary()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //revealViewController().rearViewRevealWidth = 270
        
        if revealViewController() != nil {                        
            
            btnMenuButton.target = revealViewController()                        
            btnMenuButton.action = #selector(SWRevealViewController.revealToggle(_:))
            
            
            paramDict = JSONTaker.shared.loadData(API: "rasp", paramNames: ["title", "date", "text"])                        
        }
        
        tableView.contentInset = UIEdgeInsetsMake(20.0, 0.0, 0.0, 0.0)        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 44 
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (paramDict["title"]?.count)!
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        
        
        if !(cell != nil) {
            cell = UITableViewCell(style: .subtitle, reuseIdentifier: "cell") //if cell is nil, get pointer to new one
        }
        
        
        if (indexPath.row >= 0 && indexPath.row <= 6) {
            cell?.textLabel?.text = (self.paramDict["title"]?[indexPath.row])! + "\n" + (self.paramDict["text"]?[indexPath.row])!
            cell?.detailTextLabel?.text = JSONTaker.shared.convertDate(date: (self.paramDict["date"]?[indexPath.row])!)
            cell?.textLabel?.numberOfLines = 0            
        }
        
        return cell!
    }
}
