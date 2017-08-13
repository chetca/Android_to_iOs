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
    
    var names: [String] = []
    var contacts: [String] = []
    
    var items: NSMutableArray = []
    var stringForecast:String = ""
    var json:[String: AnyObject] = [:]
    
    override func viewDidLoad() {
        super.viewDidLoad()        
        
        //revealViewController().rearViewRevealWidth = 270
        
        menu.target = revealViewController()
        menu.action = #selector(SWRevealViewController.revealToggle(_:))
        
       // loadAstrologicalData(baseURL: "http://api.androidhive.info/contacts/")
        //http://localhost:8080/budd/http/api/zurkhay           
        
     
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func loadAstrologicalData(baseURL :String) {
        let url=URL(string: baseURL)
        do {
            let allContactsData = try Data(contentsOf: url!)
            let allContacts = try JSONSerialization.jsonObject(with: allContactsData, options: JSONSerialization.ReadingOptions.allowFragments) as! [String : AnyObject]
            if let arrJSON = allContacts["contacts"] {
                for index in 0...arrJSON.count-1 {
                    
                    let aObject = arrJSON[index] as! [String : AnyObject]
                    
                    names.append(aObject["name"] as! String)
                    contacts.append(aObject["email"] as! String)
                }
            }
            print(names)
            print(contacts)
            self.tableView.reloadData()
            
        }
        catch 
        {
            print(error)
        }            
    }
    
    func tableView(_ tableView: UITableView!, numberOfRowsInSection section: Int) -> Int {
        return self.names.count;
    }
    func tableView(_ tableView: UITableView!, didSelectRowAtIndexPath indexPath: IndexPath!) {
        print("You selected name : "+names[indexPath.row])
    }
    
    func tableView(_ tableView: UITableView, cellForRowAtIndexPath indexPath: IndexPath) -> UITableViewCell{
        var cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        
        if !(cell != nil) {
            cell = UITableViewCell(style: .subtitle, reuseIdentifier: "cell")
        }
        cell?.textLabel?.text=self.names[indexPath.row]
        cell?.detailTextLabel?.text = self.contacts[indexPath.row]
        return cell!
    }
}
