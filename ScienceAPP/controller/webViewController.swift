//
//  webViewController.swift
//  ScienceAPP
//
//  Created by 张睿 on 28/4/18.
//  Copyright © 2018 张睿. All rights reserved.
//

import UIKit
import WebKit
class webViewController: UIViewController {
    @IBAction func backMain(_ sender: UIButton) {
        let web1 = self.storyboard?.instantiateViewController(withIdentifier:"web") as! webViewController
        self.navigationController?.pushViewController(web1, animated: true)
        self.dismiss(animated: false, completion: nil)
        
    }
    var url: String?
    @IBOutlet weak var webView: WKWebView!
    override func viewDidLoad() {
        super.viewDidLoad()
        webView.load(URLRequest(url: URL(string: url!)!))

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
