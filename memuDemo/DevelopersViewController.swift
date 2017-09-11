//
//  DevelopersViewController.swift
//  memuDemo
//
//  Created by Dugar Badagarov on 02/09/2017.
//  Copyright © 2017 Parth Changela. All rights reserved.
//

import UIKit

class DevelopersViewController: UIViewController {

    @IBOutlet var img: UIImageView!    
    @IBOutlet var btnMenuButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        img.image = UIImage(named: "ы")
        
        
        if revealViewController() != nil {                                    
            btnMenuButton.target = revealViewController()                        
            btnMenuButton.action = #selector(SWRevealViewController.revealToggle(_:))                                            
        }
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
}
