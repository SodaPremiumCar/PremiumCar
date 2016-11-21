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
                    SVProgressHUD.showError(withStatus: "网络异常")
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
//                    SVProgressHUD.showSuccess(withStatus: "登录成功")
                    finished(true)
                }
        }
    }
    
    // 获取验证码
    func getVerificationCode(isForget: Bool, mobileNo: String, finished:@escaping (_ results: Bool) -> ()) {
        
        let params: Parameters = ["mobileNo" : mobileNo]
        var url = ""
        if isForget {
            url = KURL(kUrlUserDynamic)
        }else{
            url = KURL(kUrlDynamicPws)
        }
        Alamofire
            .request(url, method: .post, parameters: params, encoding: JSONEncoding.default)
            .responseJSON { (response) in
                
                guard response.result.isSuccess else {
                    SVProgressHUD.showError(withStatus: "网络异常")
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
    
    // 注册&修改
    func register(isForget: Bool, mobileNo: String, dynamicPws: String, pwd: String, finished:@escaping (_ results: Bool) -> ()) {
        
        let params: Parameters = ["mobileNo" : mobileNo,
                                  "dynamicPws": dynamicPws,
                                  "pwd" : pwd]
        var url = ""
        if isForget {
            url = KURL(kUrlUserReset)
        }else{
            url = KURL(kUrlRegister)
        }

        Alamofire
            .request(url, method: .post, parameters: params, encoding: JSONEncoding.default)
            .responseJSON { (response) in
                
                guard response.result.isSuccess else {
                    SVProgressHUD.showError(withStatus: "网络异常")
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
                    if isForget {
                        SVProgressHUD.showSuccess(withStatus: "修改成功")
                    }
                    finished(true)
                }
        }
    }
    
    // 更改个人信息
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
                    SVProgressHUD.showError(withStatus: "网络异常")
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
                    UserData.share.telephone = telephone
                    UserData.share.save()
//                    SVProgressHUD.showSuccess(withStatus: "修改成功")
                    finished(true)
                }
        }
    }
    
    //获取个人信息
    func getUserInfo(finished:@escaping (_ results: Bool) -> ()) {
        
        UserData.share.load()
        let params: Parameters = ["authToken": UserData.share.authToken! as String,
                                  "mobileNo" : UserData.share.mobileNo! as String]
        
        Alamofire
            .request(KURL(kUrlGetUserInfo), method: .post, parameters: params, encoding: JSONEncoding.default)
            .responseJSON { (response) in
                
                guard response.result.isSuccess else {
                    SVProgressHUD.showError(withStatus: "网络异常")
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
                    UserData.share.name = dict["user"]["name"].stringValue
                    UserData.share.address = dict["user"]["addr"].stringValue
                    UserData.share.telephone = dict["user"]["telephone"].stringValue
                    UserData.share.save()
                    finished(true)
                }
        }
    }
    
    // 车型信息
    func carBrandsList(finished:@escaping (_ brandArray: [AnyObject], _ carBigArray: [[CarModel]]) -> ()) {
        
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
                    
                    guard code == 10000 else {
                        SVProgressHUD.showInfo(withStatus: message)
                        return
                    }
                    //  字典转成模型
                    let brandArray = dict["carTypes"]["brands"].arrayObject
                    
                    var carBigArray = [[CarModel]]()
                    for key in brandArray! {
                        
                        let keyStr = key as! String
                        if let items = dict["carTypes"]["brandCarTypes"][keyStr].arrayObject {
                            
                            var carItems = [CarModel]()
                            for item in items {
                                let carItem = CarModel(dict: item as! [String: AnyObject])
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
    func addCar(carTypeId: Int, licenseNum: String, finished:@escaping (_ results: Bool) -> ()) {
        
        UserData.share.load()
        let params: Parameters = ["authToken": UserData.share.authToken! as String,
                                  "mobileNo" : UserData.share.mobileNo! as String,
                                  "carTypeId" : carTypeId,
                                  "licenseNum": licenseNum]
        
        Alamofire
            .request(KURL(kUrlAddCar), method: .post, parameters: params, encoding: JSONEncoding.default)
            .responseJSON { (response) in
                
                guard response.result.isSuccess else {
                    SVProgressHUD.showError(withStatus: "网络异常")
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
                    
                    finished(true)
                }
        }
    }
    
    // 获取车辆列表
    func getCar(finished:@escaping (_ CarItems: [CarTModel], _ idArray: [Int], _ orderItems: [OrderModel]) -> ()) {
        
        UserData.share.load()
        let params: Parameters = ["authToken": UserData.share.authToken! as String,
                                  "mobileNo" : UserData.share.mobileNo! as String]

        Alamofire
            .request(KURL(kUrlGetCar), method: .post, parameters: params, encoding: JSONEncoding.default)
            .responseJSON { (response) in
                
                guard response.result.isSuccess else {
                    SVProgressHUD.showError(withStatus: "网络异常")
                    return
                }
                if let value = response.result.value {
                    
                    let dict = JSON(value)
                    let code = dict["result"].intValue
                    let message = dict["errMsg"].stringValue
                    guard code == 10000 else {

                        SVProgressHUD.showInfo(withStatus: message)
                        return
                    }
                    print("zzzzzz", dict)
                    //  字典转成模型
                    if let items = dict["carList"].arrayObject {
                        var carItems = [CarTModel]()
                        var idArray = [Int]()
                        var orderItems = [OrderModel]()
                        for item in items {
                           
                            let itemT = item as! [String: AnyObject]
                            let carItem = CarTModel(dict: itemT)
                            // 车的服务状态
                            if let orderData = itemT["openingOrder"] as? [String : AnyObject]{
                                let orderItem = OrderModel(dic: orderData)
                                orderItems.append(orderItem)
                            }else{
                                let orderItem = OrderModel(dic: [:])
                                orderItems.append(orderItem)
                            }
                            
                            carItems.append(carItem)
                            idArray.append(itemT["id"] as! Int)
                        }
                        
                        finished(carItems, idArray, orderItems)
                    }
                }
        }
    }
    
    //删除车辆
    func deleteCar(id: String, finished:@escaping (_ results: Bool) -> ()) {
        
        UserData.share.load()
        let params: Parameters = ["authToken": UserData.share.authToken! as String,
                                  "mobileNo" : UserData.share.mobileNo! as String,
                                  "id" : id]
        
        Alamofire
            .request(KURL(kUrlDeleteCar), method: .post, parameters: params, encoding: JSONEncoding.default)
            .responseJSON { (response) in
                
                guard response.result.isSuccess else {
                    SVProgressHUD.showError(withStatus: "网络异常")
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
                    finished(true)
                }
        }
    }

    //服务项目
    func serviceList(carTypeId: Int, finished:@escaping (_ typeArray: [AnyObject], _ serviceBigArray: [[ServiceItemModel]]) -> ()) {
        
        let params: Parameters = ["carTypeId" : carTypeId]
        Alamofire
            .request(KURL(kUrlServiceList), method: .post, parameters: params, encoding: JSONEncoding.default)
            .responseJSON { (response) in
                
                guard response.result.isSuccess else {
                    SVProgressHUD.showError(withStatus: "网络异常")
                    return
                }
                if let value = response.result.value {
                    
                    let dict = JSON(value)
                    let code = dict["result"].intValue
                    let message = dict["errMsg"].stringValue
                    guard code == 10000 else {
                        SVProgressHUD.showInfo(withStatus: message)
                        return
                    }
                    //  字典转成模型
                    let typeArray = dict["services"]["types"].arrayObject
                    
                    var serviceBigArray = [[ServiceItemModel]]()
                    for key in typeArray! {
                        
                        let keyStr = key as! String
                        if let items = dict["services"]["typeServices"][keyStr].arrayObject {
                            
                            var serviceItems = [ServiceItemModel]()
                            for item in items {
                                let carItem = ServiceItemModel(dic: item as! [String : AnyObject])
                                serviceItems.append(carItem)
                            }
                            serviceBigArray.append(serviceItems)
                        }
                    }
                    finished(typeArray as! [AnyObject], serviceBigArray)
                }
        }
    }
    
    //提交订单
    func createOrder(content: String, services: [AnyObject]!, contacts: [String : String]!, total: String, remark: String, carId: String!, carTypeId: String!, booking: String!,  finished:@escaping (_ results: Bool) -> ()) {
        
        UserData.share.load()
        let params: Parameters = ["authToken": UserData.share.authToken! as String,
                                  "mobileNo" : UserData.share.mobileNo! as String,
                                  "content" : content,
                                  "services" : objectToJsonstring(obj: services as AnyObject),
                                  "contacts" : objectToJsonstring(obj: contacts as AnyObject),
                                  "total" : total,
                                  "remark" : remark,
                                  "carId" : carId,
                                  "carTypeId" : carTypeId,
                                  "booking" : booking]
        
        Alamofire
            .request(KURL(kUrlCreateOrder), method: .post, parameters: params, encoding: JSONEncoding.default)
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
                    
                    finished(true)
                }
        }
    }
    
    //获取订单列表
    func orderList(finished:@escaping (_ results: Bool, _ data: [OrderModel]?) -> ()) {
        
        UserData.share.load()
        let params: Parameters = ["authToken": UserData.share.authToken! as String,
                                  "mobileNo" : UserData.share.mobileNo! as String]
        Alamofire
            .request(KURL(kUrlGetOrderList), method: .post, parameters: params, encoding: JSONEncoding.default)
            .responseJSON { (response) in
                
                guard response.result.isSuccess else {
                    SVProgressHUD.showError(withStatus: "网络异常")
                    return
                }
                if let value = response.result.value {
                    
                    let dict = JSON(value)
                    let code = dict["result"].intValue
                    let message = dict["errMsg"].stringValue
                    guard code == 10000 else {
                        SVProgressHUD.showInfo(withStatus: message)
                        return
                    }
                    
                    if let items = dict["orderList"].arrayObject {
                        var orderItems = [OrderModel]()
                        for item in items {
                            let dic = item as! [String : AnyObject]
                            let model = OrderModel(dic: dic)
                            orderItems.append(model)
                        }
                        finished(true, orderItems)
                    }
                }
        }
    }
    
    //获取订单详情
    func orderDetail(orderId: String!, finished:@escaping (_ results: Bool, _ data: OrderModel?) -> ()) {
        
        UserData.share.load()
        let params: Parameters = ["authToken": UserData.share.authToken! as String,
                                  "mobileNo" : UserData.share.mobileNo! as String,
                                  "id" : orderId]
        Alamofire
            .request(KURL(kUrlGetOrderDetail), method: .post, parameters: params, encoding: JSONEncoding.default)
            .responseJSON { (response) in
                
                guard response.result.isSuccess else {
                    SVProgressHUD.showError(withStatus: "网络异常")
                    return
                }
                if let value = response.result.value {
                    
                    let dict = JSON(value)
                    let code = dict["result"].intValue
                    let message = dict["errMsg"].stringValue
                    guard code == 10000 else {
                        SVProgressHUD.showInfo(withStatus: message)
                        return
                    }
                    print(dict)
                    if let dic = dict["order"].dictionaryObject {
                        let model = OrderModel(dic: dic as [String : AnyObject])
                        finished(true, model)
                    }
                }
        }
    }
    
    //获取订单详情
    func finishOrder(orderId: String!, finished:@escaping (_ results: Bool) -> ()) {
        
        UserData.share.load()
        let params: Parameters = ["authToken": UserData.share.authToken! as String,
                                  "mobileNo" : UserData.share.mobileNo! as String,
                                  "id" : orderId]
        Alamofire
            .request(KURL(kUrlFinishOrder), method: .post, parameters: params, encoding: JSONEncoding.default)
            .responseJSON { (response) in
                
                guard response.result.isSuccess else {
                    SVProgressHUD.showError(withStatus: "网络异常")
                    return
                }
                if let value = response.result.value {
                    
                    let dict = JSON(value)
                    let code = dict["result"].intValue
                    let message = dict["errMsg"].stringValue
                    guard code == 10000 else {
                        SVProgressHUD.showInfo(withStatus: message)
                        return
                    }
                    print(dict)
                    finished(true)
                }
        }
    }
    
    //Dictionary或Array转JSON串
    func objectToJsonstring(obj: AnyObject) -> String{
        
        let paramsJSON = JSON(obj)
        let paramsString = paramsJSON.rawString(String.Encoding.utf8, options: .prettyPrinted)
        return (paramsString != nil) ? paramsString! : ""
    }
    
    // 意见反馈
    func feedBack (content: String, finished:@escaping (_ results: Bool) -> ()) {
        
        UserData.share.load()
        let params: Parameters = ["authToken": UserData.share.authToken! as String,
                                  "mobileNo" : UserData.share.mobileNo! as String,
                                  "content" : content]

        Alamofire
            .request(KURL(kUrlFeedBack), method: .post, parameters: params, encoding: JSONEncoding.default)
            .responseJSON { (response) in
                
                guard response.result.isSuccess else {
                    SVProgressHUD.showError(withStatus: "网络异常")
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
                    SVProgressHUD.showSuccess(withStatus: "提交成功")
                    finished(true)
                }
        }
    }
    
    //用获取个人信息接口检查登录
    func checkLoginStatus(finished:@escaping (_ results: Bool) -> ()) {
        
        UserData.share.load()
        let params: Parameters = ["authToken": UserData.share.authToken! as String,
                                  "mobileNo" : UserData.share.mobileNo! as String]
        
        Alamofire
            .request(KURL(kUrlGetUserInfo), method: .post, parameters: params, encoding: JSONEncoding.default)
            .responseJSON { (response) in
                
                guard response.result.isSuccess else {
                    SVProgressHUD.showError(withStatus: "网络异常")
                    return
                }
                if let value = response.result.value {
                    
                    let dict = JSON(value)
                    let code = dict["result"].intValue
                    let message = dict["errMsg"].stringValue
                    
                    if code == 10000 {
                        finished(true)
                        return
                    }else if code == 12000{
                        finished(false)
                    }else{
                        SVProgressHUD.showInfo(withStatus: message)
                        return
                    }
                }
        }
    }
}
