//
//  profileViewController.swift
//  ScienceAPP
//
//  Created by 张睿 on 10/4/18.
//  Copyright © 2018 张睿. All rights reserved.
//

import UIKit

class profileViewController: UIViewController {

    @IBOutlet weak var tel: UILabel!
    @IBOutlet weak var position: UILabel!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var location: UILabel!
    @IBOutlet weak var Icon: UIImageView!
    @IBOutlet weak var backgroundView: UIImageView!
    var ContactDetial:contacter?
    
    override func viewDidLoad() {
        super.viewDidLoad()
          navigationItem.largeTitleDisplayMode = .never
        let image = UIImage(named: "LOGO11")
        self.navigationItem.titleView = UIImageView(image: image)
        self.Icon.layer.cornerRadius = Icon.frame.size.width/2
        self.Icon.clipsToBounds = true
//        self.Icon.layer.borderWidth = 0
//        self.Icon.layer.borderColor = UIColor.red.cgColor
        name.text = ContactDetial?.name
        position.text = ContactDetial?.postion
        tel.text = ContactDetial?.tel
        location.text = ContactDetial?.location
        Icon.image = UIImage(named: (ContactDetial?.icon)!)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
       
    }    

}
