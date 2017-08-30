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
            
            
            paramDict = JSONTaker.shared.loadData(API: "lectures", paramNames: ["title", "date", "short",  "image", "text", "video"])
            //loadAstrologicalData(baseURL: "file:///Users/dugar/Downloads/feed.json")            
            //print (paramDict)            
        }

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
        StringVideoID   = (self.paramDict["video"]?[indexPath.row])!
        performSegue(withIdentifier: "segue", sender: self)         
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: LectureTableViewCell = tableView.dequeueReusableCell(withIdentifier: "LectureTableViewCell", for: indexPath) as! LectureTableViewCell

        cell.dateLbl.text = JSONTaker.shared.convertDate(date: (self.paramDict["date"]?[indexPath.row])!)
        //cell.dateLbl.text = JSONTaker.shared.convertDate(date: (self.paramDict["date"]?[indexPath.row])!)
        cell.titleLbl.text = (self.paramDict["title"]?[indexPath.row])!
        cell.shortTextLbl.text = (self.paramDict["short"]?[indexPath.row])!
        
        JSONTaker.shared.loadImg(imgURL: (self.paramDict["image"]?[indexPath.row])!, 
                                 img: cell.img, 
                                 spinner: cell.spinner)
        

        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
