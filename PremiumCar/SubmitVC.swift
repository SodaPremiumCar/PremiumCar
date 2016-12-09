//
//  SubmitVC.swift
//  PremiumCar
//
//  Created by ethen on 16/9/12.
//  Copyright © 2016年 soda. All rights reserved.
//

import UIKit
import SVProgressHUD
import CoreLocation

class SubmitVC: UIViewController, UITextFieldDelegate, UITableViewDelegate, UITableViewDataSource, CLLocationManagerDelegate {
    
    var carModel: CarTModel!    //车型model
    var idStr: Int!                     //车的id
    var serviceItems: [ServiceItemModel]!   //选择服务的model数组
    
    fileprivate var submitBtn: UIButton!
    fileprivate var getLocationBtn: UIButton!
    fileprivate var tableView: UITableView!
    fileprivate var phoneTextField: UITextField!
    fileprivate var nameTextField: UITextField!
    fileprivate var addressTextView: UITextView!
    fileprivate var dateTextField: UITextField!
    fileprivate var datePicker: UIDatePicker!
    fileprivate var datePickerButton: UIButton!
    
    var locationManager: CLLocationManager!
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        if CLLocationManager.locationServicesEnabled() == true {
            self.locationManager = CLLocationManager()
            self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
            self.locationManager.distanceFilter = kCLLocationAccuracyKilometer
        }else {
        }
        
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
        stopUpdatingLocation()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
    }
    
    //MARK: UI
    func initNavigation() {
        
        self.navigationItem.title = "填写订单"
    }
    
    func initUI() {
        
        self.view.backgroundColor = UIColor.black
        
        self.tableView = UITableView(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: SCREEN_HEIGHT - 50 - 64), style: .plain)
        self.tableView.backgroundColor = UIColor.black
        self.tableView.separatorStyle = .none
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.view.addSubview(self.tableView)
        self.tableView.tableFooterView = UIView(frame: CGRect.zero)
        
        nameTextField = self.getTextField()
        phoneTextField = self.getTextField()
        phoneTextField.keyboardType = .numberPad
        dateTextField = self.getTextField()
        
        addressTextView = UITextView(frame: CGRect(x: 80, y: 5, width: SCREEN_WIDTH - 110, height: 60))
        addressTextView.backgroundColor = RGBA(0, g: 0, b: 0, a: 1)
        addressTextView.textColor = UIColor.white
        addressTextView.font = UIFont.systemFont(ofSize: 14)
        addressTextView.keyboardAppearance = .light
        addressTextView.returnKeyType = .done
        
        getLocationBtn = UIButton(type: UIButtonType.custom)
        getLocationBtn.frame = CGRect(x: SCREEN_WIDTH - 140, y: 70, width: 120, height: 40)
        getLocationBtn.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        getLocationBtn.titleLabel?.textAlignment = .center
        getLocationBtn.setTitle("获取当前位置", for: .normal)
        getLocationBtn.setTitleColor(SEC_ORANGE, for: .normal)
        getLocationBtn.backgroundColor = UIColor.clear
        getLocationBtn.addTarget(self, action: #selector(buttonClicked(_:)), for: UIControlEvents.touchUpInside)
        
        //底部提交栏
        let submitView = UIView(frame: CGRect(x: 0, y: SCREEN_HEIGHT - 50 - 64, width: SCREEN_WIDTH, height: 50))
        submitView.backgroundColor = FUZZY_BACK
        
        // UI线
        let lineW = UIView(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: 0.5))
        lineW.backgroundColor = FUZZY_BACK
        let lineH = UIView(frame: CGRect(x: SCREEN_WIDTH - 120, y: 10, width: 0.5, height: 30))
        lineH.backgroundColor = FUZZY_BACK
        
        // 提交btn
        submitBtn = UIButton(type: UIButtonType.custom)
        submitBtn.frame = CGRect(x: SCREEN_WIDTH - 110, y: 0, width: 120, height: 50)
        submitBtn.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        submitBtn.titleLabel?.numberOfLines = 2
        submitBtn.titleLabel?.textAlignment = .center
        submitBtn.setTitleColor(SEC_ORANGE, for: .normal)
        submitBtn.backgroundColor = UIColor.clear
        submitBtn.addTarget(self, action: #selector(buttonClicked(_:)), for: UIControlEvents.touchUpInside)
        
        submitView.addSubview(submitBtn)
        submitView.addSubview(lineW)
        submitView.addSubview(lineH)
        view.addSubview(submitView)
        
        updateSubmitView()
        
        datePicker = UIDatePicker()
        datePicker.frame = CGRect(x: 0, y: self.view.frame.height + 30, width: SCREEN_WIDTH, height: 260)
        datePicker.backgroundColor = RGBA(230, g: 230, b: 230, a: 1)
        datePicker.setDate(Date(), animated: false)
        datePicker.datePickerMode = UIDatePickerMode.dateAndTime
        datePicker.minuteInterval = 30
        datePicker.minimumDate = Date()
        datePicker.addTarget(self, action:#selector(SubmitVC.datePickerValueChange(_:)), for: UIControlEvents.valueChanged)
        self.view.addSubview(datePicker)
        
        datePickerButton = UIButton(type: .custom)
        datePickerButton.frame = CGRect(x: 0, y: self.view.frame.height, width: SCREEN_WIDTH, height: 30)
        datePickerButton.backgroundColor = RGBA(230, g: 230, b: 230, a: 1)
        datePickerButton.setTitle("确定", for: UIControlState())
        datePickerButton.setTitleColor(SEC_ORANGE, for: UIControlState())
        datePickerButton.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        datePickerButton.addTarget(self, action: #selector(buttonClicked(_:)), for: .touchUpInside)
        self.view.addSubview(datePickerButton)
        
        //default text
        nameTextField.placeholder = "请填写您的姓名"
        phoneTextField.placeholder = "联系电话"
        nameTextField.text = UserData.share.name != nil ? UserData.share.name : ""
        phoneTextField.text = UserData.share.mobileNo != nil ? UserData.share.mobileNo : ""
        addressTextView.text = UserData.share.address != nil ? UserData.share.address : ""
        self.datePickerValueChange(datePicker)
    }
    
    func updateSubmitView() {
        
        if serviceItems.count > 0 {
            var total: Float = 0.0
            for model in serviceItems {
                total += model.price!
            }
            
            //加收10%服务费
            total *= 1.1
            
            let text = String(format: "%.2f元\n确认提交", total)
            submitBtn?.setTitle(text, for: UIControlState.normal)
        }else {
        }
    }
    
    func getTextField() -> UITextField {
        
        let textField = UITextField(frame: CGRect(x: 80, y: 5, width: SCREEN_WIDTH - 110, height: 30))
        textField.backgroundColor = RGBA(0, g: 0, b: 0, a: 1)
        textField.textColor = UIColor.white
        textField.delegate = self
        textField.borderStyle = .none
        textField.adjustsFontSizeToFitWidth = true
        textField.font = UIFont.systemFont(ofSize: 14)
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
        dateTextField.text = formatter.string(from: picker.date)
    }
    
    //MARK: Handle
    func buttonClicked(_ sender: UIButton) {
        
        if sender == datePickerButton {
            self.hideDatePicker()
        }else if sender == getLocationBtn {
            startUpdatingLocation()
        }else {
            
            guard nameTextField.text!.isEmpty == false &&
                        phoneTextField.text!.isEmpty == false &&
                        addressTextView.text!.isEmpty == false
            else {
                SVProgressHUD.showInfo(withStatus: "为确保您的爱车及时享受服务，请填写您的姓名、联系电话和取车地点")
                return
            }
            
            let licenseNum = (carModel.licenseNum != nil) ? carModel.licenseNum! : ""
            let content = carModel.brand! + " " + carModel.model! + "  (" + licenseNum + ")"
            let contacts = ["name" : (self.nameTextField.text != nil) ? self.nameTextField.text : "",
                            "addr" : (self.addressTextView.text != nil) ? self.addressTextView.text : "",
                            "telephone" : (self.phoneTextField.text != nil) ? self.phoneTextField.text : ""]
            let booking = (self.dateTextField.text != nil) ? self.dateTextField.text : ""
            var services = [AnyObject]()
            var total: Float = 0.0
            for model in self.serviceItems {
                total += model.price!
                var dic = [String : String]()
                dic["count"] = "1"
                dic["price"] = String(describing: model.price!)
                dic["id"] = String(describing: model.id!)
                let name: String = (model.name != nil) ? model.name! : ""
                let item: String = (model.item != nil) ? model.item! : ""
                dic["name"] = name + item
                services.append(dic as AnyObject)
            }
            TZNetworkTool.shareNetworkTool.createOrder(content: content, services: services, contacts: contacts as! [String : String], total: String(total), remark: "", carId: String(self.idStr!), carTypeId: String(describing: self.carModel.id!), booking: booking!, finished: { (isSuccess) in
                if isSuccess {
                    let promptVC = PromptVC()
                    self.navigationController?.pushViewController(promptVC, animated: true)
                }
            })
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
        
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if section == 0 {
            return 4
        }else if section == 1 {
            return 1
        }else {
            return serviceItems.count + 1
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 20
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return (indexPath.section == 0 && indexPath.row == 2) ? 110 : 40
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let label = UILabel(frame: CGRect.init(x: 0, y: 0, width: SCREEN_WIDTH, height: 30))
        label.textColor = RGBA(100, g: 100, b: 100, a: 1)
        label.backgroundColor = UIColor.black
        label.font = UIFont.systemFont(ofSize: 12)
        if section == 0 {
            label.text = "    联系方式"
        }else if section == 1 {
            label.text = "    车辆"
        }else {
            label.text = "    服务内容"
        }
        return label
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCellIdentifier")
        if cell == nil {
            cell = UITableViewCell(style: .value1, reuseIdentifier: "UITableViewCellIdentifier" as String?)
            cell?.selectionStyle = .none
            cell?.textLabel?.font = UIFont.systemFont(ofSize: 14)
            cell?.detailTextLabel?.font = UIFont.systemFont(ofSize: 14)
            cell?.textLabel?.numberOfLines = 0
            cell?.textLabel?.textColor = RGBA(200, g: 200, b: 200, a: 1)
            cell?.detailTextLabel?.textColor = RGBA(250, g: 250, b: 250, a: 1)
            cell?.backgroundColor = UIColor.black
        }

        cell?.detailTextLabel?.text = ""
        for subview in (cell?.contentView.subviews)! {
            subview.removeFromSuperview()
        }

        if indexPath.section == 0 {
            if (indexPath as NSIndexPath).row == 0 {
                cell?.textLabel?.text = "姓名"
                cell?.contentView.addSubview(nameTextField)
            }else if (indexPath as NSIndexPath).row == 1 {
                cell?.textLabel?.text = "联系电话"
                cell?.contentView.addSubview(phoneTextField)
            }else if (indexPath as NSIndexPath).row == 2 {
                cell?.textLabel?.text = "取车地点\n\n\n\n"
                cell?.contentView.addSubview(addressTextView)
                cell?.contentView.addSubview(getLocationBtn)
            }else {
                cell?.textLabel?.text = "预约时间"
                cell?.contentView.addSubview(dateTextField)
            }
            let line = UIView(frame: CGRect(x: 75, y: (indexPath.row == 2) ? 105 : 35, width: SCREEN_WIDTH - 100, height: 0.5))
            line.backgroundColor = FUZZY_BACK
            cell?.contentView.addSubview(line)
        }else if indexPath.section == 1 {
            let licenseNum = (carModel.licenseNum != nil) ? carModel.licenseNum! : ""
            cell?.textLabel?.text = carModel.brand! + " " + carModel.model! + "  (" + licenseNum + ")"
        }else {
            if serviceItems.count > indexPath.row {
                let model = serviceItems[indexPath.row]
                let price = String(format: "￥%.2f", model.price!)
                cell?.textLabel?.text = model.type! + " " + model.name!
                cell?.detailTextLabel?.text = price
            }else {
                if serviceItems.count > 0 {
                    var total: Float = 0.0
                    for model in serviceItems {
                        total += model.price!
                    }
                    cell?.textLabel?.text = "服务费（10%）"
                    cell?.detailTextLabel?.text = "￥\(total * 0.1)"
                }
            }
        }
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        nameTextField.resignFirstResponder()
        phoneTextField.resignFirstResponder()
        addressTextView.resignFirstResponder()
        dateTextField.resignFirstResponder()
        self.hideDatePicker()
    }
    
    
    //MARK: CoreLocationManager
    func startUpdatingLocation() {
        
        if self.locationManager != nil {
            self.locationManager.delegate = self
            self.locationManager.requestWhenInUseAuthorization()
            self.locationManager.startUpdatingLocation()
        }
    }
    
    func stopUpdatingLocation() {
        
        if self.locationManager != nil {
            self.locationManager!.stopUpdatingLocation()
            self.locationManager?.delegate = nil
        }
    }
    
    //获取位置的文字描述
    func getLocationDescription(location: CLLocation) {
        
        let geocoder = CLGeocoder()
        var p:CLPlacemark?
        geocoder.reverseGeocodeLocation(location, completionHandler: { (placemarks, error) -> Void in
            if error != nil {
                SVProgressHUD.showInfo(withStatus: "获取地址失败: \(error!.localizedDescription)")
                return
            }
            let pm = placemarks! as [CLPlacemark]
            if (pm.count > 0) {
                p = placemarks![0] as CLPlacemark
                //省市
                let administrativeArea = p?.administrativeArea != nil ? p!.administrativeArea! : ""
                //城市
                let locality = p?.locality != nil ? p!.locality! : ""
                //区
                let subLocality = p?.subLocality != nil ? p!.subLocality! : ""
                //街道
                let thoroughfare = p?.thoroughfare != nil ? p!.thoroughfare! : ""
                //门牌号
                let subThoroughfare = p?.subThoroughfare != nil ? p!.subThoroughfare! : ""
                
                self.addressTextView.text = administrativeArea + " " + locality + " " + subLocality + " " + thoroughfare + " " + subThoroughfare
            }
        })
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        stopUpdatingLocation()
        let location: CLLocation = locations[locations.count - 1] as CLLocation
        getLocationDescription(location: location)
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error.localizedDescription)
        
        let status = CLLocationManager.authorizationStatus()
        if status == .denied {
            print("denied")
            SVProgressHUD.showInfo(withStatus: "如需获取当前位置，请在系统设置->隐私->定位服务中开启豪车汇的授权")
        }else if status == .notDetermined {
            print("notDetermined")
        }else if status == .restricted {
            print("restricted")
        }
    }
}











