//
//  ToolLet.swift
//  IM
//
//  Created by ethen on 16/9/3.
//  Copyright © 2016年 ethan. All rights reserved.
//

import UIKit

let SCREEN_WIDTH    = UIScreen.main.bounds.width
let SCREEN_HEIGHT   = UIScreen.main.bounds.height

func RGBA (_ r:CGFloat, g:CGFloat, b:CGFloat, a:CGFloat) -> UIColor {
    
    return UIColor (red: r/255.0, green: g/255.0, blue: b/255.0, alpha: a)
}
// button样式
func setButton(button: UIButton, with type: Int){
    
    if type == 0 {
        
        button.setTitleColor(RGBA(255, g: 255, b: 255, a: 0.4), for: UIControlState.normal)
        button.isEnabled = false
    }else{
        
        button.setTitleColor(UIColor.white, for: UIControlState.normal)
        button.isEnabled = true
    }
}

func PostNotification(_ name: String, object: AnyObject?, userInfo: [AnyHashable: Any]?) {
    
    NotificationCenter.default.post(name: Notification.Name(rawValue: name), object: object, userInfo: userInfo)
}

func AddObserver(_ observer: AnyObject, selector: Selector, name: String?, object: AnyObject?) {
    
    NotificationCenter.default.addObserver(observer, selector: selector, name: name.map { NSNotification.Name(rawValue: $0) }, object: object)
}

func sizeForString(_ string: String, width: CGFloat, height: CGFloat, font: UIFont) -> CGSize {
    
    let attrStr: NSMutableAttributedString = NSMutableAttributedString(string: string)
    attrStr.addAttribute(NSFontAttributeName, value:font, range: NSMakeRange(0, attrStr.length))
    let sizeToFit: CGSize = attrStr.boundingRect(with: CGSize(width: width, height: height), options: .usesLineFragmentOrigin, context: nil).size
    return sizeToFit
}

func imageWithColor(_ color: UIColor) -> UIImage {
    
    let rect = CGRect(x: 0.0, y: 0.0, width: 1.0, height: 1.0)
    UIGraphicsBeginImageContext(rect.size)
    let context = UIGraphicsGetCurrentContext()
    context?.setFillColor(color.cgColor)
    context?.fill(rect)
    let theImage = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    return theImage!
}


