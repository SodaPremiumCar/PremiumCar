//
//  SubmitVC.swift
//  PremiumCar
//
//  Created by ethen on 16/9/12.
//  Copyright © 2016年 soda. All rights reserved.
//

import UIKit

class SubmitVC: UIViewController, UITextFieldDelegate, UITableViewDelegate, UITableViewDataSource {
    
    private var submitBtn: UIButton!
    fileprivate var tableView: UITableView!
    fileprivate var phoneTextField: UITextField!
    fileprivate var nameTextField: UITextField!
    fileprivate var addressTextField: UITextField!
    fileprivate var dateTextField: UITextField!
    fileprivate var datePicker: UIDatePicker!
    fileprivate var datePickerButton: UIButton!
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.initNavigation()
        self.initUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
    }
    
    //MARK: UI
    func initNavigation() {
        
        self.navigationItem.title = "生成订单"
    }
    
    func initUI() {
        
        self.view.backgroundColor = UIColor.black
        
        self.tableView = UITableView(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: SCREEN_HEIGHT - 50 - 64), style: .plain)
        self.tableView.backgroundColor = UIColor.black
        self.tableView.separatorColor = UIColor.init(colorLiteralRed: 100, green: 100, blue: 100, alpha: 1)
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "UITableViewCellIdentifier")
        self.view.addSubview(self.tableView)
        self.tableView.tableFooterView = UIView(frame: CGRect.zero)
        
        nameTextField = self.getTextField()
        phoneTextField = self.getTextField()
        phoneTextField.keyboardType = .numberPad
        addressTextField = self.getTextField()
        dateTextField = self.getTextField()
        
        let submitView = UIView(frame: CGRect(x: 0, y: SCREEN_HEIGHT - 50 - 64, width: SCREEN_WIDTH, height: 50))
        submitView.backgroundColor = FUZZY_BACK
        
        // UI线
        let lineW = UIView(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: 0.5))
        lineW.backgroundColor = FUZZY_BACK
        let lineH = UIView(frame: CGRect(x: SCREEN_WIDTH - 120, y: 10, width: 0.5, height: 30))
        lineH.backgroundColor = FUZZY_BACK
        // 提交btn
        submitBtn = UIButton(type: UIButtonType.custom)
        submitBtn.frame = CGRect(x: SCREEN_WIDTH - 110, y: 0, width: 100, height: 50)
        submitBtn.setTitle("提交订单", for: UIControlState.normal)
        submitBtn.backgroundColor = UIColor.clear
        submitBtn?.addTarget(self, action: #selector(buttonClicked(_:)), for: UIControlEvents.touchUpInside)
        setButton(button: submitBtn, with: 1)
        
        submitView.addSubview(submitBtn)
        submitView.addSubview(lineW)
        submitView.addSubview(lineH)
        view.addSubview(submitView)
        
        datePicker = UIDatePicker()
        datePicker.frame = CGRect(x: 0, y: self.view.frame.height + 30, width: SCREEN_WIDTH, height: 260)
        datePicker.backgroundColor = RGBA(230, g: 230, b: 230, a: 1)
        datePicker.setDate(Date(), animated: false)
        datePicker.datePickerMode = UIDatePickerMode.dateAndTime
        datePicker.minuteInterval = 60 * 60
        datePicker.minimumDate = Date()
        datePicker.addTarget(self, action:#selector(SubmitVC.datePickerValueChange(_:)), for: UIControlEvents.valueChanged)
        self.view.addSubview(datePicker)
        
        datePickerButton = UIButton(type: .custom)
        datePickerButton.frame = CGRect(x: 0, y: self.view.frame.height, width: SCREEN_WIDTH, height: 30)
        datePickerButton.backgroundColor = RGBA(230, g: 230, b: 230, a: 1)
        datePickerButton.setTitle("选定预约", for: UIControlState())
        datePickerButton.setTitleColor(UIColor.black, for: UIControlState())
        datePickerButton.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        datePickerButton.addTarget(self, action: #selector(buttonClicked(_:)), for: .touchUpInside)
        self.view.addSubview(datePickerButton)
        
        //default text
        nameTextField.text = UserData.share.name != nil ? UserData.share.name : "请填写您的姓名"
        phoneTextField.text = UserData.share.mobileNo != nil ? UserData.share.mobileNo : "联系电话"
        addressTextField.text = UserData.share.address != nil ? UserData.share.address : "联系地址"
        self.datePickerValueChange(datePicker)
    }
    
    func getTextField() -> UITextField {
        
        let textField = UITextField(frame: CGRect(x: 30, y: 10, width: SCREEN_WIDTH - 30, height: 40))
        textField.backgroundColor = UIColor.black
        textField.textColor = UIColor.white
        textField.delegate = self
        textField.borderStyle = .none
        textField.font = UIFont.systemFont(ofSize: 16)
        textField.keyboardAppearance = .light
        textField.returnKeyType = .done
        
        return textField
    }
    
    func showDatePicker() {
        
        UIView.animate(withDuration: 0.25, animations: { 
            self.datePicker.frame = CGRect(x: 0, y: self.view.frame.height - 260, width: SCREEN_WIDTH, height: 300)
            self.datePickerButton.frame = CGRect(x: 0, y: self.view.frame.height - 260 - 30, width: SCREEN_WIDTH, height: 30)
        }) 
    }
    
    func hideDatePicker() {
        
        UIView.animate(withDuration: 0.25, animations: {
            self.datePicker.frame = CGRect(x: 0, y: self.view.frame.height + 30, width: SCREEN_WIDTH, height: 260)
            self.datePickerButton.frame = CGRect(x: 0, y: self.view.frame.height, width: SCREEN_WIDTH, height: 30)
        }) 
    }
    
    func datePickerValueChange(_ picker: UIDatePicker) {
      
        let formatter: DateFormatter = DateFormatter()
        formatter.dateFormat = "MM月dd日 hh:mm"
//        formatter.setLocalizedDateFormatFromTemplate("MM月dd日 hh-mm")
        dateTextField.text = formatter.string(from: picker.date)
    }
    
    //MARK: Handle
    func buttonClicked(_ sender: UIButton) {
        
        if sender == datePickerButton {
            self.hideDatePicker()
        }else {
            let title = String(format: "%@，您的联系方式为%@，预约时间为%@", nameTextField.text!, phoneTextField.text!, dateTextField.text!)
            let alert: UIAlertController = UIAlertController(title: title, message: "", preferredStyle: .alert)
        let action0: UIAlertAction = UIAlertAction(title: "提交", style: .default) { (alert) in
            
//            let promptVC = PromptVC()
//            self.navigationController?.pushViewController(promptVC, animated: true)
        }
        let action1: UIAlertAction = UIAlertAction(title: "取消", style: .cancel) { (alert) in
        }
        alert.addAction(action0)
        alert.addAction(action1)
        self.present(alert, animated: true) {
        }
        }
    }
    
    //MARK: UITextFieldDelegate
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        
        if textField == dateTextField {
            self.showDatePicker()
            nameTextField.resignFirstResponder()
            phoneTextField.resignFirstResponder()
            dateTextField.resignFirstResponder()
            
            return false
        }else {
            self.hideDatePicker()
            return true
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
        return true
    }
    
    //MARK: Request
  
    //MARK: TableViewDelegate
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 4
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 60
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        
        return UIView()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCellIdentifier", for: indexPath)
        cell.selectionStyle = .none
        cell.backgroundColor = UIColor.black
        for subview in cell.contentView.subviews {
            subview.removeFromSuperview()
        }
        
        if (indexPath as NSIndexPath).row == 0 {
            cell.contentView.addSubview(nameTextField)
        }else if (indexPath as NSIndexPath).row == 1 {
            cell.contentView.addSubview(phoneTextField)
        }else if (indexPath as NSIndexPath).row == 2 {
            cell.contentView.addSubview(addressTextField)
        }else {
            cell.contentView.addSubview(dateTextField)
        }
    
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        nameTextField.resignFirstResponder()
        phoneTextField.resignFirstResponder()
        dateTextField.resignFirstResponder()
        self.hideDatePicker()
    }
}
