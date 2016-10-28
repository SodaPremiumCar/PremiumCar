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
    fileprivate var numbelLabel: UILabel?
    fileprivate var imgView: UIImageView?
    
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = UIColor.white
        
        imgView = UIImageView()
        imgView?.backgroundColor = RGBA(250, g: 250, b: 250, a: 1)
        imgView?.clipsToBounds = true
        imgView?.contentMode = .scaleAspectFill
        contentView.addSubview(imgView!)
        imgView?.snp_makeConstraints({ (make) in
            make.top.equalTo(8)
            make.left.equalTo(8)
            make.size.equalTo(CGSize(width: 124, height: 64))
        })
        
        nameLabel = UILabel()
        nameLabel?.textColor = RGBA(0, g: 0, b: 0, a: 1)
        nameLabel?.font = UIFont.systemFont(ofSize: 18)
        contentView.addSubview(nameLabel!)
        nameLabel?.snp_makeConstraints({ (make) in
            make.top.equalTo(8)
            make.left.equalTo(imgView!.snp_right).offset(8)
            make.size.equalTo(CGSize(width: SCREEN_WIDTH-8-54-8-8-80-10, height: 32))
        })
        
        numbelLabel = UILabel()
        numbelLabel?.textColor = RGBA(110, g: 110, b: 110, a: 1)
        numbelLabel?.font = UIFont.systemFont(ofSize: 16)
        contentView.addSubview(numbelLabel!)
        numbelLabel?.snp_makeConstraints({ (make) in
            make.top.equalTo(nameLabel!.snp_bottom)
            make.left.equalTo(imgView!.snp_right).offset(8)
            make.size.equalTo(CGSize(width: SCREEN_WIDTH-8-54-8-8-80-10, height: 32))
        })
    }
    
    func update(_ model: CarModel) {
        
        if model.url != nil {
            imgView?.image = UIImage(named: model.url!)
        }
        nameLabel?.text = model.name
        numbelLabel?.text = model.numbel
    }
    
    class func height() -> CGFloat {
        
        return 81
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}






