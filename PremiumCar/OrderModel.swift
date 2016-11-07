//
//  OrderModel.swift
//  PremiumCar
//
//  Created by ethen on 2016/11/7.
//  Copyright © 2016年 soda. All rights reserved.
//

import Foundation
import SwiftyJSON

class OrderModel: NSObject {
    
    var id: Int?
    var state: String?
    var total: Float?
    var serialNum: String?
    var content: String?
    var contacts: String?
    var booking: String?
    var remark: String?
    
    var services: [ServiceItemModel]?
    var carType :[CarTModel]?
    
    
    init(dic: [String : AnyObject]) {
        
        super.init()

        id = dic["id"] as? Int
        serialNum = dic["serialNum"] as? String
        content = dic["content"] as? String
        booking = dic["booking"] as? String
        remark = dic["remark"] as? String
        total = dic["total"] as? Float
        let s = dic["state"] as? Int
        //(state: 0 待处理，1 已受理， 2 已完成)
        if s == 0 {
            state = "待处理"
        }else if s == 1 {
            state = "已受理"
        }else if s == 2 {
            state = "已完成"
        }
    }
}












