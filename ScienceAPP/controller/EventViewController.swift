//
//  EventViewController.swift
//  ScienceAPP
//
//  Created by 张睿 on 7/4/18.
//  Copyright © 2018 张睿. All rights reserved.
//

import UIKit

class EventViewController: UIViewController,UICollectionViewDataSource,UICollectionViewDelegate{
  
    var events = [event]()
    @IBOutlet weak var eventcollectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        eventcollectionView.dataSource = self
        eventcollectionView.delegate = self
        self.navigationController?.navigationBar.barTintColor =
            UIColor.white
        let image = UIImage(named: "rmit5")
        self.navigationItem.titleView = UIImageView(image: image)
        fetchEvent()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
   
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return events.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
         let cell = eventcollectionView.dequeueReusableCell(withReuseIdentifier: "eventCell", for:indexPath) as! eventCell
        cell.layer.cornerRadius = 10
        cell.layer.borderWidth = 2
        cell.layer.borderColor = UIColor.white.cgColor
        cell.titleLabel.text = events[indexPath.row].eventTitle
        cell.datelabel.layer.cornerRadius = 8
        cell.datelabel.layer.borderWidth = 1.5
        cell.datelabel.layer.borderColor = UIColor.white.cgColor
        cell.datelabel.text = events[indexPath.row].startDate
         return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let mainStoryboard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let desVC = mainStoryboard.instantiateViewController(withIdentifier: "EventsContentViewController") as! EventsContentViewController
        desVC.events = events[indexPath.row]
        self.navigationController?.pushViewController(desVC, animated: true)
    }
    
    
    func fetchEvent(){
        let urlRequest = URLRequest(url: URL(string:"http://titan.csit.rmit.edu.au/~s3479320/iosApp/event.php")!)
        let task = URLSession.shared.dataTask(with: urlRequest){ (data,response,error) in
            
            if error != nil{
                print("error")
                return
            }
            
            do{
                
                let json = try JSONSerialization.jsonObject(with: data!, options:[]) as! [Any]
                
                for jsonResult in json{
                    
                    let articlesFromJson = jsonResult as! [String:AnyObject]
                    
                    let Event = event(eventTitle:articlesFromJson["title"]! as? String,eventContent:articlesFromJson["content"]! as? String, startDate:articlesFromJson["start_date"]!as? String,creatDate:articlesFromJson["create_date"]! as? String,envenImg:articlesFromJson["image_path"]! as? String)
                    self.events.append(Event)
                    
                }
                
                DispatchQueue.main.async {
                    self.eventcollectionView.reloadData()
                }
            }catch let error{
                print(error)
            }
            
            
        }
        
        task.resume()
    }
    

}
