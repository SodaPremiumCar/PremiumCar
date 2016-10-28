//
//  MyCarCell.swift
//  PremiumCar
//
//  Created by 赵霆 on 16/9/13.
//  Copyright © 2016年 soda. All rights reserved.
//

import UIKit

class MyCarCell: UICollectionViewCell {
    
    fileprivate lazy var imageView: UIImageView = {
       
        let imageView = UIImageView()
        imageView.contentMode = UIViewContentMode.scaleAspectFill
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    fileprivate lazy var carTypeLabel: UILabel = {
       
        let carTypeLabel = UILabel()
        carTypeLabel.textColor = UIColor.white
        carTypeLabel.font = UIFont.systemFont(ofSize: 14)
        return carTypeLabel
    }()
    
    fileprivate lazy var licenseLable: UILabel = {
        
        let licenseLable = UILabel()
        licenseLable.textColor = UIColor.white
        licenseLable.textAlignment = NSTextAlignment.right
        licenseLable.font = UIFont.systemFont(ofSize: 12)
        return licenseLable
    }()
    
    var dataSource: CarModel? {
        
        didSet{
            
            imageView.image = UIImage(named: dataSource!.url!)
            carTypeLabel.text = dataSource!.name
            licenseLable.text = dataSource!.numbel
        }
    }
    
    override func layoutSubviews() {
        
        let width = self.frame.width
        let height = self.frame.height
        
        imageView.frame = CGRect(x: 0, y: 0, width: width, height: width)
        carTypeLabel.frame = CGRect(x: 2, y: width + 7, width: width, height: height - width)
        carTypeLabel.sizeToFit()
        licenseLable.frame = CGRect(x: carTypeLabel.frame.maxX, y: width, width: width - carTypeLabel.frame.maxX - 5, height: height - width)
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = COLOR_BLACK
        addSubview(imageView)
        addSubview(carTypeLabel)
        addSubview(licenseLable)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
