//
//  SponserFormController.swift
//  Direct
//
//  Created by abuzeid on 6/22/19.
//  Copyright © 2019 abuzeid. All rights reserved.
//

import M13Checkbox
import RxCocoa
import RxOptional
import RxSwift
import UIKit

class SponserFormController: UIViewController, BaseViewController {
//

    @IBOutlet private var accountOwnerField: FloatingTextField!
    @IBOutlet private var accountSalaryLetterImageView: ImagePickerView!
    @IBOutlet private var accountStatementPageView: ImagePickerView!
    @IBOutlet private var setAccountStateLaterBox: M13Checkbox!
    @IBOutlet private var setSalaryLetterLaterBox: M13Checkbox!
    @IBOutlet private var accountStatementField: FloatingTextField!
    @IBOutlet private var accountSalaryLetterField: FloatingTextField!
    @IBOutlet private var detailsView: UIStackView!
    @IBOutlet private var submitBtn: UIButton!
    internal let disposeBag = DisposeBag()
    private var enableSubmit = PublishSubject<Bool>()
    var formResult = PublishSubject<UploadSponserInfoResponse>()

    private lazy var viewModel = SponserFormViewModel(index: index!, type: relationType!, visaReqID: reqID!, cid: cid!)
    var showProgress = BehaviorRelay<Bool>(value: false)

    // MARK: dependencies

    var index: Int?
    var reqID: String?
    var relationType: String?
    var cid: String?
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.getSponsorOwners()
        viewModel.showProgress.bind(to: showProgress).disposed(by: disposeBag)
        subscribeToProgress()
        configureBinding()
        setupUI()
    }

    private func setupUI() {
        setAccountStateLaterBox.applyAppCheckBoxStyle()
        setSalaryLetterLaterBox.applyAppCheckBoxStyle()
    }

    private func configureBinding() {
        // sponser name
        bindSpName()
        bindSalaryLetter()
        bindLastAccountStatementPage()
        viewModel.formResult.bind(to: formResult).disposed(by: disposeBag)
        // disable button until text is valid
        disableBtnUntilValidate()
    }

    private func disableBtnUntilValidate() {
        // set button state
        enableSubmit.startWith(false)
            .bind(to: submitBtn.rx.isEnabled)
            .disposed(by: disposeBag)
        enableSubmit.startWith(false)
            .map { $0 ? UIColor.appPumpkinOrange : UIColor.disabledBtnBg }
            .bind(to: submitBtn.rx.backgroundColor)
            .disposed(by: disposeBag)
        // validate items
        bindFieldsToButton()
    }

    private func bindFieldsToButton() {
        let validName = viewModel.selectedSponsor
            .map { $0.name.isValidText }
            .startWith(false)

        let validAccStatement = Observable.combineLatest(viewModel.lastAccountStatment, viewModel.setAccountStatementLater)
            .map { $0.0.isValidText || $0.1 }
            .debug()
        let validLetter = Observable.combineLatest(viewModel.sallaryLetterSubject, viewModel.setSalaryLetterLater)
            .map { $0.0.isValidText || $0.1 }
            .debug()
        Observable.combineLatest(validName, validAccStatement, validLetter)
            .map { $0.0 && $0.1 && $0.2 }
            .debug()
            .bind(to: enableSubmit)
            .disposed(by: disposeBag)
    }

    private func bindSalaryLetter() {
        viewModel.sallaryLetterSubject.bind(to: accountSalaryLetterField.rx.text)
            .disposed(by: disposeBag)
        viewModel.setSalaryLetterLater.bind(to: accountSalaryLetterImageView.rx.isHidden)
            .disposed(by: disposeBag)

        accountSalaryLetterField.neverShowKeypad()
        accountSalaryLetterField.rx
            .tapGesture()
            .when(.recognized)
            .subscribe(onNext: { _ in
                self.accountSalaryLetterImageView.showImagePicker()
            }).disposed(by: disposeBag)

        accountSalaryLetterImageView.receivedImage.filter { $0.0 != nil }
            .subscribe(onNext: { [unowned self] value in
                guard let img = value.1?.convertImageToBase64String() else {
                    return
                }

                self.viewModel.params.bankStmtAttachment = img
                self.viewModel.sallaryLetterSubject.onNext(value.0)

            }).disposed(by: disposeBag)
    }

    private func bindLastAccountStatementPage() {
        viewModel.lastAccountStatment.bind(to: accountStatementField.rx.text).disposed(by: disposeBag)
        viewModel.setAccountStatementLater.bind(to: accountStatementPageView.rx.isHidden).disposed(by: disposeBag)
        accountStatementField.neverShowKeypad()
        accountStatementField.rx
            .tapGesture()
            .when(.recognized)
            .subscribe(onNext: { _ in
                self.accountStatementPageView.showImagePicker()
            }).disposed(by: disposeBag)
        accountStatementPageView.receivedImage.filter { $0.0 != nil }
            .subscribe(onNext: { [unowned self] value in
                guard let img = value.1?.convertImageToBase64String() else {
                    return
                }
                self.viewModel.params.jobLetterAttachment = img
                self.viewModel.lastAccountStatment.onNext(value.0)

            }).disposed(by: disposeBag)
    }

    private func bindSpName() {
        accountOwnerField.neverShowKeypad()
        let onClick = accountOwnerField.rx
            .tapGesture()
            .when(.recognized)
        Observable.combineLatest(onClick, viewModel.sponserOwnersSubject)
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { [unowned self] value in
                if value.1.count > 0{
                    self.showAccountOwnerDialog(sponsers: value.1)
                    
                }else{
                    self.accountOwnerField.inputView = nil
                    self.accountOwnerField.becomeFirstResponder()
                    let sp = SponsorOwener(name: " ", id: nil, status: nil, success: nil)
                    self.viewModel.selectedSponsor.onNext(sp)
                }
            }).disposed(by: disposeBag)

        viewModel.selectedSponsor.map { $0.name }.filterNil().bind(to: accountOwnerField.rx.text).disposed(by: disposeBag)
        viewModel.selectedSponsor.map {
            ($0.name ?? "").isEmpty
        }
        .startWith(true)
        .debug()
        .bind(to: detailsView.rx.isHidden)
        .disposed(by: disposeBag)
    }

    func showAccountOwnerDialog(sponsers: [SponsorOwener]) {
        let alert = UIAlertController(title: Str.choose, message: nil, preferredStyle: .actionSheet)
        alert.applyAppStyle()
        guard sponsers.isNotEmpty else {
            return
        }
        for sp in sponsers {
            let search = UIAlertAction(title: sp.name ?? "", style: .default, handler: { [weak self] _ in
                guard let `self` = self else { return }
                self.viewModel.selectedSponsor.onNext(sp)
            })

            alert.addAction(search)
        }
        let cancel = UIAlertAction(title: Str.cancel, style: .cancel, handler: nil)
        alert.addAction(cancel)

        present(alert, animated: true, completion: nil)
    }

    @IBAction func checkoutNextAction(_: Any) {
        viewModel.validateAndSubmit(name: accountOwnerField.text)
    }

    @IBAction func accountStatementBoxChanged(_ sender: M13Checkbox) {
        viewModel.setAccountStatementLater.onNext(sender.checkState == .checked)
    }

    // image
    @IBAction func accountLetterCheckBoxChanged(sender: M13Checkbox) {
        viewModel.setSalaryLetterLater.onNext(sender.checkState == .checked)
    }
}
