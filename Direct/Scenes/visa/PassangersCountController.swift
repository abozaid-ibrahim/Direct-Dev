//
//  PassangersCountController.swift
//  Direct
//
//  Created by abuzeid on 5/9/19.
//  Copyright © 2019 abuzeid. All rights reserved.
//

import PanModal
import UIKit

class PassangersCountController: UIViewController, PanModalPresentable {
    var panScrollable: UIScrollView?
    var shortFormHeight: PanModalHeight = .contentHeight(350)

    @IBOutlet private var countLbl: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        setCount()
    }

    func setCount() {
        let attributedString = NSMutableAttributedString(string: "عدد المسافرين : 3 أطفال ، 2 بالغين", attributes: [
            .font: UIFont(name: AppFonts.boldFont, size: 14.0)!,
            .foregroundColor: UIColor(white: 61.0 / 255.0, alpha: 1.0),
        ])
        attributedString.addAttribute(.font, value: UIFont(name: AppFonts.regularFont, size: 14.0)!, range: NSRange(location: 0, length: 15))
    }
}
