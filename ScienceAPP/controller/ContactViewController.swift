//
//  ContactViewController.swift
//  ScienceAPP
//
//  Created by 张睿 on 26/3/18.
//  Copyright © 2018 张睿. All rights reserved.
//

import UIKit

var contactIndex = 0

class ContactViewController: UIViewController,UITableViewDataSource,UITableViewDelegate,UISearchBarDelegate{
   
    
    let cellId = "cell"
    @IBOutlet weak var search: UISearchBar!
    @IBOutlet weak var contactTableView: UITableView!
    var currentContactD = [contacter]()
    var Department = [DepartmentName]()
    var currentContact = [contacter]()
    
    var twoArry = [[contacter(name: "Owen Shemansky", icon: "rmitlogo",postion:"Senior Manager, Planning & Resources",location:"14.10.06",tel:"9925 3632"),contacter(name: "Dr Paul Perry", icon: "Ray Allen",postion:"Business Development Manager",location:"14.10.33",tel:"9925 9671"),contacter(name: "Boogie Balsan", icon: "Ray Allen",postion:"Manager, Academic & Student Operations",location:"14.10.35",tel:"9925 3012")],
        [contacter(name: "Dora Poulakis", icon: "Ray Allen",postion:"School Services Coordinator",location:"14.10.35",tel:"9925 9583"),contacter(name: "Mardi O’Donnell", icon: "Ray Allen",postion:"School Services Advisor",location:"14.10.35",tel:"9925 1873")]]
    
  
    private func setUpsearchBar(){
        
        search.delegate = self
        search.barTintColor = UIColor.white
        
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
   
    /*func alterLayout(){
        contactTableView.tableHeaderView = UIView()
        contactTableView.estimatedSectionHeaderHeight = 40
    }*/
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
       return 80
   }
   func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
    let cell = contactTableView.dequeueReusableCell(withIdentifier:"cell") as! header
    cell.name.text = Department[section].Dname
    cell.function.text = Department[section].description
    cell.backgroundColor = UIColor.darkGray
    return cell
    
   }
   
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
   
        return twoArry[section].count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = contactTableView.dequeueReusableCell(withIdentifier: "contactcell") as! CTableViewCell
        cell.cview.layer.cornerRadius = cell.cview.frame.height / 2
        cell.cview.layer.borderWidth = 1.5
        cell.cview.layer.borderColor = UIColor.black.cgColor
        cell.cimg.layer.cornerRadius = cell.cimg.frame.height / 2
        cell.cimg.clipsToBounds = true
        cell.cname.text = twoArry[indexPath.section][indexPath.row].name
        cell.arrow.image = UIImage(named: "003arrows")
        cell.cimg.image = UIImage(named:twoArry[indexPath.section][indexPath.row].icon)
       // cell.backgroundColor = UIColor.lightGray
        
        return cell
    }
    
    //search bar
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard !searchText.isEmpty else{
            contactTableView.reloadData()
            return
        }
        currentContactD = twoArry[0].filter({contacter -> Bool in
           contacter.name.lowercased().contains(searchText.lowercased())
            
        })
        currentContact = twoArry[1].filter({contacter -> Bool in
            contacter.name.lowercased().contains(searchText.lowercased())
            
        })
        contactTableView.reloadData()
    }
 
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? profileViewController {
            destination.ContactDetial = twoArry[(contactTableView.indexPathForSelectedRow?.section)!][(contactTableView.indexPathForSelectedRow?.row)!]
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        currentContactD = twoArry[0]
        currentContact = twoArry[1]
        contactTableView.register(header.self, forCellReuseIdentifier: cellId)
        self.contactTableView.contentInset = UIEdgeInsetsMake(-20, 0, 0, 0)
        setUpSection()
        setUpsearchBar()
        //alterLayout()
        contactTableView.delegate = self
        contactTableView.dataSource  = self
        self.navigationItem.titleView = search
        self.navigationController?.navigationBar.barTintColor = UIColor.white
        //let image = UIImage(named: "rmit5")
       // self.navigationItem.titleView = UIImageView(image: image)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
 
}

class contacter {
    let name : String
    let icon : String
    let postion: String
    let location : String
    let tel : String
    
    init(name:String,icon:String,postion:String,location:String,tel:String) {
        self.name = name
        self.icon = icon
        self.postion = postion
        self.location = location
        self.tel = tel
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

public class header: UITableViewCell{
    
    override init(style:UITableViewCellStyle,reuseIdentifier:String?){
        super.init(style: style, reuseIdentifier:reuseIdentifier)
        setupViews()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let name: UILabel = {
        let label = UILabel()
        label.text = "Department name"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name:"Museo",size:18)
        label.numberOfLines = 1
        label.adjustsFontSizeToFitWidth = true
         label.textColor = UIColor.white
       
        
        return label
    }()
    
    let function: UILabel = {
        let label = UILabel()
        label.text = "Function"
        label.font = UIFont(name:"Avenir",size:13)
        label.textColor = UIColor.white
        label.translatesAutoresizingMaskIntoConstraints = false
        label.adjustsFontSizeToFitWidth = true
        label.numberOfLines = 0
        
        return label
    }()
    
    func setupViews(){
        
        addSubview(name)
        addSubview(function)
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-5-[v0]-5-|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0":name]))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-8-[v0]-55-|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0":name]))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-5-[v0]-5-|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0":function]))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-20-[v0]-5-|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0":function]))
        
        
    }
}

