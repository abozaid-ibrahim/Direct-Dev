//
//  MyOrdersViewController.swift
//  Direct
//
//  Created by abuzeid on 4/28/19.
//  Copyright © 2019 abuzeid. All rights reserved.
//

import UIKit

class MyOrdersViewController: UIViewController, StyledActionBar {
    override func viewDidLoad() {
        super.viewDidLoad()
        setupActionBar(.withTitle("My Orders"))
    }

    override func viewDidAppear(_: Bool) {
//        self.present(NewDirectVisaController(), animated: true, completion: nil)
        present(PassangersController(), animated: true, completion: nil)
    }
}
