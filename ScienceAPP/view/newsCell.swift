//
//  newsCell.swift
//  ScienceAPP
//
//  Created by 张睿 on 28/4/18.
//  Copyright © 2018 张睿. All rights reserved.
//

import UIKit

class newsCell: UITableViewCell {
    @IBOutlet weak var newsimg: UIImageView!
    @IBOutlet weak var newstitle: UILabel!
    @IBOutlet weak var newstag: UILabel!
    @IBOutlet weak var newsdec: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
