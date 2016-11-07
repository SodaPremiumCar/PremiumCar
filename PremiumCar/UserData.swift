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
    var name: String?
    var address: String?
    var telephone: String?
    // 单例
    static let share = UserData()
    
    func save() {
        
        UserDefaults.standard.set(mobileNo, forKey: "mobileNo")
        UserDefaults.standard.set(authToken, forKey: "authToken")
        UserDefaults.standard.set(name, forKey: "name")
        UserDefaults.standard.set(address, forKey: "address")
        UserDefaults.standard.set(telephone, forKey: "telephone")
        UserDefaults.standard.synchronize()
    }
    
    func load() {
        mobileNo = UserDefaults.standard.string(forKey: "mobileNo")
        authToken = UserDefaults.standard.string(forKey: "authToken")
        name = UserDefaults.standard.string(forKey: "name")
        address = UserDefaults.standard.string(forKey: "address")
        telephone = UserDefaults.standard.string(forKey: "telephone")
    }
}
