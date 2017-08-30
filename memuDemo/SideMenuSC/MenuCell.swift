//
//  MenuCell.swift
//  memuDemo
//
//  Created by Parth Changela on 09/10/16.
//  Copyright © 2016 Parth Changela. All rights reserved.
//

import UIKit

class MenuCell: UITableViewCell {

    @IBOutlet var lblMenuRightConstraint: NSLayoutConstraint!
    @IBOutlet weak var lblMenuname: UILabel!
    @IBOutlet weak var imgIcon: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        if let window = UIApplication.shared.keyWindow {
            lblMenuRightConstraint.constant = -window.frame.width * 0.2
        }
        
        lblMenuname.sizeToFit()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
