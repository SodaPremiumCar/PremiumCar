//
//  MineViewController.swift
//  PremiumCar
//
//  Created by 赵霆 on 16/11/15.
//  Copyright © 2016年 soda. All rights reserved.
//

import Foundation

class MineViewController: UIViewController {
    
    var tableView: UITableView!
    let titles = ["个人信息", "我的订单", "我的车库", "意见反馈", "联系客服"]
    let images = ["personalInfoCell", "oders", "myCars", "suggestionCell", "phoneCell"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    private func setupUI() {
        
        title = "我的"
        view.backgroundColor = COLOR_BLACK
        
        let frame: CGRect = CGRect(x: 0, y: 64, width: SCREEN_WIDTH, height: SCREEN_HEIGHT - 44 - 40)
        tableView = UITableView.init(frame: frame, style: UITableViewStyle.plain)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.isScrollEnabled = false
        tableView.backgroundColor = UIColor.clear
        tableView.separatorColor = FUZZY_BACK
        tableView.tableFooterView = UIView(frame: CGRect.zero)
        view.addSubview(tableView)
    }
}

extension MineViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 5
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 50
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let identifier = "Cell"
        var cell = tableView.dequeueReusableCell(withIdentifier: identifier as String)
        if cell == nil {
            cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: identifier as String?)
            cell!.textLabel?.textColor = UIColor.white
            cell!.textLabel?.font =  UIFont.systemFont(ofSize: 16)
            cell!.accessoryType = .disclosureIndicator
            // 选中背景颜色
            cell!.selectedBackgroundView = UIView(frame: (cell?.frame)!)
            cell!.selectedBackgroundView?.backgroundColor = FUZZY_BACK
            cell!.backgroundColor = COLOR_BLACK
        }
        cell?.textLabel?.text = titles[indexPath.row]
        cell?.imageView?.image = UIImage(named: images[indexPath.row])

        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if indexPath.row == 0 {
            
            let personalinfoVC = PersonalInfoVC()
            personalinfoVC.isFromRegister = false
            navigationController?.pushViewController(personalinfoVC, animated: true)
        }else if (indexPath.row == 1) {
            
            let orderListVC = OrderListVC()
            navigationController?.pushViewController(orderListVC, animated: true)
        }else if indexPath.row == 2 {
            
            let myCarViewController = MyCarViewController()
            navigationController?.pushViewController(myCarViewController, animated: true)
        }else if indexPath.row == 3 {
            let suggestionVC = SuggestionVC()
            navigationController?.pushViewController(suggestionVC, animated: true)
        }else{
            UIApplication.shared.openURL(URL(string: "telprompt://4000607927")!)
        }
    }
}
