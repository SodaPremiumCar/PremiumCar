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
        
        self.tableView = UITableView(frame: CGRect.init(x: 0, y: 0, width: SCREEN_WIDTH, height: SCREEN_HEIGHT - 64), style: .plain)
        self.tableView.backgroundColor = UIColor.black
        self.tableView.separatorStyle = .none
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.register(MyOrderCell.self, forCellReuseIdentifier: "MyOrderCell")
        self.tableView.tableFooterView = UIView(frame: CGRect.init(x: 0, y: 0, width: 0, height: 0))
        self.view.addSubview(self.tableView)
    }
    
    //MARK:Handle
    func buttonClicked(_ sender: UIButton) {
    }
    
    //MARK: TableViewDelegate
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (dataSource != nil) ? (dataSource!.count) : 0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let model = dataSource![indexPath.row]
        return MyOrderCell.height(model: model)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyOrderCell", for: indexPath)
        cell.selectionStyle = .none
        guard dataSource!.count > indexPath.row else {
            return cell
        }
        let model = dataSource![indexPath.row]
        let myOrderCell = cell as! MyOrderCell
        myOrderCell.update(model: model)
        
        //点选完成按钮的block call back
        myOrderCell.completed = { [weak self] () in
            if let strongSelf = self {
                let alert: UIAlertController = UIAlertController(title: "您确认收车吗？", message: "", preferredStyle: .alert)
                let action0: UIAlertAction = UIAlertAction(title: "确认收车", style: .default) { (alert) in
                    TZNetworkTool.shareNetworkTool.finishOrder(orderId: String(model.id!), finished: { (isSuccess) in
                        if isSuccess {
                            //Request & reloadData
                            TZNetworkTool.shareNetworkTool.orderList { (isSuccess, data) in
                                strongSelf.dataSource = data!
                            }
                        }
                    })
                }
                let action1: UIAlertAction = UIAlertAction(title: "取消", style: .cancel, handler: nil)
                alert.addAction(action0)
                alert.addAction(action1)
                strongSelf.present(alert, animated: true, completion: nil)
            }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
    
    
    
    
    
}



