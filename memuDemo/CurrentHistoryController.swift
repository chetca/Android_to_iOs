//
//  CurrentHistoryController.swift
//  memuDemo
//
//  Created by Dugar Badagarov on 26/08/2017.
//  Copyright © 2017 Parth Changela. All rights reserved.
//

import UIKit

class CurrentHistoryController: UIViewController {

  
    @IBOutlet var dateTime: UILabel!
    @IBOutlet var text: UILabel!
    @IBOutlet var img: UIImageView!
    @IBOutlet var titleText: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        dateTime.text=StringDataField
        text.text = StringText
        titleText.text = StringLblText
          img.image = JSONTaker.shared.loadImg(url: StringUrlImg)
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
