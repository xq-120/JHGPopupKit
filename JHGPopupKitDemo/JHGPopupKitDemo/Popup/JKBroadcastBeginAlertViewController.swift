//
//  JKBroadcastBeginAlertViewController.swift
//  DemonSwift
//
//  Created by uzzi on 2019/5/28.
//  Copyright © 2019 uzzi. All rights reserved.
//

import UIKit
import JHGPopupKit

/**
 宽度固定，高度自适应弹窗
 */
class JKBroadcastBeginAlertViewController: JHGPopupViewController {

    @objc lazy var titleLabel: UILabel = {
        let label = UILabel.init()
        label.textAlignment = NSTextAlignment.left
        label.textColor = UIColor.black
        label.font = UIFont.systemFont(ofSize: 26)
        label.text = "正在直播"
        return label
    }()
    
    lazy var closeBtn: UIButton = {
        let button = UIButton.init(type: .custom)
        button.setImage(UIImage.init(named: "push_alert_close_icon"), for: .normal)
        button.addTarget(self, action: #selector(closeBtnDidClicked(sender:)), for: .touchUpInside)
        button.adjustsImageWhenHighlighted = false
        return button
    }()
    
    lazy var lightRedBgView: UIView = {
        let view = UIView.init()
        view.backgroundColor = UIColor.lightGray
        view.layer.cornerRadius = 8
        return view
    }()
    
    lazy var avatarImageView: UIImageView = {
        let imageView = UIImageView.init()
        imageView.contentMode = UIView.ContentMode.scaleAspectFill
        imageView.layer.cornerRadius = 12
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    @objc lazy var nameLabel: UILabel = {
        let label = UILabel.init()
        label.textAlignment = NSTextAlignment.left
        label.textColor = UIColor.black
        label.font = UIFont.systemFont(ofSize: 13)
        return label
    }()
    
    @objc lazy var liveTitleLabel: UILabel = {
        let label = UILabel.init()
        label.textAlignment = NSTextAlignment.left
        label.numberOfLines = 2
        label.textColor = UIColor.black
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()
    
    lazy var messageLabel: UILabel = {
        let label = UILabel.init()
        label.textAlignment = NSTextAlignment.left
        label.numberOfLines = 0
        label.textColor = UIColor.black
        label.font = UIFont.systemFont(ofSize: 14)
        label.text = "直播已经开始，直播期间可以免费提问，老师在线回答。是否进入直播间?"
        return label
    }()
    
    lazy var cancelBtn: UIButton = {
        let button = UIButton.init(type: .custom)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        button.setTitleColor(UIColor.black, for: .normal)
        button.setTitle("忽略", for: .normal)
        button.addTarget(self, action: #selector(cancelBtnDidClicked(sender:)), for: .touchUpInside)
        return button
    }()
    
    lazy var sureBtn: UIButton = {
        let button = UIButton.init(type: .custom)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        button.setTitleColor(UIColor.white, for: .normal)
        button.setTitle("进入", for: .normal)
        button.addTarget(self, action: #selector(sureBtnDidClicked(sender:)), for: .touchUpInside)
        button.layer.cornerRadius = 5
        button.backgroundColor = UIColor.black
        return button
    }()
    
    @objc var sureBtnDidClickedBlk: (() -> Void)?
    @objc var cancelBtnDidClickedBlk: (() -> Void)?
    @objc var closeBtnDidClickedBlk: (() -> Void)?
    
    deinit {
        
    }
    
    override init() {
        super.init()
        self.shouldDismissOnTouchBackView = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initialSubviews()
        makeSubviewsConstraints()
        
        configureAlert()
    }
    
    @objc func configureAlert() -> Void {
        avatarImageView.image = UIImage.init(named: "private_expert_no_data_icon")
        nameLabel.text = "李永乐"
        liveTitleLabel.text = "郁金香狂热"
    }
    
    @objc func closeBtnDidClicked(sender: UIButton) {
        self.hidden()
    }
    
    @objc func sureBtnDidClicked(sender: UIButton) {
        self.sureBtnDidClickedBlk?()
    }
    
    @objc private func cancelBtnDidClicked(sender: UIButton) {
        self.hiddenWith(animated: true) { [weak self] in
            self?.cancelBtnDidClickedBlk?()
        }
    }
    
    
    func initialSubviews() {
        contentView.backgroundColor = UIColor.white
        contentView.layer.cornerRadius = 6
        contentView.layer.masksToBounds = true
    
        contentView.addSubview(closeBtn)
        contentView.addSubview(titleLabel)
        contentView.addSubview(lightRedBgView)
        lightRedBgView.addSubview(avatarImageView)
        lightRedBgView.addSubview(nameLabel)
        lightRedBgView.addSubview(liveTitleLabel)
        contentView.addSubview(messageLabel)
        contentView.addSubview(cancelBtn)
        contentView.addSubview(sureBtn)
    }
    
    func makeSubviewsConstraints() {
        contentView.snp.makeConstraints { (maker) in
            maker.center.equalTo(view)
            maker.width.equalTo(254)
        }
        
        closeBtn.snp.makeConstraints { (maker) in
            maker.top.equalTo(contentView).offset(5)
            maker.trailing.equalTo(contentView).offset(-5)
            maker.size.equalTo(CGSize.init(width: 25, height: 25))
        }
        
        titleLabel.snp.makeConstraints { (maker) in
            maker.top.equalTo(contentView).offset(25)
            maker.leading.equalTo(contentView).offset(15)
        }

        lightRedBgView.snp.makeConstraints { (maker) in
            maker.top.equalTo(titleLabel.snp.bottom).offset(10)
            maker.leading.equalTo(contentView).offset(15)
            maker.trailing.equalTo(contentView).offset(-15)
        }
        
        avatarImageView.snp.makeConstraints { (maker) in
            maker.top.equalTo(lightRedBgView).offset(7)
            maker.leading.equalTo(lightRedBgView).offset(11)
            maker.size.equalTo(CGSize.init(width: 24, height: 24))
        }
        
        nameLabel.snp.makeConstraints { (maker) in
            maker.leading.equalTo(avatarImageView.snp.trailing).offset(7)
            maker.centerY.equalTo(avatarImageView)
        }
        
        liveTitleLabel.snp.makeConstraints { (maker) in
            maker.leading.equalTo(avatarImageView)
            maker.top.equalTo(avatarImageView.snp.bottom).offset(4)
            maker.trailing.equalTo(lightRedBgView.snp.trailing).offset(-11)
            maker.bottom.equalTo(lightRedBgView).offset(-6)
        }
        
        messageLabel.snp.makeConstraints { (maker) in
            maker.leading.equalTo(contentView).offset(15)
            maker.trailing.equalTo(contentView).offset(-15)
            maker.top.equalTo(lightRedBgView.snp.bottom).offset(10)
        }
        
        cancelBtn.snp.makeConstraints { (maker) in
            maker.leading.equalTo(contentView).offset(15)
            maker.top.equalTo(messageLabel.snp.bottom).offset(20)
            maker.bottom.equalTo(contentView).offset(-24)
            maker.size.equalTo(CGSize.init(width: 60, height: 40))
        }
        
        sureBtn.snp.makeConstraints { (maker) in
            maker.leading.equalTo(cancelBtn.snp.trailing).offset(20)
            maker.trailing.equalTo(contentView).offset(-15)
            maker.top.equalTo(messageLabel.snp.bottom).offset(20)
            maker.bottom.equalTo(contentView).offset(-24)
            maker.height.equalTo(40)
        }
    }
}

