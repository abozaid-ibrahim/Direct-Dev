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


    func setSponserName(){
        let attributedString = NSMutableAttributedString(string: "بيانات المتكفل بمصاريف المسافر ( عامر )", attributes: [
            .font: UIFont(name: "Cairo-Bold", size: 15.0)!,
            .foregroundColor: UIColor(white: 66.0 / 255.0, alpha: 1.0),
            .kern: 0.0
            ])
        attributedString.addAttribute(.foregroundColor, value: UIColor(red: 253.0 / 255.0, green: 133.0 / 255.0, blue: 13.0 / 255.0, alpha: 1.0), range: NSRange(location: 31, length: 8))
    }
}
