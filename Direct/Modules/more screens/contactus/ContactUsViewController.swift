//
//  ContactUsViewController.swift
//  Direct
//
//  Created by abuzeid on 5/3/19.
//  Copyright © 2019 abuzeid. All rights reserved.
//

import RxCocoa
import RxGesture
import RxOptional
import RxSwift
import UIKit

class ContactUsViewController: UIViewController {
    private let viewModel = ContactUsViewModel()

    @IBOutlet private var phoneLbl: UILabel!
    @IBOutlet private var timingLbl: UILabel!
    @IBOutlet private var chatLbl: UILabel!
    @IBOutlet private var emailTitle1Lbl: UILabel!
    @IBOutlet private var emailDesc1Lbl: UILabel!
    @IBOutlet private var emailTitle2Lbl: UILabel!
    @IBOutlet private var emailDesc2Lbl: UILabel!
    @IBOutlet private var emailTitle3Lbl: UILabel!
    @IBOutlet private var emailDesc3Lbl: UILabel!
    @IBOutlet private var nameField: FloatingTextField!
    @IBOutlet private var emailField: FloatingTextField!
    @IBOutlet private var phoneField: FloatingTextField!
    @IBOutlet private var subjectField: FloatingTextField!
    @IBOutlet private var submitBtn: UIButton!

    private let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupForm()
        bindData()
    }

    private func setupForm() {
        let inputs = Observable.combineLatest(nameField.rx.text,
                                              phoneField.rx.text,
                                              emailField.rx.text,
                                              subjectField.rx.text)
        let inputsValid = inputs.map { $0.0.isValidText && $0.1.isValidText && $0.2!.isValidEmail && $0.3.isValidText }
        inputsValid.bind(to: submitBtn.rx.isEnabled).disposed(by: disposeBag)
        inputsValid.map { $0 ? UIColor.appPumpkinOrange : UIColor.disabledBtnBg }.bind(to: submitBtn.rx.backgroundColor).disposed(by: disposeBag)

        Observable.combineLatest(submitBtn.rx.tapGesture().when(.recognized), inputs).subscribe(onNext: { [unowned self] _, prm in
            self.viewModel.submit(name: prm.0!, email: prm.1!, phone: prm.2!, subject: prm.3!)

        }).disposed(by: disposeBag)
    }

    private func bindData() {
        let model = viewModel.textValues.filterNil()
        model.map { $0.contactNumber }.filterNil().bind(to: phoneLbl.rx.text).disposed(by: disposeBag)
        model.map { $0.chatTitle }.filterNil().bind(to: chatLbl.rx.text).disposed(by: disposeBag)
        model.map { $0.timingsLine }.filterNil().bind(to: timingLbl.rx.text).disposed(by: disposeBag)

        // 2
        model.map { $0.emailDesc1 }.filterNil().bind(to: emailDesc1Lbl.rx.text).disposed(by: disposeBag)

        model.map { $0.emailTitle1 }.filterNil().bind(to: emailTitle1Lbl.rx.text).disposed(by: disposeBag)
        // 2
        model.map { $0.emailDesc2 }.filterNil().bind(to: emailDesc2Lbl.rx.text).disposed(by: disposeBag)

        model.map { $0.emailTitle2 }.filterNil().bind(to: emailTitle2Lbl.rx.text).disposed(by: disposeBag)
        // 3
        model.map { $0.emailDesc3 }.filterNil().bind(to: emailDesc3Lbl.rx.text).disposed(by: disposeBag)

        model.map { $0.emailTitle3 }.filterNil().bind(to: emailTitle3Lbl.rx.text).disposed(by: disposeBag)
    }
}
