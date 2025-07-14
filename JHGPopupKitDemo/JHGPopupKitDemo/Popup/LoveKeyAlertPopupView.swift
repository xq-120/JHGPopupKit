//
//  LoveKeyAlertPopupView.swift
//  GrandPopupViewDemo
//
//  Created by uzzi on 2022/7/12.
//

import UIKit
import JHGPopupKit
import SnapKit

class LoveKeyAlertPopupView: JHGPopupView {
    
    private lazy var closeBtn: UIButton = {
        let btn = UIButton.init(type: .custom)
        btn.setImage(UIImage.init(named: "close_white_icon"), for: .normal)
        btn.addTarget(self, action: #selector(closeBtnDidClicked(_:)), for: .touchUpInside)
        return btn
    }()
    
    private lazy var containerView: UIView = {
        let view = UIView.init(frame: .zero)
        view.backgroundColor = .white
        return view
    }()
    
    private lazy var okBtn: UIButton = {
        let btn = UIButton.init(type: .custom)
        btn.backgroundColor = .black
        btn.setTitle("好的", for: .normal)
        btn.addTarget(self, action: #selector(okBtnDidClicked(_:)), for: .touchUpInside)
        btn.layer.cornerRadius = 22
        return btn
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel.init(frame: .zero)
        label.text = "七擒孟获 六出祁山"
        label.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        label.textAlignment = .center
        return label
    }()
    
    private lazy var animateView: UIImageView = {
        let view = UIImageView.init(frame: .zero)
        view.image = UIImage.init(named: "jiang_jun")
        return view
    }()
    
    private lazy var contentLabel: UILabel = {
        let label = UILabel.init(frame: .zero)
        label.textColor = .lightGray
        label.text = "蜀国元气大伤之时，曹丕联合东吴与蜀汉降将孟达、南蛮孟获等势力五路发兵进攻蜀国。"
        label.font = UIFont.systemFont(ofSize: 14)
        label.numberOfLines = 0
        return label
    }()
    
    public var closeBtnActionBlk: (() -> Void)?
    
    public var okBtnActionBlk: (() -> Void)?

    init() {
        super.init(frame: .zero)
        
        contentView.addSubview(closeBtn)
        contentView.addSubview(containerView)
        contentView.backgroundColor = .clear
        containerView.layer.cornerRadius = 28
        
        containerView.addSubview(titleLabel)
        containerView.addSubview(animateView)
        containerView.addSubview(contentLabel)
        containerView.addSubview(okBtn)
        
        contentView.snp.makeConstraints { make in
            make.center.equalTo(self)
        }
        closeBtn.snp.makeConstraints { make in
            make.top.equalTo(contentView).offset(0)
            make.trailing.equalTo(contentView).offset(0)
            make.size.equalTo(CGSize.init(width: 26, height: 26))
        }
        containerView.snp.makeConstraints { make in
            make.top.equalTo(closeBtn.snp.bottom).offset(8)
            make.leading.equalTo(contentView).offset(0)
            make.trailing.equalTo(contentView).offset(0)
            make.bottom.equalTo(contentView).offset(0)
            make.size.equalTo(CGSize.init(width: 305, height: 414))
        }
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(containerView).offset(24)
            make.leading.equalTo(containerView).offset(5)
            make.trailing.equalTo(containerView).offset(-5)
        }
        animateView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(16)
            make.centerX.equalTo(containerView)
            make.size.equalTo(CGSize.init(width: 200, height: 200))
        }
        contentLabel.snp.makeConstraints { make in
            make.top.equalTo(animateView.snp.bottom).offset(12)
            make.leading.equalTo(containerView).offset(28)
            make.trailing.equalTo(containerView).offset(-28)
        }
        okBtn.snp.makeConstraints { make in
            make.leading.equalTo(containerView).offset(24)
            make.trailing.equalTo(containerView).offset(-24)
            make.bottom.equalTo(containerView).offset(-24)
            make.height.equalTo(44)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func closeBtnDidClicked(_ sender: UIButton) {
        hidden(completion: closeBtnActionBlk)
    }
    
    @objc private func okBtnDidClicked(_ sender: UIButton) {
        hidden(completion: okBtnActionBlk)
    }
}
