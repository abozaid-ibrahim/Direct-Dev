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

class SponserFormController: UIViewController, HaveLoading {
//
    var currentImageID: Int = 0
    private let passportCopyId = 30
    @IBOutlet private var accountOwnerField: FloatingTextField!
    @IBOutlet private var accountSalaryLetterImageView: ImagePickerView!
    @IBOutlet private var accountStatementPageView: ImagePickerView!
    @IBOutlet private var passportView: ImagePickerView!
    @IBOutlet private var setAccountStateLaterBox: M13Checkbox!
    @IBOutlet private var setSalaryLetterLaterBox: M13Checkbox!
    @IBOutlet private var accountStatementField: FloatingTextField!
    @IBOutlet private var accountSalaryLetterField: FloatingTextField!
    @IBOutlet private var detailsView: UIStackView!
    @IBOutlet private var submitBtn: UIButton!
    @IBOutlet private var someoneElseContainer: UIView!
    @IBOutlet private var someoneElseRealtivityField: FloatingTextField!
    @IBOutlet private var someoneElsePassportField: FloatingTextField!
    @IBOutlet private var someoneElseHeight: NSLayoutConstraint!
    internal let disposeBag = DisposeBag()
    private var enableSubmit = PublishSubject<Bool>()
    var formResult = PublishSubject<UploadSponserInfoResponse>()

    private func setTextFieldsHints(){
        accountOwnerField.placeholder = "Account Owner".localized()
    }
    private lazy var viewModel = SponserFormViewModel(index: index!, type: relationType!, visaReqID: reqID!, cid: cid!)

    // MARK: dependencies

    var index: Int?
    var reqID: String?
    var relationType: String?
    var cid: String?
    override func viewDidLoad() {
        super.viewDidLoad()
        subscribeToProgress(viewModel.showProgress)
        configureBinding()
        setupUI()
        _ = viewModel.getRelatives() // caching relatives
        someOneElseSetup()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.getSponsorOwners()
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
        let validLetter = Observable.combineLatest(viewModel.sallaryLetterSubject, viewModel.setSalaryLetterLater)
            .map { $0.0.isValidText || $0.1 }
        Observable.combineLatest(validName, validAccStatement, validLetter)
            .map { $0.0 && $0.1 && $0.2 }
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
                if value.1.count > 0 {
                    self.showAccountOwnerDialog(sponsers: value.1)

                } else {
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
        .bind(to: detailsView.rx.isHidden)
        .disposed(by: disposeBag)
    }

    private let dialogs = DialogBuilder()
    private func someOneElseSetup() {
        let onClick = someoneElseRealtivityField.rx.tapGesture().when(.recognized)
        Observable.combineLatest(onClick, viewModel.getRelatives())
            .subscribe(onNext: { [unowned self] value in
                self.dialogs.buildRelationsSpinner(self.disposeBag, value.1.relatives, selected: { relative in
                    self.viewModel.relationType = relative.id
                    self.someoneElseRealtivityField.text = relative.name
                })
            }).disposed(by: disposeBag)

        viewModel.selectedSponsor.map { $0.id }
            .filterNil()
            .map { $0 == "0" ? 100 : 0 }
            .bind(to: someoneElseHeight.rx.constant)
            .disposed(by: disposeBag)
        someoneElsePassportField.rx.tapGesture().when(.recognized)
            .subscribe(onNext: { _ in
                self.passportView.showImagePicker(id: self.passportCopyId)
            }).disposed(by: disposeBag)
        onRecieveImageCallback()
    }

    func showAccountOwnerDialog(sponsers: [SponsorOwener]) {
        let alert = UIAlertController(title: Str.choose.localized(), message: nil, preferredStyle: .actionSheet)
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
        let cancel = UIAlertAction(title: Str.cancel.localized(), style: .cancel, handler: nil)
        alert.addAction(cancel)

        present(alert, animated: true, completion: nil)
    }

    @IBAction func checkoutNextAction(_: Any) {
        viewModel.params.someoneElse = 1
        viewModel.validateAndSubmit(name: accountOwnerField.text)
    }

    @IBAction func accountStatementBoxChanged(_ sender: M13Checkbox) {
        viewModel.setAccountStatementLater.onNext(sender.checkState == .checked)
    }

    // image
    @IBAction func accountLetterCheckBoxChanged(sender: M13Checkbox) {
        viewModel.setSalaryLetterLater.onNext(sender.checkState == .checked)
    }

    private func onRecieveImageCallback() {
        passportView.receivedImage.filter { $0.0 != nil }.subscribe(onNext: { [unowned self] value in
            guard let img = value.1?.convertImageToBase64String() else {
                return
            }
            self.viewModel.params.someoneElseAttachment = img
            self.someoneElsePassportField.text = value.0
        }).disposed(by: disposeBag)
    }
}
