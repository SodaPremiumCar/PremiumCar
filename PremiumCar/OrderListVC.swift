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
        
        self.navigationItem.title = "历史订单"
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
        return 1
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        guard dataSource!.count > section else {
            return ""
        }
        let model = dataSource![section]
        let serialNum: String = (model.serialNum != nil) ? model.serialNum! : ""
        let state: String = (model.state != nil) ? String(format: "(%@)", model.state!) : ""

        return serialNum + state
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCellIdentifier", for: indexPath)
        cell.selectionStyle = .none
        cell.backgroundColor = UIColor.black
        cell.textLabel?.textColor = UIColor.white
        guard dataSource!.count > indexPath.row else {
            return cell
        }
        let model = dataSource![indexPath.section]
        
        let content: String = (model.content != nil) ? model.content! : ""
        let total: String = String(format: "(￥%.2f)", model.total!)
        let text = content + total
        cell.textLabel?.text = text
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
    
    
    
    
    
}



