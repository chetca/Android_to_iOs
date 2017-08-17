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
    var zurkhay: [String] = []        
    var json:[String: AnyObject] = [:]
    
    override func viewDidLoad() {
        super.viewDidLoad()        
        
        //revealViewController().rearViewRevealWidth = 270
        
        menu.target = revealViewController()
        menu.action = #selector(SWRevealViewController.revealToggle(_:))
        
        loadAstrologicalData(baseURL: "file:///Users/dugar/Downloads/generated.json")
        //http://localhost:8080/budd/http/api/zurkhay           
        
        day.append("Понедельник")
        day.append("Вторник")
        day.append("Среда")
        day.append("Четверг")
        day.append("Пятница")
        day.append("Суббота")
        day.append("Воскресение")
        
        tableView.contentInset = UIEdgeInsetsMake(20.0, 0.0, 0.0, 0.0)        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 44
        
     
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func loadAstrologicalData(baseURL :String) {
        let url=URL(string: baseURL)
        do {
            let allContactsData = try Data(contentsOf: (url)!)
            let allContacts = try JSONSerialization.jsonObject(with: allContactsData, options: JSONSerialization.ReadingOptions.allowFragments) as! [String : AnyObject]
            
            if let arrJSON = allContacts["page"] {           
                print (arrJSON)                  
                let aObject = arrJSON[0] as! [String : AnyObject]                    
                for i in 1...7 {
                    zurkhay.append(aObject["text"+String(i)] as! String)                    
                }                                                                    
            }
            
            
            print(allContacts)
            print(day)
            print(zurkhay)
            self.tableView.reloadData()
            
        }
        catch 
        {
            print(error)
        }            
    }
    
    func tableView(_ tableView: UITableView!, numberOfRowsInSection section: Int) -> Int {
        return self.day.count;
    }
    func tableView(_ tableView: UITableView!, didSelectRowAtIndexPath indexPath: IndexPath!) {
        print("You selected name : "+day[indexPath.row])
    }
    
    func tableView(_ tableView: UITableView, cellForRowAtIndexPath indexPath: IndexPath) -> UITableViewCell{
        var cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        
        
        if !(cell != nil) {
            cell = UITableViewCell(style: .subtitle, reuseIdentifier: "cell")
        }
        cell?.textLabel?.text=self.day[indexPath.row] + "\n" + self.zurkhay[indexPath.row]
        cell?.textLabel?.numberOfLines = 0
        
        return cell!
    }
}
