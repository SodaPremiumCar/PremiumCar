//
//  ViewController.swift
//  PremiumCar
//
//  Created by ethen on 16/9/5.
//  Copyright © 2016年 soda. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var carListTableView: UITableView!
    var carItems = [CarTModel]()
    var idArray = [Int]()
    var nameLabel: UILabel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        title = "服务"
        
        if checkLoginStatus() {
            
            let loginVC = LoginViewController()
            self.navigationController?.pushViewController(loginVC, animated: false)
        }else {
            
            TZNetworkTool.shareNetworkTool.getCar { (carItems, idArray) in
                
                self.carItems = carItems
                self.idArray = idArray
                self.carListTableView.reloadData()
            }
        }
    }
    
    
    //MARK: UI
    fileprivate func setupUI() {
        
        self.view.backgroundColor = COLOR_BLACK
        
        let img = UIImage(named: "VCBackground")
        let imgView = UIImageView(frame: self.view.bounds)
        imgView.contentMode = .scaleAspectFill
        imgView.image = img
        
        carListTableView = UITableView(frame: CGRect(x: 0, y: 20, width: SCREEN_WIDTH, height: SCREEN_HEIGHT - 84), style: .plain)
        carListTableView.backgroundColor = UIColor.clear
        carListTableView.delegate = self
        carListTableView.dataSource = self
        carListTableView.separatorStyle = UITableViewCellSeparatorStyle.none
        carListTableView.register(CarListCell.self, forCellReuseIdentifier: "CarListCellIdentifier")
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
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CarListCellIdentifier", for: indexPath) as! CarListCell
        cell.accessoryType = .disclosureIndicator
        // 选中背景颜色
        cell.selectedBackgroundView = UIView(frame: cell.frame)
        cell.selectedBackgroundView?.backgroundColor = FUZZY_BACK
        cell.backgroundColor = COLOR_BLACK
        
        let model: CarTModel = carItems[(indexPath as NSIndexPath).row]
        cell.update(model)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        let model: CarTModel = carItems[(indexPath as NSIndexPath).row]
        let serviceViewController = ServiceViewController()
        serviceViewController.carModel = model
        serviceViewController.idStr = idArray[indexPath.row]
        self.navigationController?.pushViewController(serviceViewController, animated: true)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        let idStr = String(describing: idArray[indexPath.row])
        TZNetworkTool.shareNetworkTool.deleteCar(id: idStr) { (isSuccess) in
            if isSuccess {
                
                TZNetworkTool.shareNetworkTool.getCar { (carItems, idArray) in
                    
                    self.carItems = carItems
                    self.idArray = idArray
                    self.carListTableView.reloadData()
                }
            }
        }
    }
    
    func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
        return "删除"
    }
}
