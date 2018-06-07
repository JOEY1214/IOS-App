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
        let image = UIImage(named: "LOGO111")
        self.navigationItem.titleView = UIImageView(image: image)
        navigationItem.largeTitleDisplayMode = .never
        EventTitle.text = events?.eventTitle
        EventDate.text = events?.creatDate
        EventStart.text = events?.startDate
        EventContent.text = events?.eventContent
        let defaultLink = "http://ec2-34-218-253-200.us-west-2.compute.amazonaws.com/csitapp/"
        let completeLink = defaultLink + (events?.envenImg!)!
        EventImg.downloadedFrom(link: completeLink)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    


}
