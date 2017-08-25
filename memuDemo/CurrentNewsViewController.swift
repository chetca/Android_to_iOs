//
//  CurrentNewsViewController.swift
//  memuDemo
//
//  Created by Dugar Badagarov on 23/08/2017.
//  Copyright © 2017 Parth Changela. All rights reserved.
//

import UIKit

class CurrentNewsViewController: UIViewController {

    
    @IBOutlet var lblText: UILabel!
    @IBOutlet var dataField: UILabel!    
    @IBOutlet var textNews: UILabel!
    @IBOutlet var img: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        lblText.text = StringLblText
        dataField.text = StringDataField
        textNews.text = StringText
        
     
        img.image = JSONTaker.shared.loadImg(url: StringUrlImg)
        
        // Do any additional setup after loading the view.
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
