//
//  JKAuditionEndBuyAlertViewController.swift
//  UIPresentationController_demo
//
//  Created by uzzi on 2019/3/13.
//  Copyright © 2019 uzzi. All rights reserved.
//

import UIKit
import JHGPopupKit

private let kAuditionEndBuyAlertViewWidth: CGFloat = 294.0

/**
 宽度固定，高度自适应弹窗
 */
class AuditionEndBuyAlertView: JHGPopupView  {
    
   @objc lazy var topImageView: UIImageView = {
        let imageView = UIImageView.init()
        imageView.contentMode = UIView.ContentMode.scaleAspectFill
        imageView.layer.masksToBounds = true
        imageView.image = UIImage.init(named: "audition_alert_higher_icon")
        return imageView
    }()
    
   @objc lazy var titleBtn: UIButton = {
        let button = UIButton.init(type: .custom)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 24)
        button.setTitle("试听结束", for: .normal)
        button.setImage(UIImage.init(named: "audition_icon"), for: .normal)
        button.layer.cornerRadius = 5
        return button
    }()
    
    @objc lazy var closeBtn: UIButton = {
        let button = UIButton.init(type: .custom)
        button.setImage(UIImage.init(named: "alert_close_white_icon"), for: .normal)
        button.addTarget(self, action: #selector(closeBtnDidClicked(sender:)), for: .touchUpInside)
        button.adjustsImageWhenHighlighted = false
        return button
    }()
    
    @objc lazy var subTitleLabel: UILabel = {
        let label = UILabel.init()
        label.textAlignment = NSTextAlignment.center
        label.textColor = UIColor.white
        label.font = UIFont.systemFont(ofSize: 16)
        label.numberOfLines = 0
        return label
    }()
    
    @objc lazy var messagelLabel: UILabel = {
        let label = UILabel.init()
        label.textAlignment = NSTextAlignment.center
        label.textColor = UIColor.black
        label.font = UIFont.systemFont(ofSize: 16)
        label.text = "该课程为非免费课程，\n需购买后才能收听全部"
        label.numberOfLines = 0
        return label
    }()
    
    @objc lazy var confirmBtn: UIButton = {
        let button = UIButton.init(type: .custom)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        button.setTitle("去购买", for: .normal)
        button.addTarget(self, action: #selector(confirmBtnDidClicked(sender:)), for: .touchUpInside)
        button.layer.cornerRadius = 5
        button.layer.masksToBounds = true
        button.backgroundColor = UIColor.purple
        button.adjustsImageWhenHighlighted = false
        return button
    }()
    
    @objc var buyBtnDidClickedBlk: (() -> Void)?
    @objc var closeBtnDidClickedBlk: (() -> Void)?
    
    init() {
        super.init(frame: .zero)
        self.animator = GrandPopupSlideAnimation.init()
        initialSubviews()
        makeSubviewsConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func closeBtnDidClicked(sender: UIButton) -> Void {
        hidden(completion: nil)
    }
    
    @objc func confirmBtnDidClicked(sender: UIButton) -> Void {
        hidden(completion: buyBtnDidClickedBlk)
    }
    
    func initialSubviews() {
        
        contentView.backgroundColor = UIColor.white
        contentView.layer.cornerRadius = 6
        contentView.layer.masksToBounds = true
        
        self.addSubview(contentView)
        contentView.addSubview(topImageView)
        contentView.addSubview(titleBtn)
        contentView.addSubview(subTitleLabel)
        contentView.addSubview(messagelLabel)
        contentView.addSubview(closeBtn)
        contentView.addSubview(confirmBtn)
    }
    
    func makeSubviewsConstraints() {
        
        contentView.snp.makeConstraints { (maker) in
            maker.center.equalTo(self)
            maker.width.equalTo(kAuditionEndBuyAlertViewWidth)
        }
        
        topImageView.snp.makeConstraints { (maker) in
            maker.top.equalTo(contentView).offset(0)
            maker.leading.equalTo(contentView).offset(0)
            maker.trailing.equalTo(contentView).offset(0)
            maker.height.equalTo(112)
        }
        
        titleBtn.snp.makeConstraints { (maker) in
            maker.top.equalTo(contentView).offset(30)
            maker.centerX.equalTo(contentView)
        }
        
        subTitleLabel.snp.makeConstraints { (maker) in
            maker.top.equalTo(titleBtn.snp.bottom).offset(0)
            maker.leading.equalTo(contentView).offset(20)
            maker.trailing.equalTo(contentView).offset(-20)
        }
        
        closeBtn.snp.makeConstraints { (maker) in
            maker.top.equalTo(contentView).offset(5)
            maker.trailing.equalTo(contentView).offset(-5)
            maker.size.equalTo(CGSize.init(width: 25, height: 25))
        }
        
        messagelLabel.snp.makeConstraints { (maker) in
            maker.top.equalTo(topImageView.snp.bottom).offset(17)
            maker.leading.equalTo(contentView).offset(20)
            maker.trailing.equalTo(contentView).offset(-20)
        }
        
        confirmBtn.snp.makeConstraints { (maker) in
            maker.top.equalTo(messagelLabel.snp.bottom).offset(15)
            maker.leading.equalTo(contentView).offset(20)
            maker.trailing.equalTo(contentView).offset(-20)
            maker.bottom.equalTo(contentView).offset(-30)
            maker.height.equalTo(44)
        }

    }

}
