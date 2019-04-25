//
//  RootNavigationViewController.swift
//  Direct
//
//  Created by abuzeid on 4/25/19.
//  Copyright © 2019 abuzeid. All rights reserved.
//

import UIKit
//MVC Architected
class RootNavigationViewController: UINavigationController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        AppNavigator(root: self).show(.loginView)
    }
    
    
    
    
}
