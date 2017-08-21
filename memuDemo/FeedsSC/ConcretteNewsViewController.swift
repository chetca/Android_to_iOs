//
//  ConcretteNewsViewController.swift
//  memuDemo
//
//  Created by Dugar Badagarov on 18/08/2017.
//  Copyright © 2017 Parth Changela. All rights reserved.
//

import UIKit

class ConcretteNewsViewController: ViewController {

    
    @IBOutlet weak var lblText: UILabel!    
    @IBOutlet weak var textNews: UILabel!
    @IBOutlet weak var dataField: UILabel!
    @IBOutlet weak var imgNews: UIImageView!
    
    var StringLblText = String()
    var StringTextNews = String()
    var StringDataField = String()
    var StringUrlImg = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        lblText.text = StringLblText
        textNews.text = StringTextNews
        dataField.text = StringDataField
        
        /*
        let url = URL(string: StringUrlImg)
        let data = try? Data(contentsOf: url!)
        
        if let imageData = data {
            imgNews.image = UIImage(data: data!)
        }
        */
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
