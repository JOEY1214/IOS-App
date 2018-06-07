//
//  dueCell.swift
//  ScienceAPP
//
//  Created by 张睿 on 2/6/18.
//  Copyright © 2018 张睿. All rights reserved.
//

import UIKit
protocol changebutton{
    func ChangButton(checked:Bool,index:Int)
    
}
class dueCell: UITableViewCell {
    @IBOutlet weak var duetype: UILabel!
    @IBOutlet weak var duetitle: UILabel!
    @IBOutlet weak var dueDate: UILabel!
    @IBOutlet weak var checkbutton: UIButton!
    @IBAction func checkaction(_ sender: Any) {
      
        if due![indexPa!].checked{
            
            delegate?.ChangButton(checked: false, index:indexPa!)
        }else{
            
            delegate?.ChangButton(checked: true, index: indexPa!)
        }
        
     }
    var delegate: changebutton?
    var indexPa: Int?
    var due: [Due]?
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

       
    }

}
