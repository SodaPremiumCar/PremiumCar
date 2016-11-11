//
//  SuggestionVC.swift
//  PremiumCar
//
//  Created by 赵霆 on 16/11/11.
//  Copyright © 2016年 soda. All rights reserved.
//

import Foundation

class SuggestionVC: UIViewController {
    
    var submitBtn: UIButton?
    var textView: UITextView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
     
        setupUI()
    }
    
    fileprivate func setupUI() {
        
        self.view.backgroundColor = COLOR_BLACK
        self.title = "意见反馈"
        
        let imageView = UIImageView(frame: CGRect(x: (SCREEN_WIDTH - 100) * 0.5, y: 86, width: 100, height: 100))
        imageView.image = UIImage(named:"suggestionHeader")
        view.addSubview(imageView)
        
        textView = UITextView(frame: CGRect(x: 30, y:(imageView.frame.maxY) + 15, width: SCREEN_WIDTH - 60, height: 120))
        textView?.backgroundColor = FUZZY_BACK
        textView?.font = UIFont.systemFont(ofSize: 14)
        textView?.textColor = UIColor.white
        textView?.delegate = self
        textView?.text = "请填写您的意见与建议，我们会及时调整"
        view.addSubview(textView!)
        
        submitBtn = UIButton(type: UIButtonType.roundedRect)
        submitBtn?.frame = CGRect(x: 30, y: (textView?.frame.maxY)! + 12, width: SCREEN_WIDTH - 60, height: 40)
        submitBtn?.layer.cornerRadius = 4
        submitBtn?.layer.borderWidth = 0.7
        submitBtn?.layer.borderColor = FUZZY_BACK.cgColor
        submitBtn?.layer.masksToBounds = true
        submitBtn?.backgroundColor = UIColor.clear
        submitBtn?.setTitle("提交", for: UIControlState.normal)
        submitBtn?.addTarget(self, action: #selector(submitSuggestion), for: UIControlEvents.touchUpInside)
        setButton(button: submitBtn!, with: 0)
        view.addSubview(submitBtn!)
    }
    
    func submitSuggestion() {
        
        TZNetworkTool.shareNetworkTool.feedBack(content: (textView?.text)!) { (isSuccess) in
            if isSuccess {
                self.navigationController?.popViewController(animated: true)
            }
        }
    }
     
}

extension SuggestionVC: UITextViewDelegate {
    
    func textViewDidChange(_ textView: UITextView) {
                
        if textView.text.characters.count != 0 {
            
            setButton(button: submitBtn!, with: 1)
        }else{
            setButton(button: submitBtn!, with: 0)
        }
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        
        if textView.text == "请填写您的意见与建议，我们会及时调整" {
            textView.text = ""
        }
    }
}
