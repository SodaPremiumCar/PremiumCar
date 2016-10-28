//
//  MyCarVC.swift
//  PremiumCar
//
//  Created by 赵霆 on 16/9/13.
//  Copyright © 2016年 soda. All rights reserved.
//

import UIKit

let itemIdentifier = "cell"
class MyCarVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    fileprivate lazy var dataSource: [CarModel] = {
        
        let dic0 = ["name" : "保时捷 911", "url" : "Porsche-911", "numbel" : "京A 32N28"]
        let model0 = CarModel(dic: dic0 as [String : AnyObject])
        let dic1 = ["name" : "宾利 添越", "url" : "Bingley-bentayga", "numbel" : "京N 2O4P2"]
        let model1 = CarModel(dic: dic1 as [String : AnyObject])
        let dic2 = ["name" : "捷豹 F-Pace", "url" : "Jaguar-fPace", "numbel" : "京Q 12JL1"]
        let model2 = CarModel(dic: dic2 as [String : AnyObject])
        let dic3 = ["name" : "奔驰 SL", "url" : "Benz-SL", "numbel" : "京A 93DL8"]
        let model3 = CarModel(dic: dic3 as [String : AnyObject])
        let dic4 = ["name" : "劳斯莱斯 魅影", "url" : "RollsRoyce-wraith", "numbel" : "京Q J4Y89"]
        let model4 = CarModel(dic: dic4 as [String : AnyObject])
        let dic5 = ["name" : "特斯拉 ModelS", "url" : "Tesla-modelS", "numbel" : "京N 6NN18"]
        let model5 = CarModel(dic: dic5 as [String : AnyObject])
        
        let dataSource: [CarModel] = [model0, model1, model2, model3, model4, model5]
        return dataSource
    }()
    var collectionView: UICollectionView?
    
    override func viewDidLoad() {
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: SCREEN_HEIGHT - 64), collectionViewLayout: flowLayout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.showsVerticalScrollIndicator = false
        collectionView.backgroundColor = UIColor.white
        collectionView.register(MyCarCell.self, forCellWithReuseIdentifier: itemIdentifier)
        view.addSubview(collectionView)
        self.collectionView = collectionView
        
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return dataSource.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: itemIdentifier, for: indexPath) as! MyCarCell
        cell.dataSource = dataSource[(indexPath as NSIndexPath).row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: (SCREEN_WIDTH - 30) * 0.5, height: (SCREEN_WIDTH - 30) * 0.5 + 30)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        return UIEdgeInsets(top: 15, left: 10, bottom: 15, right: 10)
    }
    
    
}
