//
//  NewVisaViewController.swift
//  Direct
//
//  Created by abuzeid on 4/29/19.
//  Copyright © 2019 abuzeid. All rights reserved.
//

import PanModal
import UIKit

class NewDirectVisaController: UIViewController {
    @IBOutlet var checkoutFooter: CheckoutFooter!
    @IBOutlet var countryField: SpinnerTextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        countryField.setOnclick {
            self.presentPanModal(Destination.selectableSheet(data: "").controller() as! UIViewController & PanModalPresentable)
        }
        checkoutFooter.action = { [weak self] in
            self?.present(PaymentViewController(), animated: true, completion: nil)
        }
    }
}
