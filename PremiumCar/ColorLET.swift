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
let SEC_ORANGE = RGBA(252, g: 130, b: 9, a: 1)

func KURL(_ URL: String) -> String{
    
    return kURLTest(URL)
}

private func kURLTest(_ URL: String) -> String{
    
    return "http://premiumcar.chinacloudapp.cn:8088/server/" + URL
}

let kUrlLogin        = "openapi/login.c"                //登录
let kUrlDynamicPws   = "openapi/getDynamicPws.c"        //验证码
let kUrlRegister     = "openapi/register.c"             //注册
let kUrlUserDynamic  = "openapi/getDynamicPwsForUser.c" //已注册用户获取验证码
let kUrlUserReset    = "openapi/resetPwd.c"             //重设密码
let kUrlPersonalInfo = "api/updateUserInfo.c"           //个人信息
let kUrlGetUserInfo  = "api/getUserInfo.c"              //获取用户信息
let kUrlCarBrands    = "openapi/getCarTypeList.c"       //车型列表
let kUrlServiceList  = "openapi/getServiceList.c"       //获取服务信息
let kUrlAddCar       = "api/addCar.c"                   //注册车辆
let kUrlGetCar       = "api/getCarList.c"               //获取车辆
let kUrlDeleteCar    = "api/deleteCar.c"                //删除车辆
let kUrlCreateOrder  = "api/createOrder.c"              //创建订单
let kUrlGetOrderList = "api/getOrderList.c"             //获取订单列表
let kUrlGetOrderDetail = "api/getOrderById.c"             //获取订单详情
let kUrlFeedBack     = "api/addFeedback.c"              //意见反馈






