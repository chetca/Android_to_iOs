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
    
    @IBAction func orederBtn(_ sender: Any) {
        performSegue(withIdentifier: "segue", sender: self)
        //print((sender as! UIButton).restorationIdentifier)
        //StringLblText   = (self.paramDict["title"]?[indexPath.row])! 
        //tringDataField = (self.paramDict["date"]?[indexPath.row])!  
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //revealViewController().rearViewRevealWidth = 270
        
        if revealViewController() != nil {                        
            
            btnMenuButton.target = revealViewController()                        
            btnMenuButton.action = #selector(SWRevealViewController.revealToggle(_:))
            
            
            paramDict = JSONTaker.shared.loadData(API: "rasp", paramNames: ["id", "title", "date", "text"])                        
        }
        
        tableView.contentInset = UIEdgeInsetsMake(20.0, 0.0, 0.0, 0.0)        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 44 
        
        tableView.allowsSelection = false
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }        
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (paramDict["id"]?.count)!
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "HuralCell") as! HuralCell
        
        /*
        if !(cell != nil) {
            cell = UITableViewCell(style: .subtitle, reuseIdentifier: "cell") //if cell is nil, get pointer to new one
        }
        */
        
        cell.titleLbl.text = (paramDict["title"]?[indexPath.row])!
        cell.textLbl.text = (paramDict["text"]?[indexPath.row])!
        cell.dateFieldLbl.text = JSONTaker.shared.convertDate(date: (paramDict["date"]?[indexPath.row])!)
        cell.orderBtn.restorationIdentifier = (paramDict["id"]?[indexPath.row])!
        
        
        return cell
    }
}
