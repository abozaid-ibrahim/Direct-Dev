//
//  DatePickerController.swift
//  Direct
//
//  Created by abuzeid on 5/10/19.
//  Copyright © 2019 abuzeid. All rights reserved.
//

import JBDatePicker
import PanModal
import RxSwift
import SwifterSwift
import UIKit

class DatePickerController: UIViewController, PanModalPresentable {
    @IBOutlet var datePicker: JBDatePickerView!
    @IBOutlet private var tilteLbl: UILabel!
    var panScrollable: UIScrollView?
    var shortFormHeight: PanModalHeight = .contentHeight(420)
    @IBOutlet private var dateLbl: UILabel!
    var pickerTitle: String?
    override func viewDidLoad() {
        super.viewDidLoad()
        datePicker.delegate = self
        dateChanged.map { $0 > Date() }.bind(to: submitBtn.rx.isEnabled).disposed(by: disposeBag)
        dateChanged.map { $0 > Date() ? UIColor.appPumpkinOrange : UIColor.disabledBtnBg }.bind(to: submitBtn.rx.backgroundColor).disposed(by: disposeBag)

        if let title = self.pickerTitle {
            tilteLbl.text = title
        }
    }

    private let disposeBag = DisposeBag()
    private func setDatetoHeaderLbl(date: Date) {
        let str = "تاريخ السفر" + ": " + date.displayFormat
        let attributedString = NSMutableAttributedString(string: str, attributes: [
            .font: UIFont(name: AppFonts.regularFont, size: 14.0)!,
            .foregroundColor: UIColor(white: 61.0 / 255.0, alpha: 1.0),
        ])
        attributedString.addAttribute(.font, value: UIFont(name: AppFonts.regularFont, size: 14.0)!, range: NSRange(location: 0, length: 13))
        dateLbl.attributedText = attributedString
    }

    var selectedDate = PublishSubject<Date?>()
    var dateChanged = PublishSubject<Date>()

    @IBAction func confirmAction(_: Any) {
        guard let pickedDate = date else {
            return
        }
        guard pickedDate > Date() else {
            return
        }
        selectedDate.onNext(date)
        dismiss(animated: true, completion: nil)
    }

    @IBOutlet var submitBtn: UIButton!
    @IBOutlet var currentMonthLbl: UILabel!
    @IBAction func loadNextMonth(_: Any) {
        datePicker.loadNextView()
    }

    @IBAction func loadPreviousMonth(_: Any) {
        datePicker.loadPreviousView()
    }

    private var date: Date!
}

extension DatePickerController: JBDatePickerViewDelegate {
    var shouldShowMonthOutDates: Bool { return false }
    var weekDaysViewHeightRatio: CGFloat { return 0.2 }
    var fontForDayLabel: JBFont { return JBFont(name: AppFonts.regularFont, size: .medium) }
    var fontForWeekDaysViewText: JBFont { return JBFont(name: AppFonts.regularFont, size: .medium) }
    var colorForSelelectedDayLabel: UIColor { return UIColor.white }
    var colorForWeekDaysViewBackground: UIColor { return UIColor.clear }
    var colorForWeekDaysViewText: UIColor { return UIColor.gray }
    var colorForSelectionCircleForOtherDate: UIColor { return UIColor.appMango }
    var colorForCurrentDay: UIColor { return UIColor.appMango }
    var colorForSelectionCircleForToday: UIColor { return UIColor.appMango }

    func didSelectDay(_ dayView: JBDatePickerDayView) {
        if let date = dayView.date {
            dateChanged.onNext(date)
            self.date = date
            setDatetoHeaderLbl(date: date)
        }
    }

    func didPresentOtherMonth(_ monthView: JBDatePickerMonthView) {
        currentMonthLbl.text = monthView.monthDescription
    }
}

extension Date {
    var displayFormat: String {
        let outputFormatter = DateFormatter()
        outputFormatter.locale = Locale(identifier: "ar")
        outputFormatter.dateFormat = "E, d MMM yyyy"
        return outputFormatter.string(from: self)
    }

    var apiFormat: String {
        let outputFormatter = DateFormatter()
        outputFormatter.locale = Locale(identifier: "en")
        outputFormatter.dateFormat = "dd-MM-yyyy"
        return outputFormatter.string(from: self)
    }
}
