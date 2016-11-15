//
//  MyOrderCell.swift
//  PremiumCar
//
//  Created by ethen on 2016/11/15.
//  Copyright © 2016年 soda. All rights reserved.
//

import Foundation
import SnapKit

class MyOrderCell: UITableViewCell {
    fileprivate var numbel: UILabel!
    fileprivate var carType: UILabel!
    fileprivate var booking: UILabel!
    fileprivate var total: UILabel!
    fileprivate var state: UILabel!
    
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.backgroundColor = UIColor.black
        
        numbel = UILabel()
        setLabelStyle(lable: numbel)
        contentView.addSubview(numbel)
        numbel.snp.makeConstraints { (make) in
            make.left.equalTo(18)
            make.top.equalTo(15)
            make.right.equalTo(-10)
            make.height.equalTo(22)
        }
        
        carType = UILabel()
        setLabelStyle(lable: carType)
        contentView.addSubview(carType)
        carType.snp.makeConstraints { (make) in
            make.left.equalTo(18)
            make.top.equalTo(numbel.snp.bottom)
            make.right.equalTo(-10)
            make.height.equalTo(22)
        }
        
        booking = UILabel()
        setLabelStyle(lable: booking)
        contentView.addSubview(booking)
        booking.snp.makeConstraints { (make) in
            make.left.equalTo(18)
            make.top.equalTo(carType.snp.bottom)
            make.right.equalTo(-10)
            make.height.equalTo(22)
        }
        
        total = UILabel()
        setLabelStyle(lable: total)
        contentView.addSubview(total)
        total.snp.makeConstraints { (make) in
            make.left.equalTo(18)
            make.top.equalTo(booking.snp.bottom)
            make.right.equalTo(-10)
            make.height.equalTo(22)
        }
        
        state = UILabel()
        state.textColor = RGBA(200, g: 200, b: 200, a: 1)
        state.numberOfLines = 1
        state.font = UIFont.boldSystemFont(ofSize: 12)
        state.adjustsFontSizeToFitWidth = true
        state.textAlignment = .center
        state.backgroundColor = RGBA(50, g: 50, b: 50, a: 1)
        contentView.addSubview(state)
        state.snp.makeConstraints { (make) in
            make.width.equalTo(60)
            make.top.equalTo(15)
            make.right.equalTo(-18)
            make.height.equalTo(18)
        }
        
        let line = UIView()
        line.backgroundColor = RGBA(55, g: 55, b: 55, a: 1)
        contentView.addSubview(line)
        line.snp.makeConstraints { (make) in
            make.top.equalTo(total.snp.bottom).offset(14.5)
            make.left.equalTo(20)
            make.right.equalTo(-20)
            make.height.equalTo(0.5)
        }
    }
    
    func update(model: OrderModel) {
        numbel.mix(img: UIImage(named: "myOrderNumbel")!, text: model.serialNum!, imgSize: CGSize.init(width: 14, height: 14))
        carType.mix(img: UIImage(named: "myOrderCar")!, text: model.content!, imgSize: CGSize.init(width: 14, height: 14))
        booking.mix(img: UIImage(named: "myOrderBooking")!, text: model.booking!, imgSize: CGSize.init(width: 14, height: 14))
        total.mix(img: UIImage(named: "myOrderTotal")!, text: String(format: "消费：￥%.2f", model.total!), imgSize: CGSize.init(width: 14, height: 14))
        state.text = model.state!
    }
    
    class func height() -> CGFloat {
        return 15 + 22 * 4 + 15
    }
    
    //MARK: 私有
    fileprivate func setLabelStyle(lable: UILabel) {
        lable.textColor = UIColor.white
        lable.numberOfLines = 1
        lable.font = UIFont.systemFont(ofSize: 14)
        lable.adjustsFontSizeToFitWidth = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}









