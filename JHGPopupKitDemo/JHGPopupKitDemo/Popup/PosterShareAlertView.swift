//
//  PosterShareAlertView.swift
//  JHGPopupKitDemo
//
//  Created by uzzi on 2025/11/28.
//

import UIKit
import JHGPopupKit
import SnapKit

class PosterShareAlertView: JHGPopupView {

    lazy var imageView: UIImageView = {
        let imageView = UIImageView.init()
        imageView.contentMode = UIView.ContentMode.scaleAspectFill
        imageView.image = UIImage.init(named: "jiang_jun")
        imageView.backgroundColor = UIColor.clear
        return imageView
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel.init()
        label.textAlignment = NSTextAlignment.left
        label.textColor = UIColor.black
        label.font = UIFont.systemFont(ofSize: 18)
        label.text = "- 邀请码：YSDL0G9 -"
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(imageView)
        contentView.addSubview(titleLabel)
        
        contentView.snp.makeConstraints { make in
            make.leading.equalTo(self).offset(40)
            make.center.equalTo(self)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.leading.equalTo(contentView).offset(15)
            make.bottom.equalTo(contentView).offset(-30)
        }
        
        imageView.snp.makeConstraints { make in
            make.leading.top.trailing.equalTo(contentView)
            make.height.equalTo(UIScreen.main.bounds.size.width - 2 * 40)
            make.bottom.equalTo(contentView).offset(-80)
        }
        
        contentView.layer.cornerRadius = 20
        contentView.clipsToBounds = true
        
        self.animator = JHGPopupViewPresentAnimation()
    }
}
