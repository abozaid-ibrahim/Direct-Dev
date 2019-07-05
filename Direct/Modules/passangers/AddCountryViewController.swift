//
//  AddCountryViewController.swift
//  Direct
//
//  Created by abuzeid on 7/5/19.
//  Copyright © 2019 abuzeid. All rights reserved.
//

import PanModal
import RxSwift
import UIKit

class AddCountryViewController: UIViewController, PanModalPresentable {
    var panScrollable: UIScrollView? {
        return nil //tableView
    }

    var shortFormHeight: PanModalHeight = .contentHeight(180)

    @IBOutlet var countryNameField: UITextField!
    @IBOutlet var yearField: UITextField!
    private let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()

        let title = "اختر اسم الدولة وعام السفر"
        self.title = title
        view.backgroundColor = UIColor.appVeryLightGray
        countryNameField.textColor = UIColor.appVeryLightGray
        countryNameField.placeholder = "the_country".localized
        countryNameField.textColor = UIColor.black
        countryNameField.font = UIFont.appRegularFontWith(size: 14)

        yearField.textColor = UIColor.appVeryLightGray
        yearField.placeholder = "the_year".localized
        yearField.textColor = UIColor.black
        yearField.font = UIFont.appRegularFontWith(size: 14)

        yearField.rx.tapGesture().when(.recognized)
            .debug()
            .subscribe { _ in
                let date = Date()
                let format = DateFormatter()
                format.dateFormat = "yyyy"
                let calendar = Calendar.current
                let x = calendar.component(.year, from: date)
                let yearsArray = [x, x - 1, x - 2, x - 3, x - 4].map { "\($0)" }
                let dest = Destination.selectableSheet(data: yearsArray, titleText: Str.choose, style: .textCenter)
                let vc = dest.controller() as! SelectableTableSheet
                vc.selectedItem.subscribe(onNext: { value in
                    self.yearField.text = value
                }).disposed(by: self.disposeBag)

                try! AppNavigator().presentModally(vc)
            }.disposed(by: disposeBag)
    }

    @IBAction func cancel(_ sender: Any) {
        navigationController?.popViewController()
    }

    var country = PublishSubject<String>()
    @IBAction func add(_ sender: Any) {
        if countryNameField.hasText, yearField.hasText {
            let row = "\(countryNameField.text ?? "")-\(yearField.text ?? "")"
            country.onNext(row)

        } else {
            //            alert.message = "ادخل الصيغه الصحيحه"
        }

        navigationController?.popViewController()
    }
}
