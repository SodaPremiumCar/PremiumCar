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
    var isFromRegister = true
    var logoutBtn: UIButton?
    var suggestionBtn: UIButton?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.hidesBackButton = isFromRegister
        setupUI()
        
        if isFromRegister {
            self.navigationItem.title = "填写个人信息"
            
        }else{
            self.navigationItem.title = "个人信息"
            submitBtn?.setTitle("修改", for: UIControlState.normal)
            loadPersonInfo()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.isNavigationBarHidden = false
    }
    
    fileprivate func setupUI() {
    
        self.view.backgroundColor = COLOR_BLACK
        
        let infoImg = UIImageView(frame: CGRect(x: (SCREEN_WIDTH - 100) * 0.5, y: 86, width: 100, height: 100))
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
        
        if !isFromRegister {
        
            logoutBtn = UIButton(type: UIButtonType.custom)
            logoutBtn?.frame = CGRect(x: 0, y: SCREEN_HEIGHT - 44 - 64, width: SCREEN_WIDTH, height: 44)
            logoutBtn?.backgroundColor = FUZZY_BACK
            logoutBtn?.setTitle("退出登录", for: UIControlState.normal)
            logoutBtn?.titleLabel?.font = UIFont.systemFont(ofSize: 14)
            logoutBtn?.addTarget(self, action: #selector(logout), for: UIControlEvents.touchUpInside)
            let line = UIView(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: 0.5))
            line.backgroundColor = FUZZY_BACK
            logoutBtn?.addSubview(line)
            view.addSubview(logoutBtn!)
            
            suggestionBtn = UIButton(frame: CGRect(x: 30, y: (submitBtn?.frame.maxY)! + 10, width: 80, height: 15))
            suggestionBtn?.setImage(UIImage(named: "suggestion"), for: .normal)
            suggestionBtn?.setTitle("意见反馈", for: .normal)
            suggestionBtn?.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0)
            suggestionBtn?.imageView?.contentMode = .scaleAspectFit
            suggestionBtn?.titleLabel?.font = UIFont.systemFont(ofSize: 11)
            suggestionBtn?.addTarget(self, action: #selector(giveSuggestionBtn), for: UIControlEvents.touchUpInside)
            view.addSubview(suggestionBtn!)
        }
    }
    
    // 反馈意见
    func giveSuggestionBtn() {
        
        let suggestionVC = SuggestionVC()
        navigationController?.pushViewController(suggestionVC, animated: true)
    }
    // 显示个人信息
    func loadPersonInfo() {
        UserData.share.load()
        if (UserData.share.name != nil) {
            nameTxt?.text = UserData.share.name
        }
        if (UserData.share.telephone != nil) {
            phoneText?.text = UserData.share.telephone
        }
        if (UserData.share.address != nil) {
            addressText?.text = UserData.share.address
        }
    }
    // 登出
    func logout() {
        
        let actionSheet = UIAlertController(title: "是否退出登录", message: nil, preferredStyle: .actionSheet)
        let logoutAction = UIAlertAction(title: "退出", style: UIAlertActionStyle.destructive) { (UIAlertAction) in
            UserData.share.logout()
            
            let loginVC = LoginViewController()
            self.navigationController?.pushViewController(loginVC, animated: false)
        }
        let cancleAction = UIAlertAction(title: "取消", style: .cancel) { (UIAlertAction) in
            
        }
        actionSheet.addAction(logoutAction)
        actionSheet.addAction(cancleAction)
        self.present(actionSheet, animated: true, completion: nil)
    }
    
    func submitInfo() {
        
        TZNetworkTool.shareNetworkTool.personalInfo(telephone: (phoneText?.text)!, name: (nameTxt?.text)!, addr: (addressText?.text)!) { (isSuccess) in
            if isSuccess {
                
                if self.isFromRegister {
                    
                    let carBrandsVC = CarBrandsVC()
                    self.navigationController?.pushViewController(carBrandsVC, animated: true)
                }else{
                    self.navigationController?.popViewController(animated: true)
                }
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

