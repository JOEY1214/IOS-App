//
//  CTableViewCell.swift
//  ScienceAPP
//
//  Created by 张睿 on 8/4/18.
//  Copyright © 2018 张睿. All rights reserved.
//

import UIKit

class CTableViewCell: UITableViewCell {
    @IBOutlet weak var cview: UIView!    
    @IBOutlet weak var arrow: UIImageView!
    @IBOutlet weak var cname: UILabel!
    @IBOutlet weak var cimg: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}
