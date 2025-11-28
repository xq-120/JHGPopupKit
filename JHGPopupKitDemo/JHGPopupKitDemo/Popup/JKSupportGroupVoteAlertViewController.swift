//
//  ZAESupportGroupVoteAlertViewController.swift
//  UIPresentationController_demo
//
//  Created by uzzi on 2019/3/13.
//  Copyright © 2019 uzzi. All rights reserved.
//

import UIKit
import JHGPopupKit

/**
 高度自适应弹窗
 */
class JKSupportGroupVoteAlertViewController: JHGPopupViewController, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    @objc lazy var titleLabel: UILabel = {
        let label = UILabel.init()
        label.textAlignment = NSTextAlignment.center
        label.textColor = UIColor.black
        label.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        label.backgroundColor = UIColor.white
        label.text = "Unidentified Flying Object"
        return label
    }()
    
    lazy var footerView: UIView = {
        let view = UIView.init(frame: CGRect.init(x: 0, y: 0, width: kScreenW, height: 70))
        view.backgroundColor = UIColor.white
        
        let button = UIButton.init(type: .custom)
        button.frame = CGRect.init(x: 15, y: 10, width: kScreenW - 30, height: 44)
        button.layer.cornerRadius = 22
        button.layer.masksToBounds = true
        button.setTitle("提交", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        button.backgroundColor = UIColor.purple
        button.addTarget(self, action: #selector(confirmBtnDidClicked(sender:)), for: .touchUpInside)
        button.adjustsImageWhenHighlighted = false
        button.adjustsImageWhenDisabled = false
        button.tag = 1000
        view.addSubview(button)
        
        return view
    }()
    
    var confirmBtn: UIButton {
        get {
            return footerView.viewWithTag(1000) as! UIButton
        }
    }
    
    lazy var collectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout.init()
        flowLayout.scrollDirection = UICollectionView.ScrollDirection.vertical
        flowLayout.sectionInset = UIEdgeInsets.init(top: 0, left: 10, bottom: 0, right: 10)
        flowLayout.minimumLineSpacing = 5 //两列之间的间距
        flowLayout.minimumInteritemSpacing = 5 //两行之间的间距
        let collectionView = UICollectionView.init(frame: CGRect.init(x: 0, y: 0, width: kScreenW, height: 0), collectionViewLayout: flowLayout)
        collectionView.backgroundColor = UIColor.white
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: String.init(describing: UICollectionViewCell.self))
        return collectionView
    }()
    
    var dataList: [JKInterActiveGroupVipUserModel] = []
    var selectedItem: JKInterActiveGroupVipUserModel?
    
    @objc var confirmBtnDidClickedBlk: ((JKInterActiveGroupVipUserModel?) -> Void)?
    
    override init() {
        super.init()
        self.animator = JHGPopupViewControllerPresentAnimation()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initializeSubviews()
        makeSubviewContraints()
        
        for i in 0..<7 {
            let item = JKInterActiveGroupVipUserModel.init()
            item.avatar = "character_menu_4"
            item.nickname = "第\(i)个"
            item.userID = i
            self.dataList.append(item)
        }
        self.collectionView.reloadData()
        
        view.layoutIfNeeded() //马上计算frame.
        contentView.jh_addRoundingCorners([.topLeft, .topRight], cornerRadii: CGSize.init(width: 16, height: 16))
    }
    
    @objc func configure(list: [JKInterActiveGroupVipUserModel]) -> Void {
        self.dataList = list
        self.collectionView.reloadData()
    }
    
    func initializeSubviews() {
        view.addSubview(contentView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(collectionView)
        contentView.addSubview(footerView)
    }
    
    func makeSubviewContraints() {
        
        contentView.snp.makeConstraints { (maker) in
            maker.leading.trailing.bottom.equalTo(self.view)
        }
        
        titleLabel.snp.makeConstraints { (maker) in
            maker.top.equalTo(self.contentView)
            maker.leading.trailing.equalTo(self.contentView)
            maker.height.equalTo(55)
        }
        
        let width = floor((kScreenW - 3 * 5 - 2 * 10) / 4.0)
        let height = (1.2 * width) * 2 + 5
        collectionView.snp.makeConstraints { (maker) in
            maker.leading.trailing.equalTo(self.contentView)
            maker.top.equalTo(self.titleLabel.snp.bottom).offset(0)
            maker.bottom.equalTo(self.footerView.snp.top)
            maker.height.equalTo(height)
        }
        
        footerView.snp.makeConstraints { (maker) in
            maker.leading.trailing.bottom.equalTo(self.contentView)
            maker.height.equalTo(74 + (isIPhoneX() ? 34 : 0))
        }
    }
    
    @objc func confirmBtnDidClicked(sender: Any?) -> Void {
        confirmBtnDidClickedBlk?(self.selectedItem)
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.dataList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = floor((collectionView.frame.size.width - 3 * 5 - 2 * 10) / 4.0)
        return CGSize.init(width: width, height: 1.2 * width)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let reuseId = String.init(describing: UICollectionViewCell.self)

        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseId, for: indexPath)
        
        var imageView: UIImageView? = cell.contentView.viewWithTag(10001) as? UIImageView
        var titleLabel: UILabel? = cell.contentView.viewWithTag(10002) as? UILabel
        
        if imageView == nil {
            imageView = UIImageView.init(frame: CGRect.init(x: (cell.frame.size.width - 30)/2.0, y: cell.frame.size.height/2.0 - 30, width: 30, height: 30))
            imageView?.layer.cornerRadius = 15
            imageView?.layer.masksToBounds = true
            imageView?.tag = 10001
            cell.contentView.addSubview(imageView!)
        }
        
        if titleLabel == nil {
            titleLabel = UILabel.init(frame: CGRect.init(x: 0, y: cell.frame.size.height/2.0 + 5, width: cell.frame.size.width, height: 23))
            titleLabel?.textColor = UIColor.black
            titleLabel?.font = UIFont.systemFont(ofSize: 14)
            titleLabel?.tag = 10002
            titleLabel?.textAlignment = .center
            cell.contentView.addSubview(titleLabel!)
        }

        let user = self.dataList[indexPath.row]
        
        imageView?.image = UIImage.init(named: user.avatar)
        titleLabel?.text = "\(indexPath.row + 1)号"
        
        if user.userID == self.selectedItem?.userID {
            cell.contentView.layer.borderColor = UIColor.black.cgColor
        } else {
            cell.contentView.layer.borderColor = UIColor.clear.cgColor
        }
        cell.contentView.layer.borderWidth = 1.5
        cell.contentView.layer.cornerRadius = 4
        
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.selectedItem = self.dataList[indexPath.row]
        collectionView.reloadData()
    }

}
