//
//  DatePickerController.swift
//  Direct
//
//  Created by abuzeid on 5/10/19.
//  Copyright © 2019 abuzeid. All rights reserved.
//

import PanModal
import UIKit

class DatePickerController: UIViewController, PanModalPresentable {
    var panScrollable: UIScrollView?
    var shortFormHeight: PanModalHeight = .contentHeight(400)
    @IBOutlet private var datepicker: UIDatePicker!
    @IBOutlet private var dateLbl: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

//    @IBOutlet private weak var view:UILabel!
    private func setDate() {
        let attributedString = NSMutableAttributedString(string: "تاريخ السفر : الأربعاء ، 2019/4/6", attributes: [
            .font: UIFont(name: "Cairo-Bold", size: 14.0)!,
            .foregroundColor: UIColor(white: 61.0 / 255.0, alpha: 1.0),
        ])
        attributedString.addAttribute(.font, value: UIFont(name: "Cairo-Regular", size: 14.0)!, range: NSRange(location: 0, length: 13))
    }

    @IBAction func confirmAction(_: Any) {}
}
