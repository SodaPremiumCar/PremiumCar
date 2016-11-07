//
//  OrderListVC.swift
//  PremiumCar
//
//  Created by ethen on 2016/11/7.
//  Copyright © 2016年 soda. All rights reserved.
//

import Foundation

class OrderListVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

    private var tableView: UITableView!
    
    private var dataSource: [OrderModel]?  {
        didSet {
            self.tableView?.reloadData()
        }
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupNavigationItem()
        self.setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        TZNetworkTool.shareNetworkTool.orderList { (isSuccess, data) in
            self.dataSource = data!
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
    }
    
    //MARK: UI
    func setupNavigationItem() {
        
        self.navigationItem.title = "我的订单"
        self.navigationController?.isNavigationBarHidden = false
    }
    
    func setupUI() {
        
        self.view.backgroundColor = UIColor.black
        
        self.tableView = UITableView(frame: CGRect.init(x: 0, y: 0, width: SCREEN_WIDTH, height: SCREEN_HEIGHT - 64 - 50), style: .plain)
        self.tableView.backgroundColor = UIColor.black
        self.tableView.separatorColor = UIColor.init(colorLiteralRed: 100, green: 100, blue: 100, alpha: 1)
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "UITableViewCellIdentifier")
        self.tableView.tableFooterView = UIView(frame: CGRect.init(x: 0, y: 0, width: 0, height: 0))
        self.view.addSubview(self.tableView)
    }
    
    //MARK:Handle
    func buttonClicked(_ sender: UIButton) {
    }
    
    //MARK: TableViewDelegate
    func numberOfSections(in tableView: UITableView) -> Int {
        return (dataSource != nil) ? (dataSource!.count) : 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
//        let model = dataSource![section]
//        return (model.services != nil) ? (model.services!.count) : 0
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        guard dataSource!.count > section else {
            return ""
        }
        let model = dataSource![section]
        let serialNum: String = (model.serialNum != nil) ? model.serialNum! : ""
        return "订单号" + serialNum
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCellIdentifier", for: indexPath)
        cell.selectionStyle = .none
        cell.backgroundColor = UIColor.black
        cell.textLabel?.textColor = UIColor.white
        guard dataSource!.count > indexPath.section else {
            return cell
        }
        let model = dataSource![indexPath.section]
        
        var content: String = ""
        if indexPath.row == 0 {
            content = (model.state != nil) ? String(format: "处理状态：%@", model.state!) : "无处理状态"
        }else if indexPath.row == 1 {
            content = (model.content != nil) ? String(format: "车型：%@", model.content!) : "无车型"
        }else if indexPath.row == 2 {
            content = String(format: "消费：￥%.2f", model.total!)
        }else if indexPath.row == 3 {
            content = (model.booking != nil) ? String(format: "预约时间：%@", model.booking!) : "无预约时间"
        }
        cell.textLabel?.text = content
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
    
    
    
    
    
}



