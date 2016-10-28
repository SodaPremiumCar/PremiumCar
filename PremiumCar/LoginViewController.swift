//
//  LoginViewController.swift
//  PremiumCar
//
//  Created by 赵霆 on 16/10/24.
//  Copyright © 2016年 soda. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    var mobileNo: UITextField?
    var password: UITextField?
    var loginBtn: UIButton?
    var registerBtn: UIButton?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    // 隐藏状态栏
//    override func
    
    private func setupUI() {
        self.navigationController?.isNavigationBarHidden = true
        self.view.backgroundColor = COLOR_BLACK
        
        let carImage = UIImageView(frame: CGRect(x: (SCREEN_WIDTH - 100) * 0.5, y: 150, width: 100, height: 100))
        carImage.image = UIImage(named: "carIcon")
        view.addSubview(carImage)
        
        mobileNo = UITextField(frame: CGRect(x: 30, y:(carImage.frame.maxY) + 15, width: SCREEN_WIDTH - 60, height: 40))
        mobileNo?.attributedPlaceholder = NSAttributedString(string:"帐号", attributes: [NSForegroundColorAttributeName: UIColor.white])
        mobileNo?.borderStyle = UITextBorderStyle.roundedRect
        mobileNo?.backgroundColor = FUZZY_BACK
        mobileNo?.textColor = UIColor.white
        mobileNo?.keyboardType = UIKeyboardType.numberPad
        mobileNo?.returnKeyType = UIReturnKeyType.done
        mobileNo?.delegate = self
        mobileNo?.addTarget(self, action: #selector(textFieldDidChange), for: UIControlEvents.allEditingEvents)
        view.addSubview(mobileNo!)
        
        password = UITextField(frame: CGRect(x: 30, y: (mobileNo?.frame.maxY)! + 12, width: SCREEN_WIDTH - 60, height: 40))
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
        
        loginBtn = UIButton(type: UIButtonType.roundedRect)
        loginBtn?.frame = CGRect(x: 30, y: (password?.frame.maxY)! + 12, width: SCREEN_WIDTH - 60, height: 40)
        loginBtn?.layer.cornerRadius = 4
        loginBtn?.layer.borderWidth = 0.7
        loginBtn?.layer.borderColor = FUZZY_BACK.cgColor
        loginBtn?.layer.masksToBounds = true
        loginBtn?.backgroundColor = UIColor.clear
        loginBtn?.setTitle("登录", for: UIControlState.normal)
        setButton(button: loginBtn!, with: 0)
        loginBtn?.setTitleColor(RGBA(255, g: 255, b: 255, a: 0.4), for: UIControlState.normal)
        loginBtn?.addTarget(self, action: #selector(login), for: UIControlEvents.touchUpInside)
        view.addSubview(loginBtn!)
        
        registerBtn = UIButton(type: UIButtonType.custom)
        registerBtn?.frame = CGRect(x: 0, y: SCREEN_HEIGHT - 44, width: SCREEN_WIDTH, height: 44)
        registerBtn?.backgroundColor = FUZZY_BACK
        registerBtn?.setTitle("还没有账户？注册。", for: UIControlState.normal)
        registerBtn?.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        registerBtn?.addTarget(self, action: #selector(register), for: UIControlEvents.touchUpInside)
        let line = UIView(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: 0.5))
        line.backgroundColor = FUZZY_BACK
        registerBtn?.addSubview(line)
        view.addSubview(registerBtn!)
    }
    
    func textFieldDidChange() {
        
        if mobileNo?.text?.characters.count == 11 && password?.text?.characters.count != 0 {
            
            setButton(button: loginBtn!, with: 1)
        }else{
            setButton(button: loginBtn!, with: 0)
        }
    }
    
    func login() {
        
        TZNetworkTool.shareNetworkTool.login(mobileNo: (mobileNo?.text)!, pwd: (password?.text)!) { (isSuccess) in
            if isSuccess {
                let viewController = ViewController()
                self.navigationController?.pushViewController(viewController, animated: true)
            }
        }
    }
    
    func register() {
        
        let registerVC = RegisterVC()
        navigationController?.pushViewController(registerVC, animated: true)
    }
    
}

extension LoginViewController: UITextFieldDelegate {
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        mobileNo?.resignFirstResponder()
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
}
