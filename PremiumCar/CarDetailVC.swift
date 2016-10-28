//
//  CarDetailVC.swift
//  PremiumCar
//
//  Created by ethen on 16/9/9.
//  Copyright © 2016年 soda. All rights reserved.
//

import UIKit

class CarDetailVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var carModel: CarModel!
    var dataArray: [AnyObject]!
    fileprivate var tableView: UITableView!
    fileprivate var banner: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dataArray = ["09月03日\t￥50 \n\n为爱车做了 车辆清洗" as AnyObject, "08月21日\t￥50 \n\n为爱车做了 车辆清洗" as AnyObject, "07月16日\t￥200 \n\n为爱车做了 车辆精洗" as AnyObject, "07月08日\t￥12000 \n\n为爱车做了 2万公里保养" as AnyObject, "06月02日\t￥50 \n\n为爱车做了 车辆清洗" as AnyObject, "05月27日\t￥50 \n\n为爱车做了 车辆清洗" as AnyObject]
        setupUI()
    }
    
    //MARK: UI
    fileprivate func setupUI() {
        
        self.view.backgroundColor = UIColor.white
        
        banner = UIImageView()
        banner.backgroundColor = RGBA(250, g: 250, b: 250, a: 1)
        banner.clipsToBounds = true
        banner.contentMode = .scaleAspectFill
        self.view.addSubview(banner)
        banner.snp_makeConstraints({ (make) in
            make.top.equalTo(0)
            make.left.equalTo(0)
            make.size.equalTo(CGSize(width: SCREEN_WIDTH, height: SCREEN_WIDTH))
        })
        banner.image = UIImage(named: carModel.url!)
        
        self.tableView = UITableView(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: SCREEN_HEIGHT - 50 - 64), style: .plain)
        self.tableView.backgroundColor = UIColor.clear
//        self.tableView.separatorStyle = .None
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "CellIdentifier")
        self.view.addSubview(self.tableView)
        let header = UIView(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: SCREEN_WIDTH))
        self.tableView.tableHeaderView = header
        self.tableView.tableFooterView = UIView(frame: CGRect.zero)
        
        let btn0 = UIButton(type: .custom)
        btn0.backgroundColor = COLOR_BLACK
        btn0.setTitle("续保", for: UIControlState())
        btn0.setTitleColor(UIColor.white, for: UIControlState())
        btn0.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        btn0.addTarget(self, action: #selector(buttonClicked(_:)), for: .touchUpInside)
        self.view.addSubview(btn0)
        btn0.snp_makeConstraints { (make) in
            make.size.equalTo(CGSize(width: SCREEN_WIDTH / 2, height: 50))
            make.bottom.equalTo(self.view.snp_bottom)
        }
        
        let btn1 = UIButton(type: .custom)
        btn1.backgroundColor = COLOR_BLACK
        btn1.setTitle("保养", for: UIControlState())
        btn1.setTitleColor(UIColor.white, for: UIControlState())
        btn1.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        btn1.addTarget(self, action: #selector(buttonClicked(_:)), for: .touchUpInside)
        self.view.addSubview(btn1)
        btn1.snp_makeConstraints { (make) in
            make.size.equalTo(btn0)
            make.left.equalTo(btn0.snp_right)
            make.bottom.equalTo(self.view.snp_bottom)
        }
        
        let line = UIView()
        line.backgroundColor = UIColor.white
        self.view.addSubview(line)
        line.snp_makeConstraints { (make) in
            make.size.equalTo(CGSize(width: 0.5, height: 44))
            make.top.equalTo(btn1).offset(3)
            make.left.equalTo(btn1)
        }
        line.alpha = 0.4
    }
    
    //MARK: Handle
    func buttonClicked(_ sender: UIButton) {
        
        let submitVC = SubmitVC()
        self.navigationController?.pushViewController(submitVC, animated: true)
    }
    
    //MARK: TableViewDelegate
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if section == 0 {
            return 1
        }
        return dataArray.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if (indexPath as NSIndexPath).section == 0 {
            return 100
        }
        return 80
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CellIdentifier", for: indexPath)
        cell.selectionStyle = .none
        
        if (indexPath as NSIndexPath).section == 0 {
            cell.backgroundColor = UIColor.white
            
            let numbelLabel = UILabel()
            numbelLabel.backgroundColor = COLOR_BLACK //RGBA(3, g: 84, b: 253, a: 1)
            numbelLabel.textColor = UIColor.white
            numbelLabel.font = UIFont.boldSystemFont(ofSize: 38)
            numbelLabel.textAlignment = .center
            numbelLabel.layer.masksToBounds = true
            numbelLabel.layer.cornerRadius = 5
            cell.contentView.addSubview(numbelLabel)
            numbelLabel.snp_makeConstraints({ (make) in
                make.top.equalTo(20)
                make.centerX.equalTo(self.view)
                make.size.equalTo(CGSize(width: 200, height: 60))
            })
            numbelLabel.text = self.carModel.numbel
            numbelLabel.alpha = 0.85
        }else {
            let text = dataArray[(indexPath as NSIndexPath).row] as! String
            let label = UILabel(frame: CGRect(x: 18, y: 0, width: SCREEN_WIDTH - 26, height: 60))
            label.textColor = RGBA(120, g: 120, b: 120, a: 1)
            label.numberOfLines = 0
            label.font = UIFont.systemFont(ofSize: 14)
            cell.contentView.addSubview(label)
            label.text = text
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        banner.frame.origin.y = 0 - (scrollView.contentOffset.y / 2.6)
    }

}
