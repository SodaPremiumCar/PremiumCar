//
//  ServiceItemModel.swift
//  PremiumCar
//
//  Created by ethen on 2016/10/31.
//  Copyright © 2016年 soda. All rights reserved.
//

import Foundation

class ServiceItemModel: NSObject {
    var price: Float?
    var id: Int?
    var type: String?
    var name: String?
    var item: String?
    var isSelected: Bool = false
    
    
    init(dic: [String : AnyObject]) {
        super.init()
        price = dic["price"] as? Float
        id = dic["id"] as? Int
        type = dic["type"] as? String
        name = dic["name"] as? String
        item = dic["item"] as? String
    }
}





