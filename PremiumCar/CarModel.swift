//
//  ChatModel.swift
//  PetBar
//
//  Created by ethen on 16/8/15.
//  Copyright © 2016年 yuan.zhang. All rights reserved.
//

import Foundation

class CarModel: NSObject {
    
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





