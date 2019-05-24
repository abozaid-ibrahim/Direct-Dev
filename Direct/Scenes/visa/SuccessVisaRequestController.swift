//
//  SuccessVisaRequestController.swift
//  Direct
//
//  Created by abuzeid on 5/2/19.
//  Copyright © 2019 abuzeid. All rights reserved.
//

import RxSwift
import UIKit
class SuccessVisaRequestController: UIViewController, StyledActionBar {
    internal let disposeBag = DisposeBag()
    override func viewDidLoad() {
        super.viewDidLoad()
        setupActionBar(.withX)
    }

    @IBAction func followMyOrder(_: Any) {
        try! AppNavigator().push(.MyOrders)
    }
}
