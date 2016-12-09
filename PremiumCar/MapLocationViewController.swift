//
//  MapLocationViewController.swift
//  PremiumCar
//
//  Created by 赵霆 on 16/12/9.
//  Copyright © 2016年 soda. All rights reserved.
//

import Foundation

protocol MapLocationDelegate {
    
    func theMapHasbeenSelected (addressStr: String)
}

class MapLocationViewController: UIViewController {
    
    var delegate: MapLocationDelegate!
    
    var mapView: MAMapView!
    var mapSearch: AMapSearchAPI!
    var regeo: AMapReGeocodeSearchRequest!
    var centerCoordinate: CLLocationCoordinate2D?
    var reGeocode: AMapReGeocode!
    
    var adressLabel: UILabel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.isNavigationBarHidden = false
    }
    
    fileprivate func setupUI() {
        
        title = "选择地址"
        
        mapView = MAMapView.init(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: SCREEN_HEIGHT - 80))
        mapView.delegate = self
        view.addSubview(mapView)
        
        let imageV = UIImageView(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
        imageV.center = mapView.center
        imageV.center.y = imageV.center.y - 79
        imageV.image = UIImage(named: "td")
        mapView.addSubview(imageV)
        
        let backView = UIView(frame: CGRect(x: 0, y: SCREEN_HEIGHT - 64 - 80, width: SCREEN_WIDTH, height: 80))
        backView.backgroundColor = COLOR_BLACK
        view.addSubview(backView)
        
        adressLabel = UILabel()
        adressLabel?.frame = CGRect(x: 10, y: 0, width: SCREEN_WIDTH - 20, height: 50)
        adressLabel?.font = UIFont.systemFont(ofSize: 14)
        adressLabel?.numberOfLines = 0
        adressLabel?.adjustsFontSizeToFitWidth = true
        adressLabel?.textColor = RGBA(220, g: 220, b: 220, a: 1)
        backView.addSubview(adressLabel!)
        
        let confirmBtn = UIButton(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: 80))
        confirmBtn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        confirmBtn.titleEdgeInsets = UIEdgeInsetsMake(50, 0, 0, 0)
        confirmBtn.setTitleColor(SEC_ORANGE, for: .normal)
        confirmBtn.setTitle("点击确认", for: .normal)
        confirmBtn.addTarget(self, action: #selector(confirm), for: UIControlEvents.touchUpInside)
        backView.addSubview(confirmBtn)
        
        // 地图相关初始
        mapSearch = AMapSearchAPI.init()
        mapSearch.delegate = self
        
        regeo = AMapReGeocodeSearchRequest()
        
        mapView.setUserTrackingMode(MAUserTrackingMode.follow, animated: true)
    }
    
    func confirm() {
        
        if delegate != nil {
            self.delegate.theMapHasbeenSelected(addressStr: (adressLabel?.text)!)
        }
        _ = navigationController?.popViewController(animated: true)
        
    }
}

extension MapLocationViewController: MAMapViewDelegate, AMapSearchDelegate {
    
    
    func mapView(_ mapView: MAMapView!, regionDidChangeAnimated animated: Bool) {
        
        centerCoordinate = mapView.region.center
        
        let la: CGFloat = CGFloat((centerCoordinate?.latitude)!)
        let lo: CGFloat = CGFloat((centerCoordinate?.longitude)!)
        
        regeo.location = AMapGeoPoint.location(withLatitude: la, longitude: lo)
        regeo.requireExtension = true
        
        mapSearch.aMapReGoecodeSearch(regeo)
    }
    
    func onReGeocodeSearchDone(_ request: AMapReGeocodeSearchRequest!, response: AMapReGeocodeSearchResponse!) {
        
        reGeocode = response.regeocode
        adressLabel?.text = reGeocode.formattedAddress
    }
}






