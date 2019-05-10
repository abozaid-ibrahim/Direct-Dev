//
//  SponsersViewController.swift
//  Direct
//
//  Created by abuzeid on 5/2/19.
//  Copyright © 2019 abuzeid. All rights reserved.
//

import UIKit

class SponsersViewController: UIViewController {
    @IBOutlet var checkoutFooter: CheckoutFooter!

    override func viewDidLoad() {
        super.viewDidLoad()

        checkoutFooter.action = { [weak self] in
            try! AppNavigator().push(.passangersInfoScreen)
        }
    }


}
