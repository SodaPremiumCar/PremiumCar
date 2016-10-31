//
//  UserData.swift
//  PremiumCar
//
//  Created by 赵霆 on 16/10/28.
//  Copyright © 2016年 soda. All rights reserved.
//

import Foundation

class UserData: NSObject {
    
    var mobileNo: String?
    var authToken: String?
    // 单例
    static let share = UserData()
    
    func save() {
        
        UserDefaults.standard.set(mobileNo, forKey: "mobileNo")
        UserDefaults.standard.set(authToken, forKey: "authToken")
        UserDefaults.standard.synchronize()
    }
    
    func load() {
        mobileNo = UserDefaults.standard.string(forKey: "mobileNo")
        mobileNo = UserDefaults.standard.string(forKey: "authToken")
    }
}
