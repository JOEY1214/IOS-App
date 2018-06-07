//
//  ContactViewController.swift
//  ScienceAPP
//
//  Created by 张睿 on 26/3/18.
//  Copyright © 2018 张睿. All rights reserved.
//

import UIKit
import Google
import GoogleSignIn

var contactIndex = 0

class ContactViewController: UIViewController,UITableViewDataSource,UITableViewDelegate,UISearchBarDelegate{
    
    let cellId = "cell"
    @IBOutlet weak var contactTableView: UITableView!
    var deanContact = [contacter]()
    var serverContact = [contacter]()
    //var twoArry :[[contacter]] = [[]]
    var Department = [DepartmentName]()
    var twoArry = [[contacter(name: "Owen Shemansky", icon: "user2",postion:"Senior Manager, Planning & Resources",location:"14.10.06",tel:"9925 3632", department: "Office of the Executive Dean"),contacter(name: "Dr Paul Perry", icon: "user2",postion:"Business Development Manager",location:"14.10.33",tel:"9925 9671", department: "Office of the Executive Dean"),contacter(name: "Boogie Balsan", icon: "user2",postion:"Manager, Academic & Student Operations",location:"14.10.35",tel:"9925 3012", department: "Office of the Executive Dean")],
                   [contacter(name: "Dora Poulakis", icon: "user2",postion:"School Services Coordinator",location:"14.10.35",tel:"9925 9583", department: "School Services"),contacter(name: "Mardi O’Donnell", icon: "user2",postion:"School Services Advisor",location:"14.10.35",tel:"9925 1873", department: "School Services")]]
    
  
    @IBAction func LogOutFunction(_ sender: Any) {
        GIDSignIn.sharedInstance().signOut()
        let mainLogin = self.storyboard?.instantiateViewController(withIdentifier:"loginViewController") as! loginViewController
        self.navigationController?.pushViewController(mainLogin, animated: true)
        
        self.dismiss(animated: false, completion: nil)
        
    }
    
    private func setUpSection(){
        
        Department.append(DepartmentName(Dname: "Office of the Executive Dean", description: "Functions: team management, business development, budget management,executive and strategic support to the School Executive and point of escalation for complicated matters."))
         Department.append(DepartmentName(Dname: "School Services", description: "Functions: Supports the operational aspects of the School, including space and asset management, supplies and purchasing, events (including marketing activities), OH&S as well as provides support to Associate Deans and Program Advisory Boards ( PAC)."))
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return twoArry.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        contactIndex = indexPath.row
        performSegue(withIdentifier: "profile", sender:self)
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
       return 90
   }
  
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
    let cell = contactTableView.dequeueReusableCell(withIdentifier:"headercell") as! HeaderCell
    cell.departmentLabel.text = Department[section].Dname
    cell.functionLabel.text = Department[section].description
    
    return cell
    
   }
   
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
   
        return twoArry[section].count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = contactTableView.dequeueReusableCell(withIdentifier: "contactcell") as! CTableViewCell
        cell.cview.layer.cornerRadius = cell.cview.frame.height / 2
//        cell.cview.layer.borderWidth = 1.5
//        cell.cview.layer.borderColor = UIColor.black.cgColor
        cell.cimg.layer.cornerRadius = cell.cimg.frame.height / 2
        cell.cimg.clipsToBounds = true
        cell.cname.text = twoArry[indexPath.section][indexPath.row].name
        cell.arrow.image = UIImage(named: "arrows")
        cell.cimg.image = UIImage(named:twoArry[indexPath.section][indexPath.row].icon!)
      
        
        return cell
    }
    
    func fetchContact(){
       
        let urlRequest = URLRequest(url: URL(string:"http://titan.csit.rmit.edu.au/~s3479320/iosApp/contact.php")!)
        let task = URLSession.shared.dataTask(with: urlRequest){ (data,response,error) in

            if error != nil{
                print("error")
                return
            }

            do{

                let json = try JSONSerialization.jsonObject(with: data!, options:[]) as! [Any]

                for jsonResult in json{

                    let articlesFromJson = jsonResult as! [String:AnyObject]

                    let contact = contacter(name:(articlesFromJson["name"]! as? String)!,icon:(articlesFromJson["image_path"]! as? String)!, postion:(articlesFromJson["identity"]!as? String)!,location:(articlesFromJson["office_address"]! as? String)!,tel:(articlesFromJson["phone"]! as? String)!, department: (articlesFromJson["department"]! as? String)!)
                
                    if contact.department == "School Services"{

                       
                    }else{



                    }

                }

                DispatchQueue.main.async {
                    self.contactTableView.reloadData()
                }
            }catch let error{
                print(error)
            }


        }

        task.resume()
    }

//    //search bar
//    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
//        guard !searchText.isEmpty else{
//            contactTableView.reloadData()
//            return
//        }
//
//        contactTableView.reloadData()
//    }
    
    func setUpNaviBar(){
        navigationController?.navigationBar.prefersLargeTitles = true
        let searchcontroller = UISearchController(searchResultsController: nil)
        navigationItem.searchController = searchcontroller
        navigationItem.hidesSearchBarWhenScrolling = true
        //searchcontroller.searchBar. = UIColor.white

    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? profileViewController {
            destination.ContactDetial = twoArry[(contactTableView.indexPathForSelectedRow?.section)!][(contactTableView.indexPathForSelectedRow?.row)!]
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpNaviBar()
        setUpSection()
        contactTableView.delegate = self
        contactTableView.dataSource  = self
        let image = UIImage(named: "LOGO11")
        self.navigationItem.titleView = UIImageView(image: image)

    }
 
}

class contacter {
    let name : String?
    let icon : String?
    let postion: String?
    let location : String?
    let tel : String?
    let department : String?
    
    init(name:String,icon:String,postion:String,location:String,tel:String,department:String) {
        self.name = name
        self.icon = icon
        self.postion = postion
        self.location = location
        self.tel = tel
        self.department = department
    }
}

class DepartmentName {
    let Dname : String
    let description : String
    
    init(Dname:String,description:String) {
        
        self.Dname = Dname
        self.description = description
    }
}

