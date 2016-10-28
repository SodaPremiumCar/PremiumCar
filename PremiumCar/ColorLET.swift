//
//  ColorLET.swift
//  IM
//
//  Created by ethen on 16/9/3.
//  Copyright © 2016年 ethan. All rights reserved.
//

import Foundation

let COLOR_BLACK = RGBA(0, g: 0, b: 0, a: 1)
let FUZZY_BACK = RGBA(255, g: 255, b: 255, a: 0.2)

func KURL(_ URL: String) -> String{
    
    return kURLTest(URL)
}

private func kURLTest(_ URL: String) -> String{
    
    return "http://premiumcar.chinacloudapp.cn:8088/server/" + URL
}

let kUrlLogin        = "api/login.c"              //登录
let kUrlDynamicPws   = "api/getDynamicPws.c"      //验证码
let kUrlRegister     = "api/register.c"           //注册
let kUrlPersonalInfo = "api/updateUserInfo.c"     //个人信息








