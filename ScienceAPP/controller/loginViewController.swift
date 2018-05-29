//
//  loginViewController.swift
//  ScienceAPP
//
//  Created by Jicang Wang on 22/4/18.
//  Copyright © 2018 张睿. All rights reserved.
//
import UIKit
import Alamofire
class loginViewController: UIViewController {
    
    let URL_USER_LOGIN = "http://ec2-34-217-69-44.us-west-2.compute.amazonaws.com/php/ios/login.php"
    let defaultValues = UserDefaults.standard
    
    @IBOutlet weak var StudentNum: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var RmitLogo: UILabel!
    @IBAction func LoginFunction(_ sender: UIButton) {
        
        //getting the username and password
        let parameters: Parameters=[
            "username":StudentNum.text!,
            "password":password.text!
        ]
        
        //making a post request
        Alamofire.request(URL_USER_LOGIN, method: .post, parameters: parameters).responseJSON
            {
                response in
                //printing response
                print(response)
                
                //getting the json value from the server
                if let result = response.result.value {
                    let jsonData = result as! NSDictionary
                    
                    //if there is no error
                    if(!(jsonData.value(forKey: "error") as! Bool)){
                        //getting the user from response
                        let user = jsonData.value(forKey: "user") as! NSDictionary
                        
                        //getting user values
                        let userId = user.value(forKey: "id") as! Int
                        let userName = user.value(forKey: "username") as! String
                        
                        
                        //saving user values to defaults
                        self.defaultValues.set(userId, forKey: "userid")
                        self.defaultValues.set(userName, forKey: "username")
                        
                        
                        //switching the screen
                        let MainTabbar = self.storyboard?.instantiateViewController(withIdentifier:"mainTabbar") as! mainTabbar
                        self.navigationController?.pushViewController(MainTabbar, animated: true)
                        
                        self.dismiss(animated: false, completion: nil)
                        
                    }else{
                        //error message in case of invalid credential
                        self.RmitLogo.text = "Invalid username or password"
                    }
                }
                
                
        }
        
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //self.login.layer.cornerRadius = self.login.layer.frame.height / 2
        //self.login.layer.borderWidth = 2.5
        self.StudentNum.layer.cornerRadius = 5
        self.StudentNum.layer.borderWidth = 2
        self.password.layer.cornerRadius = 5
        self.password.layer.borderWidth = 2
        self.password.layer.borderColor = UIColor.lightGray.cgColor
        self.StudentNum.layer.borderColor = UIColor.lightGray.cgColor
        // self.login.layer.borderColor = UIColor.black.cgColor
        let singleWaterWaveView = waterview(frame:view.bounds)
        view.addSubview(singleWaterWaveView)
        view.sendSubview(toBack: singleWaterWaveView)
        
        self.navigationController?.isNavigationBarHidden = true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    
}

