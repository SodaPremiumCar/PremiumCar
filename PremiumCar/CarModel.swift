//
//  ChatModel.swift
//  PetBar
//
//  Created by ethen on 16/8/15.
//  Copyright © 2016年 yuan.zhang. All rights reserved.
//

import Foundation

class CarModel: NSObject {
    
    var url: String?
    var name: String?
    var numbel: String?
    var maintenance: String?
    var insurance: String?
    
    
    init(dic: [String : AnyObject]) {
        
        super.init()

        url = dic["url"] as? String
        name = dic["name"] as? String
        numbel = dic["numbel"] as? String
        maintenance = dic["maintenance"] as? String
        insurance = dic["insurance"] as? String
    }
}





