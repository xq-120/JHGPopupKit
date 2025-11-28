//
//  JKPublishCommentAlertViewController.swift
//  UIPresentationController_demo
//
//  Created by uzzi on 2019/3/13.
//  Copyright © 2019 uzzi. All rights reserved.
//

import UIKit
import SnapKit
import JHGPopupKit

/**
 高度固定弹窗
 */
class JKPublishCommentAlertViewController: JHGPopupViewController {
    
    lazy var lineView: UIView = {
        let view = UIView.init()
        view.backgroundColor = UIColor.init(red: 217/255.0, green: 217/255.0, blue: 217/255.0, alpha: 1)
        
        return view
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel.init()
        label.textAlignment = NSTextAlignment.center
        label.textColor = UIColor.black
        label.font = UIFont.systemFont(ofSize: 18)
        label.text = "添加回答"
        return label
    }()
    
    lazy var wordCntLabel: UILabel = {
        let label = UILabel.init()
        label.textAlignment = NSTextAlignment.right
        label.textColor = UIColor.black
        label.font = UIFont.systemFont(ofSize: 15)
        label.text = "0/500"
        return label
    }()
    
    lazy var cancelBtn: UIButton = {
        let button = UIButton.init(type: .custom)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        button.setTitleColor(UIColor.black, for: .normal)
        button.setTitle("取消", for: .normal)
        button.addTarget(self, action: #selector(cancelBtnDidClicked(sender:)), for: .touchUpInside)
        return button
    }()
    
    lazy var sureBtn: UIButton = {
        let button = UIButton.init(type: .custom)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        button.setTitleColor(UIColor.black, for: .normal)
        button.setTitle("发布", for: .normal)
        button.addTarget(self, action: #selector(sureBtnDidClicked(sender:)), for: .touchUpInside)
        return button
    }()
    
    lazy var anonymityBtn: UIButton = {
        let button = UIButton.init(type: .custom)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        button.setTitleColor(UIColor.black, for: .normal)
        button.setTitle("匿名", for: .normal)
        button.setImage(UIImage.init(named: "anonymity_normal"), for: .normal)
        button.setImage(UIImage.init(named: "anonymity_selected"), for: .selected)
        button.addTarget(self, action: #selector(anonymityBtnDidClicked(sender:)), for: .touchUpInside)
        return button
    }()
    
    lazy var textView: UITextView = {
        let textView = UITextView.init()
        textView.text = "hello word!"
        textView.backgroundColor = UIColor.white
        textView.font = UIFont.systemFont(ofSize: 15)
        return textView
    }()
    
    override init() {
        super.init()
        self.animator = JHGPopupViewControllerPresentAnimation()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initialSubviews()
        makeSubviewsConstraints()
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        view.layoutIfNeeded() //马上计算frame.
        contentView.jh_addRoundingCorners([.topLeft, .topRight], cornerRadii: CGSize.init(width: 10, height: 10))
        
        textView.becomeFirstResponder()
    }
    
    @objc func viewDidClicked(sender: UIView) -> Void {
        self.hidden()
    }
    
    @objc func cancelBtnDidClicked(sender: UIButton) {
        textView.resignFirstResponder()
        self.hidden()
    }
    
    @objc func sureBtnDidClicked(sender: UIButton) {
        textView.resignFirstResponder()
        self.hidden {
            DLog("text:\(self.textView.text!)")
        }
    }
    
    @objc func anonymityBtnDidClicked(sender: UIButton) {
        sender.isSelected = !sender.isSelected
    }
    
    func initialSubviews() {
        view.backgroundColor = UIColor.clear
    
        view.addSubview(contentView)
        contentView.addSubview(cancelBtn)
        contentView.addSubview(sureBtn)
        contentView.addSubview(titleLabel)
        contentView.addSubview(lineView)
        contentView.addSubview(textView)
        contentView.addSubview(anonymityBtn)
        contentView.addSubview(wordCntLabel)
        
        shouldDismissOnTouchBackView = false
    }
    
    func makeSubviewsConstraints() {
        
        contentView.snp.makeConstraints { (maker) in
            maker.leading.trailing.bottom.equalTo(view)
            maker.height.equalTo(266)
        }
        
        cancelBtn.snp.makeConstraints { (maker) in
            maker.leading.equalTo(contentView).offset(15)
            maker.centerY.equalTo(titleLabel)
        }
        
        sureBtn.snp.makeConstraints { (maker) in
            maker.trailing.equalTo(contentView).offset(-15)
            maker.centerY.equalTo(titleLabel)
        }
        
        titleLabel.snp.makeConstraints { (maker) in
            maker.top.equalTo(contentView)
            maker.leading.greaterThanOrEqualTo(cancelBtn.snp.trailing).offset(10)
            maker.trailing.lessThanOrEqualTo(sureBtn.snp.leading).offset(-10)
            maker.centerX.equalTo(contentView)
            maker.height.equalTo(44)
        }
        
        lineView.snp.makeConstraints { (maker) in
            maker.top.equalTo(titleLabel.snp.bottom)
            maker.leading.equalTo(contentView)
            maker.trailing.equalTo(contentView)
            maker.height.equalTo(1/UIScreen.main.scale)
        }
        
        textView.snp.makeConstraints { (maker) in
            maker.top.equalTo(lineView.snp.bottom).offset(15)
            maker.leading.equalTo(contentView).offset(15)
            maker.trailing.equalTo(contentView).offset(-15)
            maker.bottom.equalTo(anonymityBtn.snp.top)
        }
        
        anonymityBtn.snp.makeConstraints { (maker) in
            maker.leading.equalTo(contentView).offset(15)
            maker.bottom.equalTo(contentView).offset(0)
            maker.height.equalTo(44)
        }
        
        wordCntLabel.snp.makeConstraints { (maker) in
            maker.trailing.equalTo(contentView).offset(-15)
            maker.centerY.equalTo(anonymityBtn)
        }
    }
    
    @objc func keyboardWillShow(_ notification:Notification) -> Void {
        let userInfo = notification.userInfo
        let keyboardRect = (userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        let keyboardH = keyboardRect.size.height;
        
        let duration = userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as! TimeInterval
        
        contentView.snp.updateConstraints { (maker) in
            maker.bottom.equalTo(self.view).offset(-keyboardH)
        }

        UIView.animate(withDuration: duration) {
            self.view.layoutIfNeeded()
        }
    }
    
    @objc func keyboardWillHide(_ notification:Notification) -> Void {
        let userInfo = notification.userInfo
        let duration = userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as! TimeInterval
        
        contentView.snp.updateConstraints { (maker) in
            maker.bottom.equalTo(self.view).offset(0)
        }
        
        UIView.animate(withDuration: duration) {
            self.view.layoutIfNeeded()
        }
    }
}
