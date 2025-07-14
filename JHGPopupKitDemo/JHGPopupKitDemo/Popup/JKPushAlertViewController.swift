//
//  JKPushAlertViewController.swift
//  UIPresentationController_demo
//
//  Created by uzzi on 2019/3/25.
//  Copyright © 2019 uzzi. All rights reserved.
//

import UIKit
import UserNotifications
import JHGPopupKit

private let kPushAlertViewWidth: CGFloat = 300
private let kPushAlertViewHeight: CGFloat = 300

class JKPushAlertViewController: JHGPopupViewController {

    lazy var lightRedBgView: UIView = {
        let view = UIView.init()
        view.backgroundColor = UIColor.white
        view.alpha = 0.35
        return view
    }()
    
    lazy var closeBtn: UIButton = {
        let button = UIButton.init(type: .custom)
        button.setImage(UIImage.init(named: "push_alert_close_icon"), for: .normal)
        button.addTarget(self, action: #selector(closeBtnDidClicked(sender:)), for: .touchUpInside)
        button.adjustsImageWhenHighlighted = false
        return button
    }()
    
    @objc lazy var titleLabel: UILabel = {
        let label = UILabel.init()
        label.textAlignment = NSTextAlignment.left
        label.textColor = UIColor.black
        label.font = UIFont.systemFont(ofSize: 26)
        label.text = "推送没打开"
        return label
    }()
    
    @objc lazy var detailLabel: UILabel = {
        let label = UILabel.init()
        label.textAlignment = NSTextAlignment.left
        label.textColor = UIColor.lightGray
        label.font = UIFont.systemFont(ofSize: 14)
        label.text = "打开推送功能，获得第一时间的消息提醒。"
        label.numberOfLines = 0
        return label
    }()
    
    lazy var confirmBtn: UIButton = {
        let button = UIButton.init(type: .custom)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        button.setTitle("去设置", for: .normal)
        button.addTarget(self, action: #selector(confirmBtnDidClicked(sender:)), for: .touchUpInside)
        button.layer.cornerRadius = 5
        button.backgroundColor = UIColor.black
        return button
    }()
    
    lazy var bgImageView: UIImageView = {
        let imageView = UIImageView.init()
        imageView.contentMode = UIView.ContentMode.scaleAspectFill
        imageView.image = UIImage.init(named: "character_menu_3")
        imageView.backgroundColor = UIColor.clear
        return imageView
    }()
    
    lazy var containerView: UIView = {
        let v = UIView.init()
        v.backgroundColor = .white
        return v
    }()
    
    @objc var confirmBtnDidClickedBlk: (() -> Void)?
    @objc var closeBtnDidClickedBlk: (() -> Void)?
    
    deinit {
        
    }
    
    override init() {
        super.init()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initialSubviews()
        makeSubviewsConstraints()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        print("viewWillLayoutSubviews view.frame:\(view.frame)")
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        print("viewDidLayoutSubviews view.frame:\(view.frame)")
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
    }
    
    @objc func closeBtnDidClicked(sender: UIButton) -> Void {
        hidden()
    }
    
    @objc func confirmBtnDidClicked(sender: UIButton) -> Void {
        if self.confirmBtnDidClickedBlk != nil {
            self.confirmBtnDidClickedBlk?()
        } else {
            self.hiddenWith(animated: true) {
                let settingsUrl = URL.init(string: UIApplication.openSettingsURLString)
                if settingsUrl != nil && UIApplication.shared.canOpenURL(settingsUrl!) {
                    UIApplication.shared.open(settingsUrl!, completionHandler: nil)
                }
            }
        }
    }
    
    func initialSubviews() {
        contentView.backgroundColor = .clear
        containerView.layer.cornerRadius = 12
        containerView.layer.masksToBounds = true
        
        contentView.addSubview(containerView)
        contentView.addSubview(bgImageView)
        
        containerView.addSubview(lightRedBgView)
        containerView.addSubview(closeBtn)
        containerView.addSubview(titleLabel)
        containerView.addSubview(detailLabel)
        containerView.addSubview(confirmBtn)
    }
    
    func makeSubviewsConstraints() {
        contentView.snp.makeConstraints { (maker) in
            maker.center.equalTo(self.view)
            maker.size.equalTo(CGSize.init(width: kPushAlertViewWidth, height: kPushAlertViewHeight))
        }
        
        containerView.snp.makeConstraints { (maker) in
            maker.center.equalTo(self.view)
            maker.size.equalTo(CGSize.init(width: kPushAlertViewWidth, height: kPushAlertViewHeight))
        }
        
        lightRedBgView.snp.makeConstraints { (maker) in
            maker.leading.trailing.top.equalTo(contentView)
            maker.height.equalTo(60)
        }
        
        bgImageView.snp.makeConstraints { (maker) in
            maker.centerX.equalTo(contentView)
            maker.size.equalTo(CGSize.init(width: 163, height: 84))
            maker.bottom.equalTo(lightRedBgView)
        }
        
        closeBtn.snp.makeConstraints { (maker) in
            maker.top.equalTo(contentView).offset(5)
            maker.trailing.equalTo(contentView).offset(-5)
            maker.size.equalTo(CGSize.init(width: 25, height: 25))
        }
        
        titleLabel.snp.makeConstraints { (maker) in
            maker.top.equalTo(lightRedBgView.snp.bottom).offset(19)
            maker.leading.equalTo(contentView).offset(18)
            maker.trailing.lessThanOrEqualTo(contentView).offset(-18)
        }
        
        detailLabel.snp.makeConstraints { (maker) in
            maker.top.equalTo(titleLabel.snp.bottom).offset(6)
            maker.leading.equalTo(contentView).offset(18)
            maker.trailing.equalTo(contentView).offset(-22)
        }
        
        confirmBtn.snp.makeConstraints { (maker) in
            maker.leading.equalTo(contentView).offset(33)
            maker.trailing.equalTo(contentView).offset(-33)
            maker.bottom.equalTo(contentView).offset(-24)
            maker.height.equalTo(40)
        }
    }
}
