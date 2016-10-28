//
//  CallButlerVC.swift
//  PremiumCar
//
//  Created by 赵霆 on 16/9/13.
//  Copyright © 2016年 soda. All rights reserved.
//

import UIKit

class CallButlerVC: UIViewController {
    
    override func viewDidLoad() {
        
        view.backgroundColor = UIColor.black
        setupUI()
    }
    
    
    fileprivate func setupUI() {
        
        
        let phoneImg = UIImageView(frame: CGRect(x: 50, y: 120, width: 80, height: 80))
        phoneImg.image = UIImage(named: "phone")
        view.addSubview(phoneImg)
        
        let bulterImg = UIImageView(frame: CGRect(x: SCREEN_WIDTH - 130, y: 120, width: 80, height: 80))
        bulterImg.image = UIImage(named: "bulter")
        view.addSubview(bulterImg)
        
        let label = UILabel(frame: CGRect(x: 40, y: phoneImg.frame.maxY + 70, width: 0, height: 0))
        label.font = UIFont.systemFont(ofSize: 18)
        label.textColor = UIColor.white
        label.text = "呼叫管家，提供专属服务"
        label.sizeToFit()
        view.addSubview(label)
        
        let callBtn = UIButton(frame: CGRect(x: 40, y: label.frame.maxY + 5, width: SCREEN_WIDTH - 80, height: 50))
        callBtn.setTitle("Call", for: UIControlState())
        callBtn.backgroundColor = COLOR_BLACK
        callBtn.addTarget(self, action: #selector(buttonClick), for: UIControlEvents.touchUpInside)
        view.addSubview(callBtn)
    }
    
    func buttonClick() {
        
        UIApplication.shared.openURL(URL(string: "telprompt://4000607927")!)
    }
}
