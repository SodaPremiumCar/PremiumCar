//
//  OrderModel.swift
//  PremiumCar
//
//  Created by ethen on 2016/11/7.
//  Copyright © 2016年 soda. All rights reserved.
//

import Foundation

class OrderModel: NSObject {
    
    let orderState = ["已下单", "已完成", "已确认", "取车中", "服务中", "送车中", "", "", "", "已取消"]
    var id: Int?
    var state: String?
    var total: Float?
    var serialNum: String?
    var content: String?
    var contacts: String?
    var booking: String?
    var remark: String?
    
    var services: [[String : AnyObject]]?
    var carType :[CarTModel]?
    
    
    init(dic: [String : AnyObject]) {
        
        super.init()

        id = dic["id"] as? Int
        serialNum = dic["serialNum"] as? String
        content = dic["content"] as? String
        booking = dic["booking"] as? String
        remark = dic["remark"] as? String
        total = dic["total"] as? Float
        
        if let s = dic["state"] as? Int {
            state = orderState[s]
        }
        
        let string = dic["services"] as! String
        let data = string.data(using: String.Encoding.utf8)!
        let json = try! JSONSerialization.jsonObject(with: data, options: [])
        print(json)
        if ((json as? [[String : AnyObject]]) != nil) {
            var array = [[String : AnyObject]]()
            for dic in json as! [[String : AnyObject]] {
                array.append(dic)
            }
            services = array
        }
    }
}












