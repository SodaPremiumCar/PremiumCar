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
    fileprivate var state: UIButton!
    fileprivate var complete: UIButton!
    fileprivate var service: UILabel!
    fileprivate var line: UIView!
    
    var completed: (() -> Void)?
    
    
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
            make.top.equalTo(numbel.snp.bottom).offset(5)
            make.right.equalTo(-10)
            make.height.equalTo(22)
        }
        
        booking = UILabel()
        setLabelStyle(lable: booking)
        contentView.addSubview(booking)
        booking.snp.makeConstraints { (make) in
            make.left.equalTo(18)
            make.top.equalTo(carType.snp.bottom).offset(5)
            make.right.equalTo(-10)
            make.height.equalTo(22)
        }
        
        total = UILabel()
        setLabelStyle(lable: total)
        contentView.addSubview(total)
        total.snp.makeConstraints { (make) in
            make.left.equalTo(18)
            make.top.equalTo(booking.snp.bottom).offset(5)
            make.right.equalTo(-10)
            make.height.equalTo(22)
        }
        
        service = UILabel()
        service.font = UIFont.systemFont(ofSize: 13)
        service.textColor = RGBA(180, g: 180, b: 180, a: 1)
        service.numberOfLines = 0
        contentView.addSubview(service)
        
        state = getStateButton(frame: CGRect.init(x: SCREEN_WIDTH - 50 - 18, y: 16, width: 50, height: 20), title: "", fontSize: 10)
        contentView.addSubview(state)
        
        complete = UIButton(type: UIButtonType.roundedRect)
        complete.frame = CGRect.init(x: SCREEN_WIDTH - 50 - 18, y: 46, width: 50, height: 50)
        complete.layer.cornerRadius = 3
        complete.layer.masksToBounds = true
        complete.titleLabel?.adjustsFontSizeToFitWidth = true
        complete.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        complete.setTitleColor(UIColor.black, for: .normal)
        complete.addTarget(self, action: #selector(buttonClick), for: .touchUpInside)
        complete.backgroundColor = SEC_ORANGE
        complete.setTitle("确认\n收车", for: UIControlState.normal)
        complete.titleLabel?.numberOfLines = 2
        contentView.addSubview(complete)
        complete.isHidden = true
        
        line = UIView()
        line.backgroundColor = RGBA(55, g: 55, b: 55, a: 1)
        contentView.addSubview(line)
    }
    
    func update(model: OrderModel) {
        numbel.mix(img: UIImage(named: "myOrderNumbel")!, text: model.serialNum!, imgSize: CGSize.init(width: 14, height: 14))
        carType.mix(img: UIImage(named: "myOrderCar")!, text: model.content!, imgSize: CGSize.init(width: 14, height: 14))
        booking.mix(img: UIImage(named: "myOrderBooking")!, text: model.booking!, imgSize: CGSize.init(width: 14, height: 14))
        total.mix(img: UIImage(named: "myOrderTotal")!, text: String(format: "消费：￥%.2f", model.total!), imgSize: CGSize.init(width: 14, height: 14))
        state.setTitle(model.state!, for: UIControlState.normal)
        
        //送车中，显示完成按钮
        complete.isHidden = (model.state! == "送车中") ? false : true
        
        if (model.services != nil) {
            var text = ""
            for dic in model.services! {
                if text.isEmpty == false {
                    text += "\n"
                }
                text += String(describing: dic["name"]!) + "(￥" + String(describing: dic["price"]!) + ")"
            }
            service.text = text
            
            let height = CGFloat(17 * (model.services!.count)) > 22 ? CGFloat(17 * (model.services!.count)) : 22
            service.frame = CGRect.init(x: 43, y: 15 + 22 * 4 + 5 * 4, width: SCREEN_WIDTH - 50, height: height)
            
            let cellHeight = MyOrderCell.height(model: model)
            complete.frame = CGRect.init(x: SCREEN_WIDTH - 50 - 18, y: cellHeight - 60, width: 50, height: 50)
            line.frame = CGRect.init(x: 20, y: cellHeight - 0.5, width: SCREEN_WIDTH - 40, height: 0.5)
        }
    }
    
    class func height(model: OrderModel) -> CGFloat {
        let height = CGFloat(17 * (model.services!.count)) > 22 ? CGFloat(17 * (model.services!.count)) : 22
        let white = 15 + 15 + 5 * 4
        return 22 * 4 + CGFloat(height) + CGFloat(white)
    }
    
    func buttonClick() -> Void {
        if completed != nil {
            self.completed!()
        }
    }
    
    //MARK: 私有
    fileprivate func setLabelStyle(lable: UILabel) {
        lable.textColor = RGBA(220, g: 220, b: 220, a: 1)
        lable.numberOfLines = 1
        lable.font = UIFont.systemFont(ofSize: 14)
        lable.adjustsFontSizeToFitWidth = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}









