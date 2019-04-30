//
//  NewVisaViewController.swift
//  Direct
//
//  Created by abuzeid on 4/29/19.
//  Copyright © 2019 abuzeid. All rights reserved.
//

import UIKit
import PanModal

class NewDirectVisaController: UIViewController {
    
    @IBOutlet weak var checkoutFooter: CheckoutFooter!
    @IBOutlet weak var countryField: SpinnerTextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        countryField.setOnclick {
            self.presentPanModal(Destination.selectableSheet(data: "").controller() as! UIViewController & PanModalPresentable)

        }
        checkoutFooter.action = {[weak self] in
            self?.present(PaymentViewController(), animated: true, completion: nil)

        }
    }
    
    
   
}
