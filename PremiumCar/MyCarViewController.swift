//
//  MyCarViewController.swift
//  PremiumCar
//
//  Created by 赵霆 on 16/11/16.
//  Copyright © 2016年 soda. All rights reserved.
//

import Foundation

class MyCarViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
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
        
        title = "我的车库"
        TZNetworkTool.shareNetworkTool.getCar { (carItems, idArray, orderItems) in
            self.carItems = carItems
            self.idArray = idArray
            self.carListTableView.reloadData()
        }
    }
    
    
    //MARK: UI
    fileprivate func setupUI() {
        
        self.view.backgroundColor = COLOR_BLACK
        
        let img = UIImage(named: "VCBackground")
        let imgView = UIImageView(frame: self.view.bounds)
        imgView.contentMode = .scaleAspectFill
        imgView.image = img
        
        carListTableView = UITableView(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: SCREEN_HEIGHT - 44 - 64), style: .plain)
        carListTableView.backgroundColor = UIColor.clear
        carListTableView.delegate = self
        carListTableView.dataSource = self
        carListTableView.separatorStyle = UITableViewCellSeparatorStyle.none
        carListTableView.register(CarListCell.self, forCellReuseIdentifier: "CarListCellIdentifier")
        view.addSubview(carListTableView)

        let addBtn = UIButton(type: UIButtonType.custom)
        addBtn.frame = CGRect(x: 0, y: SCREEN_HEIGHT - 44 - 64, width: SCREEN_WIDTH, height: 44)
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
        // 选中背景颜色
        cell.selectionStyle = .none
        cell.backgroundColor = COLOR_BLACK
        
        let model: CarTModel = carItems[(indexPath as NSIndexPath).row]
        cell.update(model)
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        let idStr = String(describing: idArray[indexPath.row])
        TZNetworkTool.shareNetworkTool.deleteCar(id: idStr) { (isSuccess) in
            if isSuccess {
                TZNetworkTool.shareNetworkTool.getCar { (carItems, idArray, orderItems) in
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
