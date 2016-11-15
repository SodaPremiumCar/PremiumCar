//
//  NewsViewController.swift
//  PremiumCar
//
//  Created by 赵霆 on 16/11/15.
//  Copyright © 2016年 soda. All rights reserved.
//

import Foundation

class NewsViewController: UIViewController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    private func setupUI() {
        
        title = "推荐"
        view.backgroundColor = COLOR_BLACK
    }
    
}
