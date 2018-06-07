//
//  duepageViewController.swift
//  ScienceAPP
//
//  Created by 张睿 on 2/6/18.
//  Copyright © 2018 张睿. All rights reserved.
//

import UIKit

class duepageViewController: UIViewController,UITableViewDataSource,UITableViewDelegate,addDue,changebutton,UISearchBarDelegate {
    @IBOutlet weak var searchbar: UISearchBar!
    
    func ChangButton(checked: Bool, index: Int) {
        due[index].checked = checked
        DuetableView.reloadData()
    }

    
    func AddDue(title: String, type: String, date: String) {
        due.append(Due(title:title, type: type, date: date))
        currentDue = due
        DuetableView.reloadData()
    }
    
    //search bar
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        currentDue = due.filter({Due -> Bool in
            switch searchBar.selectedScopeButtonIndex{
            case 0:
                if searchText.isEmpty{return true}
                return (Due.title.lowercased().contains(searchText.lowercased()))
            case 1:
                if searchText.isEmpty {return Due.type == "Teaching"}
                return (Due.title.lowercased().contains(searchText.lowercased())) && Due.type == "Teaching"
            case 2:
                if searchText.isEmpty {return Due.type == "General"}
                return (Due.title.lowercased().contains(searchText.lowercased())) && Due.type == "General"
            case 3:
                if searchText.isEmpty {return Due.type == "Research"}
                return (Due.title.lowercased().contains(searchText.lowercased())) && Due.type == "Research"
            default:
                return false
            }
        })
        DuetableView.reloadData()
    }
    // scope
    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        
        switch selectedScope{
            
        case 0:
            currentDue = due
        case 1:
            currentDue = due.filter({Due -> Bool in Due.type == "Teaching"})
        case 2:
            currentDue = due.filter({Due -> Bool in Due.type == "General"})
        case 3:
            currentDue = due.filter({Due -> Bool in Due.type == "Research"})
        default:
            break
        }
        DuetableView.reloadData()
        
    }
     var acc = ["sa","fd","dsa"]
    var due:[Due] = []
    var currentDue:[Due] = []
    @IBOutlet weak var DuetableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchbar.delegate = self
        let image = UIImage(named: "rmit5")
        self.navigationItem.titleView = UIImageView(image: image)
        let atts :[String:Any] = [
            NSAttributedStringKey.font.rawValue : UIFont(name:"Museo", size: 12)!,
            NSAttributedStringKey.foregroundColor.rawValue: UIColor.red,]
        
        searchbar.setScopeBarButtonTitleTextAttributes(atts, for: .normal)
        DuetableView.dataSource = self
        DuetableView.delegate = self

    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.DuetableView.deselectRow(at: indexPath as IndexPath, animated: true)
      
    }
    //点击删除按钮的响应方法，在这里处理删除的逻辑
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCellEditingStyle.delete {
            self.currentDue.remove(at: indexPath.row)
            self.DuetableView.deleteRows(at: [indexPath], with: UITableViewRowAnimation.fade)
        }
         self.DuetableView.reloadData()
    }
    //返回编辑类型，滑动删除
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle {
        return UITableViewCellEditingStyle.delete
    }
    
    private func tableView(tableView: UITableView, titleForDeleteConfirmationButtonForRowAtIndexPath indexPath: IndexPath) -> UIImage {
        return #imageLiteral(resourceName: "001-rubbish-bin.png")
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currentDue.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = DuetableView.dequeueReusableCell(withIdentifier: "duecell", for: indexPath) as! dueCell
        cell.duetitle.text = currentDue[indexPath.row].title
        cell.duetype.text = currentDue[indexPath.row].type
        cell.dueDate.text = currentDue[indexPath.row].date
       
        if due[indexPath.row].checked{
            cell.checkbutton.setBackgroundImage(#imageLiteral(resourceName: "005-checked.png"), for: UIControlState.normal)
        }else{
            cell.checkbutton.setBackgroundImage(#imageLiteral(resourceName: "circle.png"), for: UIControlState.normal)
        }
        cell.delegate = self
        cell.indexPa = indexPath.row
        cell.due = due
       
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as! addDueDateViewController
        vc.delegate = self
    }

}


class Due {
    var title = ""
    var type = ""
    var date = ""
    var checked = false
    convenience init(title:String,type:String,date:String){
        self.init()
        self.title = title
        self.type = type
        self.date = date
        
    }
}
