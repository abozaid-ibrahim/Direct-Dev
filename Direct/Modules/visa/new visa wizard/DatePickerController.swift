//
//  DatePickerController.swift
//  Direct
//
//  Created by abuzeid on 5/10/19.
//  Copyright © 2019 abuzeid. All rights reserved.
//

import JBDatePicker
import PanModal
import UIKit
import RxSwift

class DatePickerController: UIViewController, PanModalPresentable {
    @IBOutlet var datePicker: JBDatePickerView!

    var panScrollable: UIScrollView?
    var shortFormHeight: PanModalHeight = .contentHeight(400)
    @IBOutlet private var dateLbl: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        datePicker.delegate = self
    }

    private func setDate(date:Date) {
//         "تاريخ السفر : الأربعاء ، 2019/4/6"
        let str = "\(date)  تاريخ السفر:"
        let attributedString = NSMutableAttributedString(string:str, attributes: [
            .font: UIFont(name: AppFonts.regularFont, size: 14.0)!,
            .foregroundColor: UIColor(white: 61.0 / 255.0, alpha: 1.0),
        ])
        attributedString.addAttribute(.font, value: UIFont(name: AppFonts.regularFont, size: 14.0)!, range: NSRange(location: 0, length: 13))
        dateLbl.attributedText  = attributedString
    }

    var selectedDate = PublishSubject<Date?>()

    @IBAction func confirmAction(_: Any) {
        dismiss(animated: true, completion: nil)
    }
}

extension DatePickerController: JBDatePickerViewDelegate {
    // MARK: - JBDatePickerViewDelegate implementation

    func didSelectDay(_ dayView: JBDatePickerDayView) {
        print("date selected: \(String(describing: dayView.date))")
        self.selectedDate.onNext(dayView.date)
        self.setDate(date: dayView.date!)
    }

}
