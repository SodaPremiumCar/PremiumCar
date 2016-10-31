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
    
    
    init(dict: [String : AnyObject]) {
        
        super.init()
        
        id = dict["id"] as? Int
        brand = dict["brand"] as? String
        series = dict["series"] as? String
        model = dict["model"] as? String
    }
}
