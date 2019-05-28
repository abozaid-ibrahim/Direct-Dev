//
//  SuccessPackageController.swift
//  Direct
//
//  Created by abuzeid on 5/11/19.
//  Copyright © 2019 abuzeid. All rights reserved.
//

import RxSwift
import UIKit

class SuccessPackageController: UIViewController, StyledActionBar {
    var disposeBag = DisposeBag()

    @IBOutlet var paymentMethodsContainer: UIView!
    let vc = PaymentMethodsContainerController()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupActionBar(.withX)
        addChild(vc)
        paymentMethodsContainer.addSubview(vc.view)
        vc.view.sameBoundsTo(parentView: paymentMethodsContainer)
    }
}
