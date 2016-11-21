//
//  ChatListCell.swift
//  IM
//
//  Created by ethen on 16/8/16.
//  Copyright © 2016年 ethan. All rights reserved.
//

import UIKit
import SnapKit

class CarListCell: UITableViewCell {

    fileprivate var nameLabel: UILabel?
    fileprivate var imgView: UIImageView?
    fileprivate var stateBtn: UIButton?
    fileprivate var licenseLabel: UILabel?
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = UIColor.white
        
        imgView = UIImageView()
        imgView?.backgroundColor = UIColor.clear
//        imgView?.clipsToBounds = true
        imgView?.contentMode = .scaleAspectFit
        contentView.addSubview(imgView!)
        imgView?.snp_makeConstraints({ (make) in
            make.top.equalTo(20)
            make.left.equalTo(20)
            make.size.equalTo(CGSize(width: 40, height: 40))
        })
        
        let lineH = UIView(frame: CGRect(x: 80, y: 20, width: 0.5, height: 40))
        lineH.backgroundColor = RGBA(255, g: 255, b: 255, a: 0.35)
        contentView.addSubview(lineH)
        
        nameLabel = UILabel()
        nameLabel?.textColor = RGBA(255, g: 255, b: 255, a: 1)
        nameLabel?.font = UIFont.systemFont(ofSize: 14)
        contentView.addSubview(nameLabel!)
        nameLabel?.snp_makeConstraints({ (make) in
            make.top.equalTo(20)
            make.left.equalTo(lineH.snp_right).offset(10)
            make.size.equalTo(CGSize(width: SCREEN_WIDTH * 0.5, height: 20))
        })
        
        licenseLabel = UILabel(frame: CGRect(x: (lineH.frame.maxX) + 10, y: 40, width: SCREEN_WIDTH * 0.5, height: 20))
        licenseLabel?.textColor = UIColor.white
        licenseLabel?.font = UIFont.systemFont(ofSize: 12)
        contentView.addSubview(licenseLabel!)
    }
    
    var stateSource: OrderModel? {
        
        didSet {
            
            stateBtn?.removeFromSuperview()
            
            let frame = CGRect(x: SCREEN_WIDTH - 50 - 15, y: 30, width: 50, height: 20)
            stateBtn = getStateButton(frame: frame, title: (stateSource?.state)!, fontSize: 10)
            contentView.addSubview(stateBtn!)
        }
    }
    
    func update(_ model: CarTModel) {
        
        var carImg = UIImage()
        if model.brand == "奔驰" {
            carImg = UIImage(named: "benz")!
        }else if model.brand == "讴歌" {
            carImg = UIImage(named: "acura")!
        }else if model.brand == "奥迪" {
            carImg = UIImage(named: "audi")!
        }else if model.brand == "宝马" {
            carImg = UIImage(named: "bmw")!
        }else if model.brand == "英菲尼迪" {
            carImg = UIImage(named: "infiniti")!
        }else if model.brand == "雷克萨斯" {
            carImg = UIImage(named: "lexus")!
        }else if model.brand == "保时捷" {
            carImg = UIImage(named: "porsche")!
        }
        
        self.imgView?.image = carImg
        nameLabel?.text = model.brand! + " " + model.model!
        licenseLabel?.text = model.licenseNum
    }
    
    class func height() -> CGFloat {
        
        return 80
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


