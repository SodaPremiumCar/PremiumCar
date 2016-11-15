//
//  File.swift
//  PremiumCar
//
//  Created by ethen on 2016/11/15.
//  Copyright © 2016年 soda. All rights reserved.
//

import Foundation

extension UILabel {
    
    func mix(img: UIImage, text: String, imgSize: CGSize) {
        
        let imgAttach = NSTextAttachment()
        imgAttach.bounds = CGRect.init(x: 0, y: -2, width: imgSize.width, height: imgSize.height)
        imgAttach.image = img
        let imgString = NSAttributedString(attachment: imgAttach)
        
        let rightText = "   " + text
        let rightString = NSAttributedString(string: rightText)
        
        let attributedString = NSMutableAttributedString()
        attributedString.append(imgString)
        attributedString.append(rightString)
        attributedText = attributedString
    }
}










