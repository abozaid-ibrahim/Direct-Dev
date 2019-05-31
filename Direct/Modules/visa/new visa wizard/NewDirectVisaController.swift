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
    var initialTouchPoint: CGPoint = CGPoint(x: 0, y: 0)
    var defaultFrame: CGRect? {
        didSet {
            view.frame = defaultFrame ?? CGRect.zero
        }
    }

    // MARK: IBuilder ====================================>>

    @IBOutlet var dateField: SpinnerTextField!
    @IBOutlet var checkoutFooter: CheckoutFooter!
    @IBOutlet var countryField: SpinnerTextField!
    @IBOutlet var biometricField: SpinnerTextField!
    @IBOutlet var visaField: SpinnerTextField!
    @IBOutlet var passangersCountField: SpinnerTextField!
    @IBOutlet var relationsField: SpinnerTextField!
    //===================================================<<

    private let viewModel = NewDirectVisaViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        enableSwipeUpToDismiss()
        relationsField.isHidden = true
        title = "دايركت فيزا"
        viewModel.showProgress.subscribe(onNext: { [weak self] value in
            self?.showProgress = value
        }, onError: nil, onCompleted: nil, onDisposed: nil).disposed(by: disposeBag)
        checkoutFooter.action = { [weak self] in
            self?.viewModel.submitVisaRequest()
        }
        viewModel.totalCost.subscribe(onNext: {[unowned self] pr in
            self.checkoutFooter.valueText = pr
        }, onError: nil, onCompleted: nil, onDisposed: nil).disposed(by: disposeBag)
        setONClickViews()
        viewModel.viewDidLoad()
    }

    var showProgress: Bool? {
        didSet {
            if showProgress ?? false {
                Progress.show()
            } else {
                Progress.hide()
            }
        }
    }

    private func setONClickViews() {
        countryField.rx.tapGesture().when(.recognized)
            .subscribe(onNext: { _ in
                self.viewModel.showCountriesSpinner()
            }).disposed(by: disposeBag)
        viewModel.selectedCountryName.bind(to: countryField.txtField.rx.text).disposed(by: disposeBag)
        passangersCountField.rx.tapGesture().when(.recognized)
            .subscribe(onNext: { _ in
                self.viewModel.showPasangersCountSpinner()
            }).disposed(by: disposeBag)
        viewModel.passangersCount.subscribe(onNext: {value in
            self.passangersCountField.txtField.text = "\(value.0 + value.1)"
            self.relationsField.isHidden = false
        }, onError: nil, onCompleted: nil, onDisposed: nil)
        

        dateField.rx.tapGesture().when(.recognized)
            .subscribe(onNext: { _ in
                self.viewModel.showDatePickerDialog()
            }).disposed(by: disposeBag)
        viewModel.selectedDate.map { $0?.displayFormat }.bind(to: dateField.txtField.rx.text).disposed(by: disposeBag)
        visaField.rx.tapGesture().when(.recognized)
            .subscribe(onNext: { _ in
                self.viewModel.showVisaTypes()
            }).disposed(by: disposeBag)
        viewModel.selectedVisaType.bind(to: visaField.txtField.rx.text).disposed(by: disposeBag)

        biometricField.rx.tapGesture().when(.recognized)
            .subscribe(onNext: { _ in
                self.viewModel.showBiometricSpinner()
            }).disposed(by: disposeBag)
        viewModel.selectedBio.bind(to: biometricField.txtField.rx.text).disposed(by: disposeBag)

        relationsField.rx.tapGesture().when(.recognized)
            .subscribe(onNext: { _ in
                self.viewModel.showRelationsSpinner()
            }).disposed(by: disposeBag)
        viewModel.selectedRelation.bind(to: relationsField.txtField.rx.text).disposed(by: disposeBag)
    }
}
