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
    @IBOutlet private var tabbar: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "معلومات المتكفلين"

        checkoutFooter.action = { [weak self] in
            try! AppNavigator().push(.passangersInfoScreen)
        }
        setupTabbar()
    }

    private func setupTabbar() {
        let tab1 = ("المتكفل الأول ", { [weak self] in

        })
        let tab2 = ("المتكفل الثاني ", { [weak self] in

        })
        let tab3 = ("المتكفل الثالث ", { [weak self] in

        })

        let tabar = TabBar(tabs: [tab1, tab2, tab3])
        tabar.addSubview(tabbar)
        tabar.sameBoundsTo(parentView: tabbar)
    }

    func setSponserName() {
        let attributedString = NSMutableAttributedString(string: "بيانات المتكفل بمصاريف المسافر ( عامر )", attributes: [
            .font: UIFont(name: "Cairo-Bold", size: 15.0)!,
            .foregroundColor: UIColor(white: 66.0 / 255.0, alpha: 1.0),
            .kern: 0.0,
        ])
        attributedString.addAttribute(.foregroundColor, value: UIColor(red: 253.0 / 255.0, green: 133.0 / 255.0, blue: 13.0 / 255.0, alpha: 1.0), range: NSRange(location: 31, length: 8))
    }
}
