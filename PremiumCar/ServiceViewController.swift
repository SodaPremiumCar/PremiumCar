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
    var brandsTabelView: UITableView!
    var typesTableView: UITableView!
    var submitView: UIView?
    var submitBtn: UIButton?
    var brandLabel: UILabel?
    var brandStr: String?
    var carTypeId: Int?
    
    var brandstitle = [String]()
    var typestitle = [ServiceItemModel]()
    var typesArray = [[ServiceItemModel]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "服务项目"
        
        TZNetworkTool.shareNetworkTool.serviceList { (typeArray, serviceBigArray) in
            
            self.brandstitle = typeArray as! [String]
            self.typesArray = serviceBigArray
            self.brandsTabelView.reloadData()
        }

        self.setupUI()
    }
    
    private func setupUI() {
        
        self.view.backgroundColor = COLOR_BLACK
        
        let frame: CGRect = CGRect(x: 0, y: 15, width: SCREEN_WIDTH, height: SCREEN_HEIGHT * 0.5)
        brandsTabelView = UITableView.init(frame: frame, style: UITableViewStyle.plain)
        brandsTabelView.delegate = self
        brandsTabelView.dataSource = self
        brandsTabelView.backgroundColor = UIColor.clear
        brandsTabelView.separatorColor = FUZZY_BACK
        brandsTabelView.tableFooterView = UIView(frame: CGRect.zero)
        view.addSubview(brandsTabelView)
        
        let frameRight:CGRect = CGRect(x: 100, y: 15, width: SCREEN_WIDTH, height: SCREEN_HEIGHT * 0.5)
        typesTableView = UITableView(frame: frameRight, style: UITableViewStyle.plain)
        typesTableView.delegate = self
        typesTableView.dataSource = self
        typesTableView.backgroundColor = UIColor.clear
        typesTableView.alpha = 0
        typesTableView.separatorColor = FUZZY_BACK
        typesTableView.tableFooterView = UIView(frame: CGRect.zero)
        view.addSubview(typesTableView)
        
        submitView = UIView(frame: CGRect(x: 0, y: SCREEN_HEIGHT - 50 - 64, width: SCREEN_WIDTH, height: 50))
        submitView?.backgroundColor = FUZZY_BACK
        
        // UI线
        let lineW = UIView(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: 0.5))
        lineW.backgroundColor = FUZZY_BACK
        let lineH = UIView(frame: CGRect(x: SCREEN_WIDTH - 90, y: 10, width: 0.5, height: 30))
        lineH.backgroundColor = FUZZY_BACK
        // 提交btn
        submitBtn = UIButton(type: UIButtonType.custom)
        submitBtn?.frame = CGRect(x: SCREEN_WIDTH - 80, y: 0, width: 70, height: 50)
        submitBtn?.setTitle("提交", for: UIControlState.normal)
        submitBtn?.backgroundColor = UIColor.clear
        submitBtn?.addTarget(self, action: #selector(submitCarBrand), for: UIControlEvents.touchUpInside)
        setButton(button: submitBtn!, with: 0)
        //选择label
        brandLabel = UILabel(frame: CGRect(x: 20, y: 0, width: 150, height: 50))
        brandLabel?.text = "请选择服务项目"
        brandLabel?.textColor = UIColor.white
        brandLabel?.font = UIFont.systemFont(ofSize: 15)
        
        submitView?.addSubview(submitBtn!)
        submitView?.addSubview(lineW)
        submitView?.addSubview(lineH)
        submitView?.addSubview(brandLabel!)
        view.addSubview(submitView!)
        
    }
    
    func submitCarBrand () {
        
        TZNetworkTool.shareNetworkTool.addCar(carTypeId: carTypeId!) { (isSuccess) in
            
            if isSuccess {
                
                let viewController = ViewController()
                self.navigationController?.pushViewController(viewController, animated: true)
            }
        }
    }
}

extension ServiceViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if tableView == brandsTabelView {
            return brandstitle.count
        }else{
            return typestitle.count
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 40
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if tableView == brandsTabelView {
            identifier = "brandsCell"
        }else{
            identifier = "typesCell"
        }
        var cell = tableView.dequeueReusableCell(withIdentifier: identifier as String)
        if cell == nil {
            cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: identifier as String?)
            cell!.textLabel?.textColor = UIColor.white
            cell!.textLabel?.font =  UIFont.systemFont(ofSize: 14)
            // 选中背景颜色
            cell!.selectedBackgroundView = UIView(frame: cell!.frame)
            cell!.selectedBackgroundView?.backgroundColor = FUZZY_BACK
            cell!.backgroundColor = COLOR_BLACK
        }
        if tableView == brandsTabelView {
            cell!.textLabel?.text = brandstitle[indexPath.row]
        }else{
            cell!.textLabel?.text = typestitle[indexPath.row].name
        }
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if tableView == brandsTabelView {
            UITableView.animate(withDuration: 0.7, animations: {
                self.typesTableView.alpha = 1
            })
            
//            brandStr = brandstitle[indexPath.row]
//            self.brandLabel?.text = brandStr
            
            typestitle = typesArray[indexPath.row]
            typesTableView.reloadData()
        }else{
            
//            self.brandLabel?.text = brandStr! + " " + self.typestitle[indexPath.row].name!
//            carTypeId = self.typestitle[indexPath.row].id
            setButton(button: submitBtn!, with: 1)
        }
    }
}
