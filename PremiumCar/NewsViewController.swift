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
        
        webView = UIWebView(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: SCREEN_HEIGHT - 64))
        webView?.backgroundColor = COLOR_BLACK
        let request = URLRequest(url: URL(string: "http://www.porsche.com/china?from=baidubrandzone&utm_source=baidu&utm_medium=brandzone&utm_term=title&utm_content=Mobile_Brandzone&utm_campaign=2016_Always_On_Brandzone")!)
        webView?.loadRequest(request as URLRequest)
        view.addSubview(webView!)
    }
}
