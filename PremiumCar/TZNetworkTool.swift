//
//  TZNetworkTool.swift
//  JoyMove
//
//  Created by 赵霆 on 16/8/18.
//  Copyright © 2016年 ting.zhao. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON
import SVProgressHUD

class TZNetworkTool: NSObject {
    // 单例
    static let shareNetworkTool = TZNetworkTool()
    
    // 登录
    func login(mobileNo: String, pwd: String, finished:@escaping (_ results: Bool) -> ()) {
        
        let params: Parameters = ["mobileNo" : mobileNo,
                                  "pwd" : pwd]
        
        Alamofire
            .request(KURL(kUrlLogin), method: .post, parameters: params, encoding: JSONEncoding.default)
            .responseJSON { (response) in
                
                guard response.result.isSuccess else {
                    SVProgressHUD.showError(withStatus: "登录失败")
                    return
                }
                if let value = response.result.value {
                    
                    let dict = JSON(value)
                    let authToken = dict["authToken"].stringValue
                    let code = dict["result"].intValue
                    let message = dict["errMsg"].stringValue

                    guard code == 10000 else {
                        SVProgressHUD.showInfo(withStatus: message)
                        finished(false)
                        return
                    }
                    
                    UserData.share.mobileNo = mobileNo
                    UserData.share.authToken = authToken
                    UserData.share.save()
                    SVProgressHUD.showSuccess(withStatus: "登录成功")
                    finished(true)
                }
        }
    }
    
    // 获取验证码
    func getVerificationCode(mobileNo: String, finished:@escaping (_ results: Bool) -> ()) {
        
        let params: Parameters = ["mobileNo" : mobileNo]
        
        Alamofire
            .request(KURL(kUrlDynamicPws), method: .post, parameters: params, encoding: JSONEncoding.default)
            .responseJSON { (response) in
                
                guard response.result.isSuccess else {
                    SVProgressHUD.showError(withStatus: "发送失败")
                    return
                }
                if let value = response.result.value {
                    
                    let dict = JSON(value)
                    let code = dict["result"].intValue
                    let message = dict["errMsg"].stringValue
                    
                    guard code == 10000 else {
                        SVProgressHUD.showInfo(withStatus: message)
                        finished(false)
                        return
                    }
                    SVProgressHUD.showSuccess(withStatus: "验证码已发送")
                    finished(true)
                    
                }
        }
    }
    
    // 注册
    func register(mobileNo: String, dynamicPws: String, pwd: String, finished:@escaping (_ results: Bool) -> ()) {
        
        let params: Parameters = ["mobileNo" : mobileNo,
                                  "dynamicPws": dynamicPws,
                                  "pwd" : pwd]
        
        Alamofire
            .request(KURL(kUrlRegister), method: .post, parameters: params, encoding: JSONEncoding.default)
            .responseJSON { (response) in
                
                guard response.result.isSuccess else {
                    SVProgressHUD.showError(withStatus: "注册失败")
                    return
                }
                if let value = response.result.value {
                    
                    let dict = JSON(value)
                    let code = dict["result"].intValue
                    let message = dict["errMsg"].stringValue
                    
                    guard code == 10000 else {
                        SVProgressHUD.showInfo(withStatus: message)
                        finished(false)
                        return
                    }
                    
                    SVProgressHUD.showSuccess(withStatus: "注册成功")
                    finished(true)
                }
        }
    }
    
    // 个人信息
    func personalInfo(telephone: String, name: String, addr: String, finished:@escaping (_ results: Bool) -> ()) {
       
        UserData.share.load()
        let params: Parameters = ["authToken": UserData.share.authToken! as String,
                                  "mobileNo" : UserData.share.mobileNo! as String,
                                  "telephone": telephone,
                                  "name" : name,
                                  "addr" : addr]

        Alamofire
            .request(KURL(kUrlPersonalInfo), method: .post, parameters: params, encoding: JSONEncoding.default)
            .responseJSON { (response) in
                
                guard response.result.isSuccess else {
                    SVProgressHUD.showError(withStatus: "提交失败")
                    return
                }
                if let value = response.result.value {
                    
                    let dict = JSON(value)
                    let code = dict["result"].intValue
                    let message = dict["errMsg"].stringValue
                    
                    guard code == 10000 else {
                        SVProgressHUD.showInfo(withStatus: message)
                        finished(false)
                        return
                    }
                    // 存储个人信息
                    UserData.share.name = name
                    UserData.share.address = addr
                    UserData.share.save()
                    SVProgressHUD.showSuccess(withStatus: "提交成功")
                    finished(true)
                }
        }
    }
    
    // 车型信息
    func carBrandsList(finished:@escaping (_ brandArray: [AnyObject], _ carBigArray: [[CarTModel]]) -> ()) {
        
        Alamofire
            .request(KURL(kUrlCarBrands), method: .post, parameters: [ : ], encoding: JSONEncoding.default)
            .responseJSON { (response) in
                
                guard response.result.isSuccess else {
                    SVProgressHUD.showError(withStatus: "网络异常")
                    return
                }
                if let value = response.result.value {
                    
                    let dict = JSON(value)
                    let code = dict["result"].intValue
                    let message = dict["errMsg"].stringValue
                    
                    print("qqqqqqqq", dict)
                    guard code == 10000 else {
                        SVProgressHUD.showInfo(withStatus: message)
                        return
                    }
                    //  字典转成模型
                    let brandArray = dict["carTypes"]["brands"].arrayObject                    
                    
                    var carBigArray = [[CarTModel]]()
                    for key in brandArray! {
                        
                        let keyStr = key as! String
                        if let items = dict["carTypes"]["brandCarTypes"][keyStr].arrayObject {
                            
                            var carItems = [CarTModel]()
                            for item in items {
                                let carItem = CarTModel(dict: item as! [String: AnyObject])
                                carItems.append(carItem)
                            }
                            carBigArray.append(carItems)
                        }
                    }
                    finished(brandArray as! [AnyObject], carBigArray)
                }
        }
    }
    
    // 注册车辆信息
    func addCar(carTypeId: Int, finished:@escaping (_ results: Bool) -> ()) {
        
        UserData.share.load()
        let params: Parameters = ["authToken": UserData.share.authToken! as String,
                                  "mobileNo" : UserData.share.mobileNo! as String,
                                  "carTypeId" : carTypeId]
        
        Alamofire
            .request(KURL(kUrlAddCar), method: .post, parameters: params, encoding: JSONEncoding.default)
            .responseJSON { (response) in
                
                guard response.result.isSuccess else {
                    SVProgressHUD.showError(withStatus: "添加失败")
                    return
                }
                if let value = response.result.value {
                    
                    let dict = JSON(value)
                    let code = dict["result"].intValue
                    let message = dict["errMsg"].stringValue
                    
                    guard code == 10000 else {
                        SVProgressHUD.showInfo(withStatus: message)
                        finished(false)
                        return
                    }
                    
                    SVProgressHUD.showSuccess(withStatus: "添加成功")
                    finished(true)
                }
        }
    }

    // 获取车辆列表
    func getCar(finished:@escaping (_ CarItems: [CarTModel]) -> ()) {
        
        UserData.share.load()
        let params: Parameters = ["authToken": UserData.share.authToken! as String,
                                  "mobileNo" : UserData.share.mobileNo! as String]
        print("1111111" , params)
        Alamofire
            .request(KURL(kUrlGetCar), method: .post, parameters: params, encoding: JSONEncoding.default)
            .responseJSON { (response) in
                
                guard response.result.isSuccess else {
                    SVProgressHUD.showError(withStatus: "获取失败")
                    return
                }
                if let value = response.result.value {
                    
                    let dict = JSON(value)
                    let code = dict["result"].intValue
                    let message = dict["errMsg"].stringValue
                    print(dict)
                    guard code == 10000 else {
                        SVProgressHUD.showInfo(withStatus: message)
                        return
                    }
                    
                    //  字典转成模型
                    if let items = dict["carType"].arrayObject {
                        var carItems = [CarTModel]()
                        for item in items {
                            let carItem = CarTModel(dict: item as! [String: AnyObject])
                            carItems.append(carItem)
                        }
                        
                        finished(carItems)
                    }
                    
                }
        }
    }
    
    
    
    
}
