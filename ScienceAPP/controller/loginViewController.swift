//
//  loginViewController.swift
//  ScienceAPP
//
//  Created by Jicang Wang on 22/4/18.
//  Copyright © 2018 张睿. All rights reserved.
//
import UIKit
import Alamofire
import GoogleSignIn
import Google
import Firebase

class loginViewController: UIViewController, GIDSignInDelegate,GIDSignInUIDelegate{
    
   
    let URL_USER_LOGIN = "http://titan.csit.rmit.edu.au/~s3479320/iosApp/login.php"
    let URL_USER_REGISTER = "http://titan.csit.rmit.edu.au/~s3479320/iosApp/register.php"
    let defaultValues = UserDefaults.standard
    
    @IBOutlet weak var message: UILabel!
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
//        
//        if user.profile.email == nil{
//            
//        }else{
//            let email = user.profile.email
//            print(email!)
//        }
        
        let email = user.profile.email
        print(email!)
        
        let parameters: Parameters=[
            "username":user.profile.email!
        ]
        
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
                        let userAuthority = user.value(forKey: "authority") as! String
                        let userName = user.value(forKey: "username") as! String
                        
                        
                        //saving user values to defaults
                        self.defaultValues.set(userAuthority, forKey: "userAuthority")
                        self.defaultValues.set(userName, forKey: "username")
                        
                        if userAuthority == "visitor"{
                            //self.message.text = "You don't have atourity to access"
                            self.creatAlert(title: "Request Denied", message: "Your account does not have authority to access")
                        }else{
                            //switching the screen
                            let MainTabbar = self.storyboard?.instantiateViewController(withIdentifier:"welcome") as! WelcomeViewController
                            self.navigationController?.pushViewController(MainTabbar, animated: true)
                            
                            self.dismiss(animated: false, completion: nil)
                        }
                    }else{
                        //error message in case of invalid credential
                       self.creatAlert(title: "Request Denied", message: "Your account does not have authority to access")
                        let parameters: Parameters=[
                            "username":user.profile.email!
                        ]
                        Alamofire.request(self.URL_USER_REGISTER, method: .post, parameters: parameters).responseJSON
                            {
                                response in
                                //printing response
                                print(response)
                                
                                
                                
                        }
                        
                        
                    }
                }
                
                
        }

    }
    
    

    
    func creatAlert (title:String,message:String){
        let alter = UIAlertController(title:title,message:message,preferredStyle:UIAlertControllerStyle.alert)
        
        alter.addAction(UIAlertAction(title:"OK",style:UIAlertActionStyle.default,handler:{(action) in alter.dismiss(animated: true, completion: nil)
            print("OK")
        }))
        
        
        self.present(alter,animated: true,completion: nil)
  
    }
        
  
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
//        let singleWaterWaveView = waterview(frame:view.bounds)
//        view.addSubview(singleWaterWaveView)
//        view.sendSubview(toBack: singleWaterWaveView)
        
        //google login part
        GIDSignIn.sharedInstance().uiDelegate = self
        GIDSignIn.sharedInstance().delegate = self
        let googleSignInButton = GIDSignInButton()
     
        googleSignInButton.center = view.center
        view.addSubview(googleSignInButton)
        
        self.navigationController?.isNavigationBarHidden = true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    
}

