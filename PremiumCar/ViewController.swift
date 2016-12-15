//
//  ViewController.swift
//  PremiumCar
//
//  Created by ethen on 16/9/5.
//  Copyright © 2016年 soda. All rights reserved.
//  FUCKING GOOD

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var carListTableView: UITableView!
    var carItems = [CarTModel]()
    var orderItems = [OrderModel]()
    var idArray = [Int]()
    var nameLabel: UILabel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        title = "服务"
        navigationController?.isNavigationBarHidden = false
        
        if checkLoginStatus() {
            
            let loginVC = LoginViewController()
            self.navigationController?.pushViewController(loginVC, animated: false)
        }else {
            // 网络监察登录状态
            TZNetworkTool.shareNetworkTool.checkLoginStatus(finished: { (isSuccess) in
                if !isSuccess {
                    let loginVC = LoginViewController()
                    self.navigationController?.pushViewController(loginVC, animated: false)
                }
            })
            
            TZNetworkTool.shareNetworkTool.getCar(finished: { (carItems, idArray, orderItems) in
                self.carItems = carItems
                self.idArray = idArray
                self.orderItems = orderItems
                self.carListTableView.reloadData()
            })
            // 加载个人信息
            TZNetworkTool.shareNetworkTool.getUserInfo(finished: { (isSuccess) in
                
            })
        }
    }
    
    //MARK: UI
    fileprivate func setupUI() {
        
        self.view.backgroundColor = COLOR_BLACK
        
        let img = UIImage(named: "VCBackground")
        let imgView = UIImageView(frame: self.view.bounds)
        imgView.contentMode = .scaleAspectFill
        imgView.image = img
        
        carListTableView = UITableView(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: SCREEN_HEIGHT - 64), style: .plain)
        carListTableView.backgroundColor = UIColor.clear
        carListTableView.delegate = self
        carListTableView.dataSource = self
        carListTableView.separatorStyle = UITableViewCellSeparatorStyle.none
//        carListTableView.register(CarListCell.self, forCellReuseIdentifier: "CarListCellIdentifier")
        view.addSubview(carListTableView)

    }
    
    //MARK: TableViewDelegate
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if carItems.count > 0 {
            return carItems.count
        }else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return CarListCell.height()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let orderModel = orderItems[indexPath.row]
        // 两种Cell
        if orderModel.state == nil {
            
            var cell = tableView.dequeueReusableCell(withIdentifier: "defaultCell") as? CarListCell
            if cell == nil {
                cell = CarListCell(style: UITableViewCellStyle.default, reuseIdentifier:"defaultCell")
                cell?.backgroundColor = COLOR_BLACK
                
                cell?.selectedBackgroundView = UIView(frame: (cell?.frame)!)
                cell?.selectedBackgroundView?.backgroundColor = FUZZY_BACK
                cell?.accessoryType = .disclosureIndicator
            }
            
            let model: CarTModel = carItems[(indexPath as NSIndexPath).row]
            cell?.update(model)
            return cell!
        }else{
            
            var cell = tableView.dequeueReusableCell(withIdentifier: "stateCell") as? CarListCell
            if cell == nil {
                cell = CarListCell(style: UITableViewCellStyle.default, reuseIdentifier:"stateCell")
                cell?.backgroundColor = COLOR_BLACK
              
                cell?.accessoryType = .none
                cell?.selectionStyle = .none
            }
            
            let model: CarTModel = carItems[(indexPath as NSIndexPath).row]
            cell?.update(model)
            cell?.stateSource = orderModel
            return cell!
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let orderModel = orderItems[indexPath.row]
        if (orderModel.state == nil) {
            let model: CarTModel = carItems[(indexPath as NSIndexPath).row]
            let serviceViewController = ServiceViewController()
            serviceViewController.carModel = model
            serviceViewController.idStr = idArray[indexPath.row]
            self.navigationController?.pushViewController(serviceViewController, animated: true)
        }else {
            let orderID = String(describing: orderModel.id!)
            let orderDetailVC = OrderDetailVC()
            orderDetailVC.orderID = orderID
            self.navigationController?.pushViewController(orderDetailVC, animated: true)
        }
    }
    //首页不出现删除
//    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
//        
//        let idStr = String(describing: idArray[indexPath.row])
//        TZNetworkTool.shareNetworkTool.deleteCar(id: idStr) { (isSuccess) in
//            if isSuccess {
//                
//                TZNetworkTool.shareNetworkTool.getCar { (carItems, idArray, orderItems) in
//                    self.carItems = carItems
//                    self.idArray = idArray
//                    self.orderItems = orderItems
//                    self.carListTableView.reloadData()
//                }
//            }
//        }
//    }
    
    func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
        return "删除"
    }
}
