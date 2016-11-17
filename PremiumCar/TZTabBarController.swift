//
//  TZTabBarController.swift
//  PremiumCar
//
//  Created by 赵霆 on 16/11/15.
//  Copyright © 2016年 soda. All rights reserved.
//

import Foundation

class TZTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tabBar.barTintColor = RGBA(38, g: 38, b: 38, a: 1)
        tabBar.tintColor = SEC_ORANGE
        // 添加子控制器
        addChildViewControllers()
    }
    
    /**
     # 添加子控制器
     */
    private func addChildViewControllers() {
        addChildViewController(childControllerName: "ViewController", title: "服务", imageName: "tabBar_main_")
        addChildViewController(childControllerName: "NewsViewController", title: "推荐", imageName: "tabBar_news_")
        addChildViewController(childControllerName: "MineViewController", title: "我的", imageName: "tabBar_mine_")
    }
    /**
     # 初始化子控制器
     
     - parameter childControllerName: 需要初始化的控制器
     - parameter title:               标题
     - parameter imageName:           图片名称
     */
    private func addChildViewController(childControllerName: String, title: String, imageName: String) {
        // 动态获取命名空间
        let ns = Bundle.main.infoDictionary!["CFBundleExecutable"] as! String
        // 将字符串转化为类，默认情况下命名空间就是项目名称，但是命名空间可以修改
        let cls: AnyClass? = NSClassFromString(ns + "." + childControllerName)
        let vcClass = cls as! UIViewController.Type
        let vc = vcClass.init()
        // 设置对应的数据
        vc.tabBarItem.image = UIImage(named: imageName)
        vc.tabBarItem.selectedImage = UIImage(named: imageName + "selected")
        vc.title = title
        // 给每个控制器包装一个导航控制器

        let nav = TZNavigationController()
        nav.addChildViewController(vc)
        addChildViewController(nav)
    }
    
}
