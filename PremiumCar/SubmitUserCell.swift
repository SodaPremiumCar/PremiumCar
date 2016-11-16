//
//  SubmitUserCell.swift
//  PremiumCar
//
//  Created by ethen on 2016/11/16.
//  Copyright © 2016年 soda. All rights reserved.
//

import Foundation
import SnapKit

class SubmitUserCell: UITableViewCell {
    fileprivate var name: UILabel!
    fileprivate var phone: UILabel!
    fileprivate var adress: UILabel!
    
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.backgroundColor = UIColor.black
        
        name = UILabel()
        name.textColor = UIColor.white
        name.numberOfLines = 1
        name.font = UIFont.systemFont(ofSize: 15)
        name.snp.makeConstraints { (make) in
            make.left.equalTo(10)
            make.top.equalTo(10)
            make.right.equalTo(-10)
            make.height.equalTo(22)
        }
        
        phone = UILabel()
        phone.textColor = UIColor.white
        phone.numberOfLines = 1
        phone.font = UIFont.systemFont(ofSize: 13)
        phone.snp.makeConstraints { (make) in
            make.left.equalTo(10)
            make.top.equalTo(name.snp.bottom)
            make.right.equalTo(-10)
            make.height.equalTo(18)
        }
        
        adress = UILabel()
        adress.textColor = UIColor.white
        adress.numberOfLines = 1
        adress.font = UIFont.systemFont(ofSize: 13)
        adress.snp.makeConstraints { (make) in
            make.left.equalTo(10)
            make.top.equalTo(phone.snp.bottom)
            make.right.equalTo(-10)
            make.height.equalTo(18)
        }
    
        
        let line = UIView()
        line.backgroundColor = RGBA(55, g: 55, b: 55, a: 1)
        contentView.addSubview(line)
        line.snp.makeConstraints { (make) in
            make.top.equalTo(adress.snp.bottom).offset(10)
            make.left.equalTo(20)
            make.right.equalTo(-20)
            make.height.equalTo(0.5)
        }
    }
    
    func update(n: String, p: String, a: String) {
        name.text = n
        phone.text = p
        adress.text = a
    }
    
    class func height() -> CGFloat {
        return 10 + 22 + 18 * 2 + 10
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}






