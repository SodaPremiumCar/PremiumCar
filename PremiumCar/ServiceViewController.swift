//
//  ServiceViewController.swift
//  PremiumCar
//
//  Created by 赵霆 on 16/11/16.
//  Copyright © 2016年 soda. All rights reserved.
//

import Foundation

class ServiceViewController: UIViewController {
    
    var identifier: NSString!
    var typeTabelView: UITableView!
    var nameTableView: UITableView!
    var submitBtn: UIButton?
    var submitLabel: UILabel?
    
    var carModel: CarTModel!    //车型model
    var idStr: Int!                     //车辆id
    
    var typeArray = [String]()    //tableview1 cell text
    var currentDataArray = [ServiceItemModel]()   //tableview2 current data
    var allDataArray = [[ServiceItemModel]]()     //tableview2 all data
    var selectedDataArray = [ServiceItemModel]()    //选定的服务项目model
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "服务项目"
        TZNetworkTool.shareNetworkTool.serviceList(carTypeId: carModel.id!) { (typeArray, serviceBigArray) in
            
            self.typeArray = typeArray as! [String]
            self.allDataArray = serviceBigArray
            self.currentDataArray = []
            self.typeTabelView.reloadData()
        }
        
        self.setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.isNavigationBarHidden = false
    }
    
    private func setupUI() {
        
        self.view.backgroundColor = COLOR_BLACK
        
        //服务大类别TableView
        let frame: CGRect = CGRect(x: 0, y: 0, width: 120, height: SCREEN_HEIGHT - 64 - 50)
        typeTabelView = UITableView.init(frame: frame, style: UITableViewStyle.plain)
        typeTabelView.delegate = self
        typeTabelView.dataSource = self
        typeTabelView.backgroundColor = UIColor.clear
        typeTabelView.separatorColor = FUZZY_BACK
        typeTabelView.tableFooterView = UIView(frame: CGRect.zero)
        view.addSubview(typeTabelView)
        
        //服务二级内容TableView
        let frameRight:CGRect = CGRect(x: 120, y: 0, width: SCREEN_WIDTH - 120, height: SCREEN_HEIGHT - 64 - 50)
        nameTableView = UITableView(frame: frameRight, style: UITableViewStyle.plain)
        nameTableView.delegate = self
        nameTableView.dataSource = self
        nameTableView.backgroundColor = UIColor.clear
        nameTableView.alpha = 0
        nameTableView.separatorColor = FUZZY_BACK
        nameTableView.tableFooterView = UIView(frame: CGRect.zero)
        view.addSubview(nameTableView)
        
        //底部提交栏
        let submitView = UIView(frame: CGRect(x: 0, y: SCREEN_HEIGHT - 50 - 64, width: SCREEN_WIDTH, height: 50))
        submitView.backgroundColor = FUZZY_BACK
        
        // UI线
        let lineW = UIView(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: 0.5))
        lineW.backgroundColor = FUZZY_BACK
        let lineH = UIView(frame: CGRect(x: SCREEN_WIDTH - 90, y: 10, width: 0.5, height: 30))
        lineH.backgroundColor = FUZZY_BACK
        
        // 提交btn
        submitBtn = UIButton(type: UIButtonType.custom)
        submitBtn?.frame = CGRect(x: SCREEN_WIDTH - 80, y: 0, width: 70, height: 50)
        submitBtn?.setTitle("下一步", for: UIControlState.normal)
        submitBtn?.setTitleColor(SEC_ORANGE, for: .normal)
        submitBtn?.backgroundColor = UIColor.clear
        submitBtn?.addTarget(self, action: #selector(buttonClicked(sender:)), for: UIControlEvents.touchUpInside)
        submitBtn?.isEnabled = false
        
        //选择label
        submitLabel = UILabel(frame: CGRect(x: 20, y: 0, width: SCREEN_WIDTH - 170, height: 50))
        submitLabel?.textColor = UIColor.white
        submitLabel?.font = UIFont.systemFont(ofSize: 15)
        submitLabel?.numberOfLines = 2
        
        submitView.addSubview(submitBtn!)
        submitView.addSubview(lineW)
        submitView.addSubview(lineH)
        submitView.addSubview(submitLabel!)
        view.addSubview(submitView)
        
        updateSubmitView()
    }
    
    func buttonClicked(sender: UIButton) {
        
        let submitVC = SubmitVC()
        submitVC.carModel = self.carModel
        submitVC.idStr = self.idStr
        submitVC.serviceItems = self.selectedDataArray
        self.navigationController?.pushViewController(submitVC, animated: true)
    }
    
    func updateSubmitView() {
        
        if selectedDataArray.count > 0 {
            submitBtn?.isEnabled = true
            var total: Float = 0.0
            var count: Int = 0
            for model in selectedDataArray {
                total += model.price!
                count += 1
            }
            submitLabel?.text = String(format: "选择%i个项目，费用%.2f元", count, total)
        }else {
            submitBtn?.isEnabled = false
            submitLabel?.text = "请选择服务项目"
        }
    }
}


extension ServiceViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if tableView == typeTabelView {
            return typeArray.count
        }else{
            return currentDataArray.count
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 45
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if tableView == typeTabelView {
            identifier = "typeCell"
        }else{
            identifier = "nameCell"
        }
        var cell = tableView.dequeueReusableCell(withIdentifier: identifier as String)
        if cell == nil {
            cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: identifier as String?)
            cell?.tintColor = SEC_ORANGE
            cell!.textLabel?.textColor = UIColor.white
            cell!.textLabel?.font =  UIFont.systemFont(ofSize: 15)
            cell!.textLabel?.adjustsFontSizeToFitWidth = true
            // 选中背景颜色
            cell!.selectedBackgroundView = UIView(frame: cell!.frame)
            cell!.selectedBackgroundView?.backgroundColor = FUZZY_BACK
            cell!.backgroundColor = COLOR_BLACK
        }
        if tableView == typeTabelView {
            cell!.textLabel?.text = typeArray[indexPath.row]
        }else{
            let model = currentDataArray[indexPath.row]
            let price = String(format: "（￥%.2f）", model.price!)
            let item = (model.item != nil) ? model.item! : ""
            cell!.textLabel?.text = model.name! + item + price
            cell!.accessoryType = (model.isSelected == true) ? .checkmark : .none
        }
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if tableView == typeTabelView {
            UITableView.animate(withDuration: 0.25, animations: {
                self.nameTableView.alpha = 1
            })
            currentDataArray = allDataArray[indexPath.row]
        }else{
            let model = currentDataArray[indexPath.row]
            if selectedDataArray.contains(model) {
                model.isSelected = false
                let i = selectedDataArray.index(of: model)
                selectedDataArray.remove(at: i!)
            }else {
                model.isSelected = true
                selectedDataArray.append(model)
            }
            updateSubmitView()
        }
        nameTableView.reloadData()
    }
}

