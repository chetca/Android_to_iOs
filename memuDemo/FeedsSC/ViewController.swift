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
    
    var day: [String] = []
    var shortText: [String] = []        
    var imgURL: [String] = []
   // var image : UIImageView
    var titleText: [String] = []
    var text: [String] = []
    var json:[String: AnyObject] = [:]
    let dateFormatter = DateFormatter()
    let dateString = "Thu, 22 Oct 2015 07:45:00"
    
    override func viewDidLoad() {
        super.viewDidLoad()     

        // Do any additional setup after loading the view, typically from a nib.
        if revealViewController() != nil {

            btnMenuButton.target = revealViewController()
            btnMenuButton.action = #selector(SWRevealViewController.revealToggle(_:))                        

            
            loadAstrologicalData(baseURL: "file:///Users/dugar/Downloads/feed.json")
        }
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
                for var index: Int in 0...arrJSON.count-1 {
                    let aObject = arrJSON[index] as! [String : AnyObject]  
                    titleText.append(aObject["title"] as! String)
                    shortText.append(aObject["short"] as! String)
                    day.append(aObject["date"] as! String)
                    imgURL.append(aObject["image"] as! String)
                    //text.append(aObject["text"] as! String)
                    
                }
                                                                                 
            }
                        
            self.tableView.reloadData()                        
        }
        catch 
        {
            print(error)
        }            
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.day.count;
    }
    
    var indexCell: Int = 0
    var dataString: [String] = []
    
    @objc(tableView:didSelectRowAtIndexPath:) func tableView(_ tableView: UITableView,didSelectRowAt indexPath: IndexPath) {
        print("You selected name : "+day[indexPath.row])   
        
        indexCell = indexPath.row
        
       // if self.titleText[indexPath.row] != nil && self.text[indexPath.row] != nil && ///self.dataString[indexPath.row] != nil && self.imgURL[indexPath.row] != "" {/
            performSegue(withIdentifier: "segue", sender: self)
        //}                
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        /*
        var currentNews = segue.destination as! ConcretteNewsViewController
        
        
        currentNews.StringLblText = self.titleText[indexCell]
        currentNews.StringTextNews = self.text[indexCell]
        currentNews.StringDataField = dataString[indexCell]
        currentNews.StringUrlImg = self.imgURL[indexCell]
        */
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: FeedsCell = tableView.dequeueReusableCell(withIdentifier: "FeedsCell", for: indexPath) as! FeedsCell                        
                
        dateFormatter.dateFormat = "EEE, dd MMM yyyy hh:mm:ss"
        dateFormatter.locale = Locale.init(identifier: "en_GB")        
        let dateObj = dateFormatter.date(from: self.day[indexPath.row])
        dateFormatter.dateFormat = "dd-MM-yyyy   hh:mm:ss"        
        cell.dataTime.text = dateFormatter.string(from: dateObj!)
        //dataString.append(cell.dataTime.text!)
    
       
        cell.titleText.text = self.titleText[indexPath.row]
        cell.shortText.text = self.shortText[indexPath.row]
       
        //let imageee : UIImageView = UIImageView()	
        print("Хуяк")
        let pic = self.imgURL[indexPath.row]
        print(pic)
        let url = URL(string: pic)
        let data = try? Data(contentsOf: url!)
        
        if let imageData = data {
            cell.img.image = UIImage(data: data!)
        }                                 
        
        //cell.shortText.sizeToFit()
        
        return cell
    }
}

//https://www.youtube.com/watch?v=K1qrk6XOuIU
