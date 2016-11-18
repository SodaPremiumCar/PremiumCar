//
//  NewsViewController.swift
//  PremiumCar
//
//  Created by 赵霆 on 16/11/15.
//  Copyright © 2016年 soda. All rights reserved.
//

import Foundation

class NewsViewController: UIViewController {
    
    var webView: UIWebView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    private func setupUI() {
        
        title = "推荐"
        view.backgroundColor = COLOR_BLACK
        
        webView = UIWebView(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: SCREEN_HEIGHT - 64 - 49))
        webView?.backgroundColor = COLOR_BLACK
        let request = URLRequest(url: URL(string: "http://m.autohome.com.cn/news/#pvareaid=104791")!)
        webView?.loadRequest(request as URLRequest)
        view.addSubview(webView!)
    }
}
