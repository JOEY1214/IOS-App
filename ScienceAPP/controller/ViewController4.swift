//
//  ViewController4.swift
//  ScienceAPP
//
//  Created by 张睿 on 7/4/18.
//  Copyright © 2018 张睿. All rights reserved.
//

import UIKit

//子视图控制器2
class ViewController4: UIViewController {
    @IBOutlet weak var view1: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        let textLabel = UILabel(frame: CGRect(x: 0, y: 50, width: 270,
                                              height: 30))
        textLabel.layer.cornerRadius = 4;//边框圆角大小
        //textLabel.layer.masksToBounds = true;
        
        textLabel.layer.borderWidth = 1;//边框宽度
        
        
        textLabel.textAlignment = .left
        textLabel.font = UIFont.systemFont(ofSize: 20)
        //textLabel.backgroundColor = UIColor
        textLabel.textColor = .black
        textLabel.text = "The title of the news"
        view.addSubview(textLabel)
        
        let textLabel1 = UILabel(frame: CGRect(x: 0, y: 50, width: 30,
                                              height: 30))
        textLabel1.layer.cornerRadius = 4;//边框圆角大小
        //textLabel.layer.masksToBounds = true;
        
        textLabel1.layer.borderWidth = 1;//边框宽度
        
        
        textLabel1.textAlignment = .right
        textLabel1.font = UIFont.systemFont(ofSize: 20)
        //textLabel.backgroundColor = UIColor
        textLabel1.textColor = .black
        textLabel1.text = "25/12/2018"
        view.addSubview(textLabel1)
    }
}
