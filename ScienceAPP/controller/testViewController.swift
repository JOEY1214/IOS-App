

import UIKit

class testViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate {
   
    @IBOutlet weak var searchBar: UISearchBar!
    var news = [NewArticle]()
    var currentNews = [NewArticle]()
//
//    func alterLayout(){
//       navigationController?.navigationBar.prefersLargeTitles = true
//        navigationItem.titleView = searchBar
//
//    }
  
    //search bar
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        currentNews = news.filter({NewArticle -> Bool in
            switch searchBar.selectedScopeButtonIndex{
            case 0:
                if searchText.isEmpty{return true}
                return (NewArticle.headline?.lowercased().contains(searchText.lowercased()))!
            case 1:
                if searchText.isEmpty {return NewArticle.type == "Teaching"}
                return (NewArticle.headline?.lowercased().contains(searchText.lowercased()))! && NewArticle.type == "Teaching"
            case 2:
                if searchText.isEmpty {return NewArticle.type == "General"}
                return (NewArticle.headline?.lowercased().contains(searchText.lowercased()))! && NewArticle.type == "General"
            case 3:
                if searchText.isEmpty {return NewArticle.type == "Research"}
                return (NewArticle.headline?.lowercased().contains(searchText.lowercased()))! && NewArticle.type == "Research"
            default:
                return false
            }
        })
        testtableview.reloadData()
    }
    // scope
    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        
        switch selectedScope{
            
        case 0:
            currentNews = news
        case 1:
            currentNews = news.filter({NewArticle -> Bool in NewArticle.type == "Teaching"})
        case 2:
            currentNews = news.filter({NewArticle -> Bool in NewArticle.type == "General"})
        case 3:
            currentNews = news.filter({NewArticle -> Bool in NewArticle.type == "Research"})
        default:
            break
        }
        testtableview.reloadData()
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
   
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.currentNews.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = testtableview.dequeueReusableCell(withIdentifier: "test") as! testCell
        cell.labelT.text = self.currentNews[indexPath.item].headline
        cell.labelC.text =  self.currentNews[indexPath.item].descri
        cell.labeltype.text = self.currentNews[indexPath.item].type
        cell.labeldate.text = self.currentNews[indexPath.item].date
        
        if currentNews[indexPath.row].imgUrl == nil{
            cell.img.image = #imageLiteral(resourceName: "newsimg1.png")
            
        }else{
            let defaultLink = "http://ec2-34-218-253-200.us-west-2.compute.amazonaws.com/csitapp/"
            let completeLink = defaultLink + currentNews[indexPath.row].imgUrl!
            cell.img.downloadedFrom(link: completeLink)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier:"newsegue", sender: self)
    }
   
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? contentViewController{
            destination.news =  currentNews[(testtableview.indexPathForSelectedRow?.row)!]
        }
    }
    
    func fetchNews (){
        let urlRequest = URLRequest(url: URL(string:"http://titan.csit.rmit.edu.au/~s3479320/iosApp/Allinfo.php")!)
        let task = URLSession.shared.dataTask(with: urlRequest){ (data,response,error) in
            
            if error != nil{
                print("error")
                return
            }
            
            //self.news = [NewArticle]()
            do{
               
                let json = try JSONSerialization.jsonObject(with: data!, options:[]) as! [Any]
                
                    for jsonResult in json{
                        
                        let articlesFromJson = jsonResult as! [String:AnyObject]
            
                        let new = NewArticle(headline:articlesFromJson["title"]! as? String,descri:articlesFromJson["content"]! as? String, type:articlesFromJson["category"]!as? String,date:articlesFromJson["create_date"]! as? String,imgUrl:articlesFromJson["image_path"]! as? String)
                        self.news.append(new)
                        self.currentNews = self.news
                    }
                    
                
                DispatchQueue.main.async {
                    self.testtableview.reloadData()
                }
            }catch let error{
                print(error)
            }
            
            
        }
        
        task.resume()
    }
    
    @IBOutlet weak var testtableview: UITableView!
    
    override func viewDidLoad() {

        super.viewDidLoad()
        searchBar.delegate = self
        testtableview.dataSource = self
        testtableview.delegate = self
        fetchNews()
        self.navigationController?.navigationBar.barTintColor =
            UIColor.white
        let image = UIImage(named: "rmit5")
        self.navigationItem.titleView = UIImageView(image: image)
        let atts :[String:Any] = [
        
            NSAttributedStringKey.font.rawValue : UIFont(name:"Museo", size: 12)!,
            NSAttributedStringKey.foregroundColor.rawValue: UIColor.red,
    
        ]
        searchBar.setScopeBarButtonTitleTextAttributes(atts, for: .normal)
        
        //alterLayout()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
      
    }
    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//         let webVC = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "web") as! webViewController
//        webVC.url = self.news?[indexPath.item].url
//        self.present(webVC,animated:true,completion:nil)
//    }
//
//}

}
extension UIImageView {
    func downloadedFrom(url: URL, contentMode mode: UIViewContentMode = .scaleAspectFit) {
        contentMode = mode
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async() {
                self.image = image
            }
            }.resume()
    }
    func downloadedFrom(link: String, contentMode mode: UIViewContentMode = .scaleAspectFit) {
        guard let url = URL(string: link) else { return }
        downloadedFrom(url: url, contentMode: mode)
    }
}

