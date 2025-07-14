//
//  FDENavigationController.swift
//  DemonSwift
//
//  Created by uzzi on 2020/1/30.
//  Copyright © 2020 uzzi. All rights reserved.
//

import UIKit

class FDENavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override var childForStatusBarStyle: UIViewController? {
        return self.topViewController
    }
    
    override var childForStatusBarHidden: UIViewController? {
        return self.topViewController
    }
}
