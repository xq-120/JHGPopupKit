//
//  UIView+Corner.swift
//  UIPresentationController_demo
//
//  Created by uzzi on 2019/4/21.
//  Copyright © 2019 uzzi. All rights reserved.
//

import UIKit

extension UIView {
    func addRoundingCorners(roundedRect rect: CGRect, byRoundingCorners corners: UIRectCorner, cornerRadii: CGSize) {
        let maskPath: UIBezierPath = UIBezierPath.init(roundedRect: rect, byRoundingCorners: corners, cornerRadii: cornerRadii)
        let maskLayer: CAShapeLayer = CAShapeLayer()
        maskLayer.frame = rect
        maskLayer.path = maskPath.cgPath
        self.layer.mask = maskLayer
    }
}
