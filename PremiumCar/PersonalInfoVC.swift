//
//  PersonalInfoVC.swift
//  PremiumCar
//
//  Created by 赵霆 on 16/10/25.
//  Copyright © 2016年 soda. All rights reserved.
//

import UIKit

class PersonalInfoVC: UIViewController {
    
    var nameTxt: UITextField?
    var addressText: UITextField?
    var phoneText: UITextField?
    
    var submitBtn: UIButton?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//        
//        self.navigationController?.isNavigationBarHidden = true
//    }
    
    fileprivate func setupUI() {
    
        self.view.backgroundColor = COLOR_BLACK
        
        let infoImg = UIImageView(frame: CGRect(x: (SCREEN_WIDTH - 100) * 0.5, y: 150, width: 100, height: 100))
        infoImg.image = UIImage(named:"personalInfo")
        view.addSubview(infoImg)
        
        nameTxt = UITextField(frame: CGRect(x: 30, y:(infoImg.frame.maxY) + 15, width: SCREEN_WIDTH - 60, height: 40))
        nameTxt?.attributedPlaceholder = NSAttributedString(string:"真实姓名", attributes: [NSForegroundColorAttributeName: UIColor.white])
        nameTxt?.borderStyle = UITextBorderStyle.roundedRect
        nameTxt?.backgroundColor = FUZZY_BACK
        nameTxt?.textColor = UIColor.white
        nameTxt?.keyboardType = UIKeyboardType.default
        nameTxt?.returnKeyType = UIReturnKeyType.done
        nameTxt?.delegate = self
        nameTxt?.addTarget(self, action: #selector(textFieldDidChange), for: UIControlEvents.allEditingEvents)
        view.addSubview(nameTxt!)
        
        phoneText = UITextField(frame: CGRect(x: 30, y:(nameTxt?.frame.maxY)! + 12, width: SCREEN_WIDTH - 60, height: 40))
        phoneText?.attributedPlaceholder = NSAttributedString(string:"联系电话", attributes: [NSForegroundColorAttributeName: UIColor.white])
        phoneText?.borderStyle = UITextBorderStyle.roundedRect
        phoneText?.backgroundColor = FUZZY_BACK
        phoneText?.textColor = UIColor.white
        phoneText?.keyboardType = UIKeyboardType.numberPad
        phoneText?.returnKeyType = UIReturnKeyType.done
        phoneText?.delegate = self
        phoneText?.addTarget(self, action: #selector(textFieldDidChange), for: UIControlEvents.allEditingEvents)
        view.addSubview(phoneText!)
        
        addressText = UITextField(frame: CGRect(x: 30, y:(phoneText?.frame.maxY)! + 12, width: SCREEN_WIDTH - 60, height: 40))
        addressText?.attributedPlaceholder = NSAttributedString(string:"地址", attributes: [NSForegroundColorAttributeName: UIColor.white])
        addressText?.borderStyle = UITextBorderStyle.roundedRect
        addressText?.backgroundColor = FUZZY_BACK
        addressText?.clearButtonMode = UITextFieldViewMode.whileEditing
        addressText?.textColor = UIColor.white
        addressText?.keyboardType = UIKeyboardType.default
        addressText?.returnKeyType = UIReturnKeyType.done
        addressText?.delegate = self
        addressText?.addTarget(self, action: #selector(textFieldDidChange), for: UIControlEvents.allEditingEvents)
        view.addSubview(addressText!)
        
        submitBtn = UIButton(type: UIButtonType.roundedRect)
        submitBtn?.frame = CGRect(x: 30, y: (addressText?.frame.maxY)! + 12, width: SCREEN_WIDTH - 60, height: 40)
        submitBtn?.layer.cornerRadius = 4
        submitBtn?.layer.borderWidth = 0.7
        submitBtn?.layer.borderColor = FUZZY_BACK.cgColor
        submitBtn?.layer.masksToBounds = true
        submitBtn?.backgroundColor = UIColor.clear
        submitBtn?.setTitle("提交", for: UIControlState.normal)
        submitBtn?.addTarget(self, action: #selector(submitInfo), for: UIControlEvents.touchUpInside)
        setButton(button: submitBtn!, with: 0)
        view.addSubview(submitBtn!)
        
    }
    
    func submitInfo() {
        
        TZNetworkTool.shareNetworkTool.personalInfo(telephone: (phoneText?.text)!, name: (nameTxt?.text)!, addr: (addressText?.text)!) { (isSuccess) in
            if isSuccess {
                let carBrandsVC = CarBrandsVC()
                self.navigationController?.pushViewController(carBrandsVC, animated: true)
            }
        }
    }
    
    func textFieldDidChange() {
        
        if phoneText?.text?.characters.count == 11 && nameTxt?.text?.characters.count != 0 && addressText?.text?.characters.count != 0 {
            
            setButton(button: submitBtn!, with: 1)
        }else{
            setButton(button: submitBtn!, with: 0)
        }
    }
}

extension PersonalInfoVC: UITextFieldDelegate {
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        nameTxt?.resignFirstResponder()
        phoneText?.resignFirstResponder()
        addressText?.resignFirstResponder()
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if textField == phoneText {
            if range.location == 11 {
                return false
            }
        }
        return true
    }
}

