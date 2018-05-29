//
//  testCell.swift
//  ScienceAPP
//
//  Created by 张睿 on 28/4/18.
//  Copyright © 2018 张睿. All rights reserved.
//

import UIKit

class testCell: UITableViewCell {
    @IBOutlet weak var labeldate: UILabel!
    @IBOutlet weak var labelC: UILabel!
    @IBOutlet weak var labelT: UILabel!
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var labeltype: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}
