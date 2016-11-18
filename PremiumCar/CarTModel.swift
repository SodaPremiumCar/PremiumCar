//
//  CarTModel.swift
//  PremiumCar
//
//  Created by 赵霆 on 16/10/31.
//  Copyright © 2016年 soda. All rights reserved.
//

import Foundation

class CarTModel: NSObject {
    
    var id: Int?
    var brand: String?
    var series: String?
    var model: String?
    var licenseNum: String?
    
    
    init(dict: [String : AnyObject]) {
        
        super.init()
        
        id = dict["carType"]?["id"] as? Int
        brand = dict["carType"]?["brand"] as? String
        series = dict["carType"]?["series"] as? String
        model = dict["carType"]?["model"] as? String
        licenseNum = dict["licenseNum"] as? String
    }
}
