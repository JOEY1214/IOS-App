//
//  contentViewController.swift
//  ScienceAPP
//
//  Created by 张睿 on 28/5/18.
//  Copyright © 2018 张睿. All rights reserved.
//

import UIKit

class contentViewController: UIViewController {
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var labeldate: UILabel!
    @IBOutlet weak var labeltype: UILabel!
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var labelContent: UILabel!
    var news: NewArticle?
    override func viewDidLoad() {
        super.viewDidLoad()
        labelTitle.text = news?.headline
        labeltype.text = news?.type
        labeldate.text = news?.date
        labelContent.text = news?.descri
        self.navigationItem.title = "News"
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
       
    }
    



}
