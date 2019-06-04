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
    @IBOutlet weak var requestNumberLbl: UILabel!
    internal let disposeBag = DisposeBag()
    var orderId:String?
    override func viewDidLoad() {
        super.viewDidLoad()
        setupActionBar(.withX)
        self.requestNumberLbl.text = orderId
    }

    @IBAction func followMyOrder(_: Any) {
        try! AppNavigator().push(.MyOrders)
    }
}
