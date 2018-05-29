//
//  EventsContentViewController.swift
//  ScienceAPP
//
//  Created by 张睿 on 28/5/18.
//  Copyright © 2018 张睿. All rights reserved.
//

import UIKit

class EventsContentViewController: UIViewController {

    @IBOutlet weak var EventImg: UIImageView!
    @IBOutlet weak var EventContent: UILabel!
    @IBOutlet weak var EventStart: UILabel!
    @IBOutlet weak var EventDate: UILabel!
    @IBOutlet weak var EventTitle: UILabel!
    var events:event?
    override func viewDidLoad() {
        super.viewDidLoad()
        EventTitle.text = events?.eventTitle
        EventDate.text = events?.creatDate
        EventStart.text = events?.startDate
        EventContent.text = events?.eventContent
       
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    


}
