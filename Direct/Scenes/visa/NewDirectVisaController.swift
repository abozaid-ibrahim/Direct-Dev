//
//  NewVisaViewController.swift
//  Direct
//
//  Created by abuzeid on 4/29/19.
//  Copyright © 2019 abuzeid. All rights reserved.
//

import PanModal
import RxCocoa
import RxGesture
import RxSwift
import UIKit

class NewDirectVisaController: UIViewController, SwipeUpDismissable {
    let disposeBag = DisposeBag()
    var dismessed: PublishSubject<Bool> = PublishSubject()
    @IBOutlet var checkoutFooter: CheckoutFooter!
    @IBOutlet var countryField: SpinnerTextField!

    var initialTouchPoint: CGPoint = CGPoint(x: 0, y: 0)
    var defaultFrame: CGRect? {
        didSet {
            view.frame = defaultFrame ?? CGRect.zero
        }
    }

    @IBOutlet var visaField: SpinnerTextField!
    @IBOutlet var passangersCountField: SpinnerTextField!
    @IBOutlet var relationsField: SpinnerTextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        enableSwipeUpToDismiss()
        title = "دايركت فيزا"

        checkoutFooter.action = { [weak self] in
            try! AppNavigator().push(.paymentMethod)
        }

        setONClickViews()
    }

    private func setONClickViews() {
        countryField.rx.tapGesture().when(.recognized)
            .subscribe(onNext: { _ in
                let data = ["مصر", "الكويت", "بلغاريا"]
                let dest = Destination.selectableSheet(data: data)
                let vc = dest.controller() as! SelectableTableSheet
                vc.data = data
                vc.titleText = "مكان البصمة"
                vc.style = .textCenter
                vc.selectedItem.asObservable().subscribe { event in
                    switch event.event {
                    case let .next(value):
                        self.countryField.txtField.text = event.element ?? ""
                    default:
                        break
                    }

                }.disposed(by: self.disposeBag)

                self.presentPanModal(vc as! UIViewController & PanModalPresentable)
            }).disposed(by: disposeBag)

        passangersCountField.rx.tapGesture().when(.recognized)
            .subscribe(onNext: { _ in
                try! AppNavigator().presentModally(.passangersCount)
            }).disposed(by: disposeBag)

        dateField.rx.tapGesture().when(.recognized)
            .subscribe(onNext: { _ in
                try! AppNavigator().presentModally(.datePicker)
            }).disposed(by: disposeBag)

        visaField.rx.tapGesture().when(.recognized)
            .subscribe(onNext: { _ in
                try! AppNavigator().presentModally(.datePicker)
            }).disposed(by: disposeBag)
        relationsField.rx.tapGesture().when(.recognized)
            .subscribe(onNext: { _ in

                let data = ["الزوج", "الابن" ,"الزوجة"]
                let dest = Destination.selectableSheet(data: data)
                let vc = dest.controller() as! SelectableTableSheet
                vc.data = data
vc.titleText = "العلاقة بين المسافرين"
                vc.selectedItem.asObservable().subscribe { event in
                    switch event.event {
                    case let .next(value):
                        self.countryField.txtField.text = event.element ?? ""
                    default:
                        break
                    }

                }.disposed(by: self.disposeBag)

                self.presentPanModal(vc as! UIViewController & PanModalPresentable)
            }).disposed(by: disposeBag)
    }

    @IBOutlet var dateField: SpinnerTextField!
}
