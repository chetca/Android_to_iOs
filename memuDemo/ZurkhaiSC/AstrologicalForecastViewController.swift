//
//  khuralScheduleViewController.swift
//  memuDemo
//
//  Created by Dugar Badagarov on 11/08/2017.
//  Copyright © 2017 Parth Changela. All rights reserved.
//

import UIKit

class AstrologicalForecastViewController: UIViewController,UINavigationBarDelegate,UINavigationControllerDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var menu: UIBarButtonItem!
    
    var day: [String] = []           
    var texts: [String] = []
    var paramDict:[String:[String]] = Dictionary()    
    
    override func viewDidLoad() {
        super.viewDidLoad()      
        
        //revealViewController().rearViewRevealWidth = 270
        
        menu.target = revealViewController()
        menu.action = #selector(SWRevealViewController.revealToggle(_:))
        
        
        //http://localhost:8080/budd/http/api/zurkhay           
        
        for var i in 1...7
        {
            texts.append("text" + String(i))
        }
        
        
        paramDict = JSONTaker.shared.loadData(API: "zurkhay", paramNames: ["id", "date", "title", "text"])
        
        //print ("paramDict.count", paramDict.count)
        
        
        tableView.contentInset = UIEdgeInsetsMake(20.0, 0.0, 0.0, 0.0)        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 44 
        
        tableView.allowsSelection = false
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }        
    
    func tableView(_ tableView: UITableView!, numberOfRowsInSection section: Int) -> Int {
        return (self.paramDict["id"]?.count)!;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAtIndexPath indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "cell")        
    
        if !(cell != nil) {
            cell = UITableViewCell(style: .subtitle, reuseIdentifier: "cell") //if cell is nil, get pointer to new one
        }

        cell?.detailTextLabel?.textColor = UIColor.black
        cell?.detailTextLabel?.setHTML(html: (paramDict["text"]?[indexPath.row])!)        
        
        cell?.textLabel?.font = UIFont(name: "Helvetica", size: 13)                        
        cell?.textLabel?.text = "Зурхай на " + (paramDict["date"]?[indexPath.row])! + ":"        
        cell?.textLabel?.numberOfLines = 0            
        
        return cell!
    }
}
