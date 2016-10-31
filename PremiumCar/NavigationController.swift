//
//  NavigationController.swift
//  PremiumCar
//
//  Created by ethen on 2016/10/28.
//  Copyright © 2016年 soda. All rights reserved.
//

import Foundation

extension UINavigationController {
    
    func setStyle(color: UIColor) {
        
        //        self.navigationController?.navigationBar.barTintColor = COLOR_GREEN
        self.navigationBar.tintColor = UIColor.white
        self.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName : UIColor.white, NSFontAttributeName : UIFont.boldSystemFont(ofSize: 18)]
        
        self.navigationBar.setBackgroundImage(imageWithColor(color), for: UIBarPosition.any, barMetrics: UIBarMetrics.default)
        self.navigationBar.shadowImage = UIImage()
    }
    
    
    
    
    
}




