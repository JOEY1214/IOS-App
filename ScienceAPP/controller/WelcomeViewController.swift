//
//  WelcomeViewController.swift
//  ScienceAPP
//
//  Created by 张睿 on 6/6/18.
//  Copyright © 2018 张睿. All rights reserved.
//

import UIKit
import paper_onboarding

class WelcomeViewController: UIViewController,PaperOnboardingDataSource,PaperOnboardingDelegate{

    @IBOutlet weak var onboardingvView: PaperOnboarding!
   
    @IBOutlet weak var startbutton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        startbutton.layer.borderWidth = 2
        startbutton.layer.borderColor = UIColor.white.cgColor
        startbutton.layer.cornerRadius = startbutton.frame.height/2
        startbutton.clipsToBounds = true
        onboardingvView.dataSource = self
        onboardingvView.delegate = self
    }

    func onboardingItem(at index: Int) -> OnboardingItemInfo {
        let backgroundcolorOne = UIColor(red: 230/255, green: 0/255, blue: 0/255, alpha: 1)
        let backgroundcolorTwo = UIColor(red: 0/255, green: 120/255, blue: 255/255, alpha: 1)
        let backgroundcolorThree = UIColor(red: 0/255, green: 220/255, blue: 180/255, alpha: 1)
        let backgroundcolorFour = UIColor(red: 250/255, green: 200/255, blue: 0/255, alpha: 1)
        let titleFont = UIFont(name: "Museo", size: 30)
        let desc = UIFont(name: "Museo", size: 16)
        
        return [
            OnboardingItemInfo(informationImage:UIImage(named: "33")!,
                               title: "Science App News",
                               description: "You can scan rencently shcool news on the app",
                             pageIcon: UIImage(named: "6")!,
                               color: backgroundcolorOne,
                               titleColor: UIColor.white,
                               descriptionColor: UIColor.white,
                               titleFont:titleFont! ,
                               descriptionFont:desc!),
            
            OnboardingItemInfo(informationImage:UIImage(named: "11")!,
                               title: "Science App Events",
                               description: "You could check recently school events details and start date", pageIcon: UIImage(named: "6")!,
                               color: backgroundcolorTwo,
                               titleColor: UIColor.white,
                               descriptionColor: UIColor.white,
                               titleFont: titleFont!,
                               descriptionFont: desc!),
            
            OnboardingItemInfo(informationImage:UIImage(named: "22")!,
                               title: "Science App Deadline",
                               description: "You could creat some works due date of your own on the app",
                               pageIcon:UIImage(named: "6")!,
                               color: backgroundcolorThree,
                               titleColor: UIColor.white,
                               descriptionColor: UIColor.white,
                               titleFont: titleFont!,
                               descriptionFont: desc!),
            OnboardingItemInfo(informationImage:UIImage(named: "8")!,
                               title: "Science App Contact",
                               description: "You can find the staff of school of science and their contact detials",
                               pageIcon: UIImage(named: "6")!,
                               color: backgroundcolorFour,
                               titleColor: UIColor.white,
                               descriptionColor: UIColor.white,
                               titleFont:titleFont! ,
                               descriptionFont:desc!),
            ][index]
    }
    
    func onboardingItemsCount() -> Int {
        return 4
    }
    
//    func onboardingConfigurationItem(_: OnboardingContentViewItem, index _: Int) {
//
//    }
//    func onboardingWillTransitonToIndex(_index: Int) {
//        if _index == 1{
//            if self.startbutton.alpha == 1{
//                UIView.animate(withDuration: 0.2, animations: {self.startbutton.alpha = 0})
//            }
//        }
//    }
//    func onboardingDidTransitonToIndex(_index: Int) {
//        if _index == 2 {
//            UIView.animate(withDuration: 0.4, animations: {self.startbutton.alpha = 1})
//
//        }
//    }
}


