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

class AddCountryViewController: UIViewController {
    var shortFormHeight: PanModalHeight = .contentHeight(180)
    @IBOutlet private var countryNameField: FloatingTextField!
    @IBOutlet private var yearField: FloatingTextField!
    private let disposeBag = DisposeBag()
    var country = PublishSubject<String>()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = Str.chooseCountryAndYear 
        countryNameField.placeholder = "the_country".localized
        yearField.placeholder = "the_year".localized
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

    @IBAction func add(_ sender: Any) {
        guard countryNameField.hasText else {
            countryNameField.setError.onNext(true)
            return
        }
        countryNameField.setError.onNext(false)

        guard yearField.hasText else {
            yearField.setError.onNext(true)
            return
        }
        yearField.setError.onNext(false)

        let row = "\(countryNameField.text ?? "")-\(yearField.text ?? "")"
        country.onNext(row)
        navigationController?.popViewController()
    }
}
