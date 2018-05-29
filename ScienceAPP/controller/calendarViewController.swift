//
//  calendarViewController.swift
//  ScienceAPP
//
//  Created by 张睿 on 10/4/18.
//  Copyright © 2018 张睿. All rights reserved.
//

import UIKit
import PagingMenuController

private struct PagingMenuOptions: PagingMenuControllerCustomizable {
    
    private let viewController1 = ViewController4()
    private let viewController2 = ViewController5()
    private let viewController3 = ViewController5()
    private let viewController4 = ViewController5()
    
    //组件类型
    fileprivate var componentType: ComponentType {
        return .all(menuOptions: MenuOptions(), pagingControllers: pagingControllers)
    }
    
    //所有子视图控制器
    fileprivate var pagingControllers: [UIViewController] {
        return [viewController1, viewController2,viewController3,viewController4]
    }
    
    //菜单配置项
    fileprivate struct MenuOptions: MenuViewCustomizable {
        //菜单显示模式
        var displayMode: MenuDisplayMode {
            return .infinite(widthMode: .flexible, scrollingMode: .pagingEnabled)
        }
        var focusMode: MenuFocusMode = .underline(height: 3, color: .red, horizontalPadding: 0,
                                                  verticalPadding: 5)
        //菜单项
        var itemsOptions: [MenuItemViewCustomizable] {
            return [MenuItem1(), MenuItem2(),MenuItem3(),MenuItem4()]
        }
    }
    
    //第1个菜单项
    fileprivate struct MenuItem1: MenuItemViewCustomizable {
        //自定义菜单项名称
        var displayMode: MenuItemDisplayMode {
            return .text(title: MenuItemText(text: "Deadline",
                                             color: .lightGray, selectedColor: .black,
                                             font:  UIFont(name: "Museo", size: 15)!,
                                             selectedFont: UIFont(name: "Museo", size: 18)!))
        }
    }
    
    //第2个菜单项
    fileprivate struct MenuItem2: MenuItemViewCustomizable {
        //自定义菜单项名称
        var displayMode: MenuItemDisplayMode {
            return .text(title: MenuItemText(text: "Teaching & Learning",
                                             color: .lightGray, selectedColor: .black,
                                             font: UIFont(name: "Museo", size: 15)! ,
                                             selectedFont:  UIFont(name: "Museo", size: 18)!))
        }
    }
    
    
    fileprivate struct MenuItem3: MenuItemViewCustomizable {
        //自定义菜单项名称
        var displayMode: MenuItemDisplayMode {
            return .text(title: MenuItemText(text: "Research",
                                             color: .lightGray, selectedColor: .black,
                                             font:  UIFont(name: "Museo", size: 15)!,
                                             selectedFont: UIFont(name: "Museo", size: 18)!))
        }
    }
    fileprivate struct MenuItem4: MenuItemViewCustomizable {
        //自定义菜单项名称
        var displayMode: MenuItemDisplayMode {
            return .text(title: MenuItemText(text: "General",
                                             color: .lightGray, selectedColor: .black,
                                             font:  UIFont(name: "Museo", size: 15)!,
                                             selectedFont: UIFont(name: "Museo", size: 18)!))
        }
    }
}



class calendarViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.barTintColor =
            UIColor.white
        let image = UIImage(named: "rmit5")
        self.navigationItem.titleView = UIImageView(image: image)
        
        let options = PagingMenuOptions()
        //分页菜单控制器初始化
        let pagingMenuController = PagingMenuController(options: options)
        //分页菜单控制器尺寸设置
        pagingMenuController.view.frame.origin.y += 64
        pagingMenuController.view.frame.size.height -= 64
        
        //建立父子关系
        addChildViewController(pagingMenuController)
        //分页菜单控制器视图添加到当前视图中
        view.addSubview(pagingMenuController.view)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    

 }



