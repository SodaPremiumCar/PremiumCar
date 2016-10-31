//
//  CarBrandsVC.swift
//  PremiumCar
//
//  Created by 赵霆 on 16/10/26.
//  Copyright © 2016年 soda. All rights reserved.
//

import Foundation

class CarBrandsVC: UIViewController {
    
    var identifier: NSString!
    var brandsTabelView: UITableView!
    var typesTableView: UITableView!
    var submitView: UIView?
    var submitBtn: UIButton?
    var brandLabel: UILabel?
    var brandStr: String?
    
    let brandstitle = ["奔驰", "宝马", "奥迪", "雷克萨斯", "英菲尼迪", "讴歌", "保时捷"]
    var typestitle = [String]()
    
    fileprivate lazy var typesArray:[[String]] = {
        
        let Benz = ["E 200", "E 260", "E 320", "E 400", "CLS 260", "CLS 320", "CLS 400", "S 320L", "S 400L", "S 400", "S 500", "S 500L", "GLE 300d", "GLE 350d", "GLE 320", "GLE 400", "GLE 500e", "GLE 450", "R 320", "R 400"]
        let BMW = ["430i", "440i", "528i", "535i", "528i GT", "535i GT", "550i GT", "640i", "650i", "730Li", "740Le", "750Li", "X5 28i", "X5 30d", "X5 35i", "X5 50i"]
        let Audi = ["S5", "S6", "A6（进口）", "A7", "A8L", "Q5（进口）", "Q7"]
        let Lexus = ["ES 300h", "ES 200", "ES 250", "GS 300h", "GS 450h", "RX 200t", "RX 450h"]
        let Infiniti = ["QX60", "QX70", "Q70"]
        let Acura = ["MDX", "ZDX", "RLX"]
        let Porsche = ["Panamera", "Macan", "Cayenne"]
        let typesArray = [Benz, BMW, Audi, Lexus, Infiniti, Acura, Porsche]
        return typesArray
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "添加车辆"
        self.navigationController?.isNavigationBarHidden = false
        self.navigationItem.hidesBackButton = true
        
        self.setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        TZNetworkTool.shareNetworkTool.carBrandsList { (Bool) in
            
        }
    }

    private func setupUI() {
        
//        // 设置导航栏
//        self.navigationController?.isNavigationBarHidden = true
//        self.navigationItem.hidesBackButton = true
//        self.navigationController?.navigationBar.barTintColor = COLOR_BLACK
//        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]
//        self.title = "绑定车辆"
        self.view.backgroundColor = COLOR_BLACK
        
        let chooseImg = UIImageView(frame: CGRect(x: (SCREEN_WIDTH - 100) * 0.5, y: 86, width: 100, height: 100))
        chooseImg.image = UIImage(named:"chooseBrand")
        view.addSubview(chooseImg)
        
        let frame: CGRect = CGRect(x: 0, y: (chooseImg.frame.maxY) + 15, width: SCREEN_WIDTH, height: SCREEN_HEIGHT * 0.5)
        brandsTabelView = UITableView.init(frame: frame, style: UITableViewStyle.plain)
        brandsTabelView.delegate = self
        brandsTabelView.dataSource = self
        brandsTabelView.backgroundColor = UIColor.clear
        brandsTabelView.separatorColor = FUZZY_BACK
        brandsTabelView.tableFooterView = UIView(frame: CGRect.zero)
        view.addSubview(brandsTabelView)
        
        let frameRight:CGRect = CGRect(x: 100, y: (chooseImg.frame.maxY) + 15, width: SCREEN_WIDTH, height: SCREEN_HEIGHT * 0.5)
        typesTableView = UITableView(frame: frameRight, style: UITableViewStyle.plain)
        typesTableView.delegate = self
        typesTableView.dataSource = self
        typesTableView.backgroundColor = UIColor.clear
        typesTableView.alpha = 0
        typesTableView.separatorColor = FUZZY_BACK
        typesTableView.tableFooterView = UIView(frame: CGRect.zero)
        view.addSubview(typesTableView)
        
        submitView = UIView(frame: CGRect(x: 0, y: SCREEN_HEIGHT - 50 - 64, width: SCREEN_WIDTH, height: 50))
        submitView?.backgroundColor = FUZZY_BACK
        
        // UI线
        let lineW = UIView(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: 0.5))
        lineW.backgroundColor = FUZZY_BACK
        let lineH = UIView(frame: CGRect(x: SCREEN_WIDTH - 90, y: 10, width: 0.5, height: 30))
        lineH.backgroundColor = FUZZY_BACK
        // 提交btn
        submitBtn = UIButton(type: UIButtonType.custom)
        submitBtn?.frame = CGRect(x: SCREEN_WIDTH - 80, y: 0, width: 70, height: 50)
        submitBtn?.setTitle("提交", for: UIControlState.normal)
        submitBtn?.backgroundColor = UIColor.clear
        submitBtn?.addTarget(self, action: #selector(submitCarBrand), for: UIControlEvents.touchUpInside)
        setButton(button: submitBtn!, with: 0)
        //选择label
        brandLabel = UILabel(frame: CGRect(x: 20, y: 0, width: 150, height: 50))
        brandLabel?.text = "请选择品牌"
        brandLabel?.textColor = UIColor.white
        brandLabel?.font = UIFont.systemFont(ofSize: 15)
        
        submitView?.addSubview(submitBtn!)
        submitView?.addSubview(lineW)
        submitView?.addSubview(lineH)
        submitView?.addSubview(brandLabel!)
        view.addSubview(submitView!)
        
    }
    
    func submitCarBrand () {
        print("提交")
        let viewController = ViewController()
        self.navigationController?.pushViewController(viewController, animated: true)
    }
}

extension CarBrandsVC: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if tableView == brandsTabelView {
            return brandstitle.count
        }else{
            return typestitle.count
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 40
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var dataArray: [String]!
        
        if tableView == brandsTabelView {
            identifier = "brandsCell"
            dataArray = brandstitle
        }else{
            identifier = "typesCell"
            dataArray = typestitle
        }
        var cell = tableView.dequeueReusableCell(withIdentifier: identifier as String)
        if cell == nil {
            cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: identifier as String?)
            cell!.textLabel?.textColor = UIColor.white
            cell!.textLabel?.font =  UIFont.systemFont(ofSize: 14)
            // 选中背景颜色
            cell!.selectedBackgroundView = UIView(frame: cell!.frame)
            cell!.selectedBackgroundView?.backgroundColor = FUZZY_BACK
            cell!.backgroundColor = COLOR_BLACK
        }
        
        cell!.textLabel?.text = dataArray[indexPath.row]
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if tableView == brandsTabelView {
            UITableView.animate(withDuration: 0.7, animations: {
                self.typesTableView.alpha = 1
            })
            brandStr = brandstitle[indexPath.row]
            self.brandLabel?.text = brandStr
            typestitle = typesArray[indexPath.row]
            typesTableView.reloadData()
        }else{
            
            self.brandLabel?.text = brandStr! + " " + self.typestitle[indexPath.row]
            setButton(button: submitBtn!, with: 1)
        }
    }
}
