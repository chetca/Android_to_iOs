//
//  HistoryTableViewCell.swift
//  memuDemo
//
//  Created by Dugar Badagarov on 25/08/2017.
//  Copyright © 2017 Parth Changela. All rights reserved.
//

import UIKit

class HistoryTableViewCell: UITableViewCell {

    @IBOutlet var titleLbl: UILabel!
    @IBOutlet var img: UIImageView!
  //  @IBOutlet var shortTextLbl: UILabel!
    @IBOutlet var dataTime: UILabel!
    @IBOutlet var shortText: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
