//
//  OrderDetailVC.swift
//  PremiumCar
//
//  Created by ethen on 2016/11/18.
//  Copyright © 2016年 soda. All rights reserved.
//

import Foundation

class OrderDetailVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var orderID: String!
    private var tableView: UITableView!
    
    private var model: OrderModel?  {
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
        TZNetworkTool.shareNetworkTool.orderDetail(orderId: orderID, finished: { (isSuccess, data) in
            self.model = data!
        })
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
        
        self.navigationItem.title = "订单详情"
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
        return (model != nil) ? 1 : 0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return MyOrderCell.height(model: model!)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyOrderCell", for: indexPath)
        cell.selectionStyle = .none

        let myOrderCell = cell as! MyOrderCell
        myOrderCell.update(model: model!)
        
        //点选完成按钮的block call back
        myOrderCell.completed = { [weak self] () in
            if let strongSelf = self {
                let alert: UIAlertController = UIAlertController(title: "您确认收车吗？", message: "", preferredStyle: .alert)
                let action0: UIAlertAction = UIAlertAction(title: "确认收车", style: .default) { (alert) in
                    TZNetworkTool.shareNetworkTool.finishOrder(orderId: strongSelf.orderID!, finished: { (isSuccess) in
                        if isSuccess {
                            //Request & reloadData
                            TZNetworkTool.shareNetworkTool.orderDetail(orderId: strongSelf.orderID!, finished: { (isSuccess, data) in
                                strongSelf.model = data!
                            })
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



