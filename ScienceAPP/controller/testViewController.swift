

import UIKit

class testViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
   
    var news = [NewArticle]()
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
   
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.news.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = testtableview.dequeueReusableCell(withIdentifier: "test") as! testCell
        cell.labelT.text = self.news[indexPath.item].headline
        cell.labelC.text =  self.news[indexPath.item].descri
        cell.labeltype.text = self.news[indexPath.item].type
        cell.labeldate.text = self.news[indexPath.item].date
       // cell.img.downloadImage(from:(self.news?[indexPath.item].imgUrl)!)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier:"newsegue", sender: self)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? contentViewController{
            
            destination.news =  news[(testtableview.indexPathForSelectedRow?.row)!]
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
        self.navigationController?.navigationBar.barTintColor =
            UIColor.white
        let image = UIImage(named: "rmit5")
        self.navigationItem.titleView = UIImageView(image: image)
        super.viewDidLoad()
        testtableview.dataSource = self
        testtableview.delegate = self
        fetchNews()

   
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

//extension UIImageView{
//
//    func downloadImage(from url:String){
//        let urlRequest = URLRequest(url: URL(string: url)!)
//        let task = URLSession.shared.dataTask(with: urlRequest){ (data,response,error) in
//
//            if error != nil{
//                print(error)
//                return
//            }
//            DispatchQueue.main.async {
//                self.image = UIImage(data: data!)
//            }
//        }
//        task.resume()
//
//    }
//}


