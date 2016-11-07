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
        
        self.navigationItem.hidesBackButton = true
        self.navigationController?.isNavigationBarHidden = true
        
        UserData.share.load()
        let mob: String? = UserData.share.mobileNo
        let auth: String? = UserData.share.authToken
        if mob == nil || mob!.isEmpty || auth == nil || auth!.isEmpty   {
            
            let loginVC = LoginViewController()
            self.navigationController?.pushViewController(loginVC, animated: false)
        }else {
            
            if (UserData.share.name != nil) {
                nameLabel?.text = UserData.share.name! + " " + "的车库"
            }else{
                nameLabel?.text = "车库"
            }
    
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
        
        let personalInfo = UIButton(frame: CGRect(x: (SCREEN_WIDTH - 200) / 2, y: 44, width: 70, height: 70))
        personalInfo.setImage(UIImage(named: "person"), for: UIControlState.normal)
        personalInfo.backgroundColor = UIColor.clear
        personalInfo.addTarget(self, action: #selector(buttonClick), for: UIControlEvents.touchUpInside)
        view.addSubview(personalInfo)
        
        nameLabel = UILabel(frame: CGRect(x: (personalInfo.frame.maxX) + 10, y: 44, width: 130, height: 70))
        nameLabel?.font = UIFont.systemFont(ofSize: 16)
        nameLabel?.adjustsFontSizeToFitWidth = true
        nameLabel?.textColor = RGBA(255, g: 255, b: 255, a: 0.8)
        view.addSubview(nameLabel!)
        
        carListTableView = UITableView(frame: CGRect(x: 0, y: (personalInfo.frame.maxY) + 10, width: SCREEN_WIDTH, height: SCREEN_HEIGHT - (personalInfo.frame.maxY) - 44 - 10), style: .plain)
        carListTableView.backgroundColor = UIColor.clear
        carListTableView.delegate = self
        carListTableView.dataSource = self
        carListTableView.separatorStyle = UITableViewCellSeparatorStyle.none
        carListTableView.register(CarListCell.self, forCellReuseIdentifier: "CarListCellIdentifier")
        view.addSubview(carListTableView)
//        carListTableView.tableFooterView = UIView(frame: CGRect.zero)
        
//        let header = UIView()
//        header.frame = CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: 150)
//        header.addSubview(personalInfo)
//        carListTableView.tableHeaderView = header
        
        let addBtn = UIButton(type: UIButtonType.custom)
        addBtn.frame = CGRect(x: 0, y: SCREEN_HEIGHT - 44, width: SCREEN_WIDTH, height: 44)
        addBtn.backgroundColor = FUZZY_BACK
        addBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 5)
        addBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 5, 0, 0)
        addBtn.setImage(UIImage(named: "addOther"), for: UIControlState.normal)
        addBtn.setTitle("增加车辆", for: UIControlState.normal)
        addBtn.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        addBtn.addTarget(self, action: #selector(addMoreCar), for: UIControlEvents.touchUpInside)
        let line = UIView(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: 0.5))
        line.backgroundColor = FUZZY_BACK
        addBtn.addSubview(line)
        view.addSubview(addBtn)
    }
    
    func addMoreCar() {
        let carBrandsVC = CarBrandsVC()
        carBrandsVC.isFromRegister = false
        self.navigationController?.pushViewController(carBrandsVC, animated: true)
    }
    
    func buttonClick() {
        
        let personalVC = PersonalInfoVC()
        personalVC.isFromRegister = false
        self.navigationController?.pushViewController(personalVC, animated: true)
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
        let serviceListVC = ServiceListVC()
        serviceListVC.carModel = model
        serviceListVC.idStr = idArray[indexPath.row]
        self.navigationController?.pushViewController(serviceListVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        let idStr = String(describing: idArray[indexPath.row])
        print(idStr)
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
