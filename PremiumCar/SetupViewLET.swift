//
//  SetupViewLET.swift
//  PremiumCar
//
//  Created by ethen on 16/9/6.
//  Copyright © 2016年 soda. All rights reserved.
//

import UIKit

func setupButton(_ rect: CGRect, title: String, tag: NSInteger, target: AnyObject, selector: Selector) -> UIButton {
    
    let button = UIButton(type: .custom)
    button.frame = rect
    button.tag = tag
    button.backgroundColor = RGBA(0, g: 0, b: 0, a: 1)
    button.titleLabel?.font = UIFont.systemFont(ofSize: 19)
    button.setTitle(title, for: UIControlState())
    button.setTitleColor(UIColor.white, for: UIControlState())
    button.addTarget(target, action: selector, for: .touchUpInside)
    
    return button
}
