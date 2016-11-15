//
//  ServiceListVC.swift
//  PremiumCar
//
//  Created by ethen on 2016/10/31.
//  Copyright © 2016年 soda. All rights reserved.
//

import Foundation

class ServiceListVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var carModel: CarTModel!
    var idStr: Int!
    var serviceItems: [ServiceItemModel] = []
    
    private var submitBtn: UIButton!
    private var priceLabel: UILabel!
    private var tableView: UITableView!
    
    private var dataSource: [String : AnyObject]?  {
        didSet {
            self.tableView?.reloadData()
        }
    }
    private var types: [String] = [""]
    private var ids: [Int] = []
    private var count: Float = 0.0 {
        didSet {
            priceLabel.text = String(format: "￥%.2f", count)
            setButton(button: submitBtn, with: (count > 0) ? 1 : 0)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupNavigationItem()
        self.setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        TZNetworkTool.shareNetworkTool.serviceList { (typeArray, serviceBigArray) in
            
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
        
        self.navigationItem.title = "服务项目"
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
        self.view.addSubview(self.tableView)
        
        let submitView = UIView(frame: CGRect(x: 0, y: SCREEN_HEIGHT - 50 - 64, width: SCREEN_WIDTH, height: 50))
        submitView.backgroundColor = FUZZY_BACK
        
        // UI线
        let lineW = UIView(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: 0.5))
        lineW.backgroundColor = FUZZY_BACK
        let lineH = UIView(frame: CGRect(x: SCREEN_WIDTH - 90, y: 10, width: 0.5, height: 30))
        lineH.backgroundColor = FUZZY_BACK
        // 提交btn
        submitBtn = UIButton(type: UIButtonType.custom)
        submitBtn.frame = CGRect(x: SCREEN_WIDTH - 80, y: 0, width: 70, height: 50)
        submitBtn.setTitle("下一步", for: UIControlState.normal)
        submitBtn.backgroundColor = UIColor.clear
        submitBtn?.addTarget(self, action: #selector(buttonClicked(sender:)), for: UIControlEvents.touchUpInside)
        setButton(button: submitBtn, with: 0)
        //选择label
        priceLabel = UILabel(frame: CGRect(x: 20, y: 0, width: 150, height: 50))
        priceLabel.text = "请选择服务项目"
        priceLabel.textColor = UIColor.white
        priceLabel.font = UIFont.systemFont(ofSize: 15)
        
        submitView.addSubview(submitBtn)
        submitView.addSubview(lineW)
        submitView.addSubview(lineH)
        submitView.addSubview(priceLabel)
        view.addSubview(submitView)
    }
    
    //计算已选服务项目的金额总和
    func sum() -> Float {
        var count: Float = 0.0
        for key in types {
            let array = dataSource?[key] as! [AnyObject]
            for dic in array {
                let model = ServiceItemModel(dic: dic as! [String : AnyObject])
                if ids.contains(model.id!) {
                    count += model.price!
                }
            }
        }
        return count
    }
    
    //MARK: Handle
    func buttonClicked(sender: UIButton) {
        let submitVC = SubmitVC()
        submitVC.carModel = self.carModel
        submitVC.idStr = self.idStr
        submitVC.serviceItems = self.serviceItems
        submitVC.count = self.count
        self.navigationController?.pushViewController(submitVC, animated: true)
    }
    
    //MARK: TableViewDelegate
    func numberOfSections(in tableView: UITableView) -> Int {
        return types.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let key = types[section]
        let array = dataSource?[key]
        return (array != nil) ? array!.count : 0
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let key = types[section]
        return key
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCellIdentifier", for: indexPath)
        cell.selectionStyle = .none
        cell.backgroundColor = UIColor.black
        cell.textLabel?.textColor = UIColor.white
        guard types.count > indexPath.section else {
            return cell
        }
        let key = types[indexPath.section] 
        let array = dataSource?[key] as! [AnyObject]
        let dic = array[indexPath.row]
        let model = ServiceItemModel(dic: dic as! [String : AnyObject])
    
        let name: String = (model.name != nil) ? model.name! : ""
        let item: String = (model.item != nil) ? model.item! : ""
        let price: String = String(format: "(￥%.2f)", model.price!)
        cell.accessoryType = (ids.contains(model.id!)) ? .checkmark : .none
        
        let text = name + item + price
        cell.textLabel?.text = text
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let key = types[indexPath.section]
        let array = dataSource?[key] as! [AnyObject]
        let dic = array[indexPath.row]
        let model = ServiceItemModel(dic: dic as! [String : AnyObject])
        if ids.contains(model.id!) {
            let i = ids.index(of: model.id!)
            ids.remove(at: i!)
            serviceItems.remove(at: i!)
        }else {
            ids.append(model.id!)
            serviceItems.append(model)
        }
        tableView.reloadData()
        count = sum()
    }
    
    
    
    
    
    
    
}





