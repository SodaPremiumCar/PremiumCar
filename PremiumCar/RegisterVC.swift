//
//  RegisterVC.swift
//  PremiumCar
//
//  Created by 赵霆 on 16/10/24.
//  Copyright © 2016年 soda. All rights reserved.
//

import UIKit

class RegisterVC: UIViewController {
    
    var mobileNo: UITextField?
    var verificationText: UITextField?
    var verificationBtn: TimeButton?
    var password: UITextField?
    
    var registerBtn: UIButton?
    var loginBtn: UIButton?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        verificationBtn?.stop("获取验证码")
    }
    
    fileprivate func setupUI() {

        self.view.backgroundColor = COLOR_BLACK
        
        let registerImg = UIImageView(frame: CGRect(x: (SCREEN_WIDTH - 100) * 0.5, y: 150, width: 100, height: 100))
        registerImg.image = UIImage(named:"registerNumber")
        view.addSubview(registerImg)
        
        mobileNo = UITextField(frame: CGRect(x: 30, y:(registerImg.frame.maxY) + 15, width: SCREEN_WIDTH - 60, height: 40))
        mobileNo?.attributedPlaceholder = NSAttributedString(string:"手机号", attributes: [NSForegroundColorAttributeName: UIColor.white])
        mobileNo?.borderStyle = UITextBorderStyle.roundedRect
        mobileNo?.backgroundColor = FUZZY_BACK
        mobileNo?.textColor = UIColor.white
        mobileNo?.keyboardType = UIKeyboardType.numberPad
        mobileNo?.returnKeyType = UIReturnKeyType.done
        mobileNo?.delegate = self
        mobileNo?.addTarget(self, action: #selector(textFieldDidChange), for: UIControlEvents.allEditingEvents)
        view.addSubview(mobileNo!)
        
        verificationText = UITextField(frame: CGRect(x: 30, y:(mobileNo?.frame.maxY)! + 12, width: SCREEN_WIDTH - 150, height: 40))
        verificationText?.attributedPlaceholder = NSAttributedString(string:"验证码", attributes: [NSForegroundColorAttributeName: UIColor.white])
        verificationText?.borderStyle = UITextBorderStyle.roundedRect
        verificationText?.backgroundColor = FUZZY_BACK
        verificationText?.textColor = UIColor.white
        verificationText?.keyboardType = UIKeyboardType.numberPad
        verificationText?.returnKeyType = UIReturnKeyType.done
        verificationText?.delegate = self
        verificationText?.addTarget(self, action: #selector(textFieldDidChange), for: UIControlEvents.allEditingEvents)
        view.addSubview(verificationText!)
        
        verificationBtn = TimeButton(type: UIButtonType.roundedRect)
        verificationBtn?.frame = CGRect(x: (verificationText?.frame.maxX)! + 10, y: (mobileNo?.frame.maxY)! + 12, width: 80, height: 40)
        verificationBtn?.timeButtonDelegate = self
        verificationBtn?.layer.cornerRadius = 4
        verificationBtn?.layer.borderWidth = 0.7
        verificationBtn?.layer.borderColor = FUZZY_BACK.cgColor
        verificationBtn?.layer.masksToBounds = true
        verificationBtn?.buttonUsableStatus = true
        verificationBtn?.setTitle("获取验证码", for: UIControlState.normal)
        verificationBtn?.titleLabel?.adjustsFontSizeToFitWidth = true
        verificationBtn?.addTarget(self, action: #selector(getVerification), for: UIControlEvents.touchUpInside)
        setButton(button: verificationBtn!, with: 0)
        view.addSubview(verificationBtn!)
        
        password = UITextField(frame: CGRect(x: 30, y: (verificationBtn?.frame.maxY)! + 12, width: SCREEN_WIDTH - 60, height: 40))
        password?.attributedPlaceholder = NSAttributedString(string:"密码", attributes: [NSForegroundColorAttributeName: UIColor.white])
        password?.backgroundColor = FUZZY_BACK
        password?.isSecureTextEntry = true
        password?.textColor = UIColor.white
        password?.borderStyle = UITextBorderStyle.roundedRect
        password?.keyboardType = UIKeyboardType.default
        password?.returnKeyType = UIReturnKeyType.done
        password?.delegate = self
        password?.addTarget(self, action: #selector(textFieldDidChange), for: UIControlEvents.allEditingEvents)
        view.addSubview(password!)
        let show = UIButton(frame: CGRect(x: SCREEN_WIDTH - 70, y: (verificationBtn?.frame.maxY)! + 12, width: 40, height: 40))
        show.setImage(UIImage(named:"eye"), for: UIControlState.normal)
        show.addTarget(self, action: #selector(showPassword), for: UIControlEvents.touchUpInside)
        view.addSubview(show)
        
        registerBtn = UIButton(type: UIButtonType.roundedRect)
        registerBtn?.frame = CGRect(x: 30, y: (password?.frame.maxY)! + 12, width: SCREEN_WIDTH - 60, height: 40)
        registerBtn?.layer.cornerRadius = 4
        registerBtn?.layer.borderWidth = 0.7
        registerBtn?.layer.borderColor = FUZZY_BACK.cgColor
        registerBtn?.layer.masksToBounds = true
        registerBtn?.backgroundColor = UIColor.clear
        registerBtn?.setTitle("注册", for: UIControlState.normal)
        registerBtn?.addTarget(self, action: #selector(register), for: UIControlEvents.touchUpInside)
        setButton(button: registerBtn!, with: 0)
        view.addSubview(registerBtn!)
        
        loginBtn = UIButton(type: UIButtonType.custom)
        loginBtn?.frame = CGRect(x: 0, y: SCREEN_HEIGHT - 44, width: SCREEN_WIDTH, height: 44)
        loginBtn?.backgroundColor = FUZZY_BACK
        loginBtn?.setTitle("已有账户？登录。", for: UIControlState.normal)
        loginBtn?.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        loginBtn?.addTarget(self, action: #selector(backToLogin), for: UIControlEvents.touchUpInside)
        let line = UIView(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: 0.5))
        line.backgroundColor = FUZZY_BACK
        loginBtn?.addSubview(line)
        view.addSubview(loginBtn!)
        
    }
        
    func getVerification() {
        //获取验证码
        TZNetworkTool.shareNetworkTool.getVerificationCode(mobileNo: (mobileNo?.text)!) { (isSuccess) in
            if isSuccess {
                self.verificationBtn?.setTime(60)
            }
        }
    }
    
    func register() {
        
        print("注册")
        TZNetworkTool.shareNetworkTool.register(mobileNo: mobileNo!.text!, dynamicPws: verificationText!.text!, pwd: password!.text!) { (isSuccess) in
            if isSuccess {
                let personalVC = PersonalInfoVC()
                self.navigationController?.pushViewController(personalVC, animated: true)
            }
        }
    }
    
    func showPassword() {
        password?.isSecureTextEntry = !((password?.isSecureTextEntry)!)
    }
    
    func backToLogin() {
        
        print("退回登录页")
        self.navigationController?.popViewController(animated: true)
    }
    
    func textFieldDidChange() {
        
        if mobileNo?.text?.characters.count == 11 && verificationBtn?.buttonUsableStatus == true {
            
            setButton(button: verificationBtn!, with: 1)
        }else{
            setButton(button: verificationBtn!, with: 0)
        }
        
        if mobileNo?.text?.characters.count == 11 && verificationText?.text?.characters.count != 0 && password?.text?.characters.count != 0 {
            
            setButton(button: registerBtn!, with: 1)
        }else{
            setButton(button: registerBtn!, with: 0)
        }
    }
}

extension RegisterVC: UITextFieldDelegate,TimeButtonDelegate {
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        mobileNo?.resignFirstResponder()
        verificationText?.resignFirstResponder()
        password?.resignFirstResponder()
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if textField == mobileNo {
            if range.location == 11 {
                return false
            }
        }
        return true
    }
    
    func updateTimeButtonStatus() {
        
        textFieldDidChange()
    }
}
