//
//  CarListVC.swift
//  PremiumCar
//
//  Created by ethen on 16/9/6.
//  Copyright © 2016年 soda. All rights reserved.
//

import UIKit

class CarListVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

    fileprivate var tableView: UITableView!
    fileprivate var dataSource: [CarModel] = []  {
        
        didSet {
            
            self.tableView?.reloadData()
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let dic0 = ["name" : "保时捷 911", "url" : "Porsche-911", "numbel" : "京A 32N28"]
        let model0 = CarModel(dic: dic0 as [String : AnyObject])
        let dic1 = ["name" : "宾利 添越", "url" : "Bingley-bentayga", "numbel" : "京N 2O4P2"]
        let model1 = CarModel(dic: dic1 as [String : AnyObject])
        let dic2 = ["name" : "捷豹 F-Pace", "url" : "Jaguar-fPace", "numbel" : "京Q 12JL1"]
        let model2 = CarModel(dic: dic2 as [String : AnyObject])
        let dic3 = ["name" : "奔驰 SL", "url" : "Benz-SL", "numbel" : "京A 93DL8"]
        let model3 = CarModel(dic: dic3 as [String : AnyObject])
        let dic4 = ["name" : "劳斯莱斯 魅影", "url" : "RollsRoyce-wraith", "numbel" : "京Q J4Y89"]
        let model4 = CarModel(dic: dic4 as [String : AnyObject])
        let dic5 = ["name" : "特斯拉 ModelS", "url" : "Tesla-modelS", "numbel" : "京N 6NN18"]
        let model5 = CarModel(dic: dic5 as [String : AnyObject])

        
        dataSource = [model0, model1, model2, model3, model4, model5]
        setupUI()
    }
    
    //MARK: UI
    fileprivate func setupUI() {
        
        self.view.backgroundColor = RGBA(0, g: 0, b: 0, a: 1)
        self.navigationController?.isNavigationBarHidden = false
        self.tableView = UITableView(frame: self.view.bounds, style: .plain)
        self.tableView.backgroundColor = UIColor.white
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.register(CarListCell.self, forCellReuseIdentifier: "CarListCellIdentifier")
        self.view.addSubview(self.tableView)
        self.tableView.tableFooterView = UIView(frame: CGRect.zero)
    }

    //MARK: Handle
    func buttonClicked(_ sender: UIButton) {
    }
    
    //MARK: TableViewDelegate
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if dataSource.count > 0 {
            return dataSource.count
        }else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return CarListCell.height()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CarListCellIdentifier", for: indexPath) as! CarListCell
        cell.selectionStyle = .gray
        cell.accessoryType = .disclosureIndicator
        
        let model: CarModel = dataSource[(indexPath as NSIndexPath).row]
        cell.update(model)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        let model: CarModel = dataSource[(indexPath as NSIndexPath).row]
        let detailVC = CarDetailVC()
        detailVC.carModel = model
        detailVC.title = model.name
        self.navigationController?.pushViewController(detailVC, animated: true)
    }
}








