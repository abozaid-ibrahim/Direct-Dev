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
    @IBOutlet private var setPageLaterBox: M13Checkbox!
    @IBOutlet private var setAccountImageLaterBox: M13Checkbox!

    @IBOutlet private var accountPageField: FloatingTextField!
    @IBOutlet private var accountImageField: FloatingTextField!
    @IBOutlet private var detailsView: UIStackView!
    @IBOutlet private var submitBtn: UIButton!
    internal let disposeBag = DisposeBag()
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
        setPageLaterBox.applyAppCheckBoxStyle()
        setAccountImageLaterBox.applyAppCheckBoxStyle()
    }

    private func configureBinding() {
        // sponser name
        bindSpName()
        bindImage()
        bindLastPage()
        viewModel.formResult.bind(to: formResult).disposed(by: disposeBag)
    }

    private func bindImage() {
        accountImageField.neverShowKeypad()
        accountImageField.rx
            .tapGesture()
            .when(.recognized)
            .subscribe(onNext: { _ in
                self.accountSalaryLetterImageView.showImagePicker()
            }).disposed(by: disposeBag)

        viewModel.imageSubject.bind(to: accountImageField.rx.text).disposed(by: disposeBag)

        accountSalaryLetterImageView.receivedImage.filter { $0.0 != nil }
            .subscribe(onNext: { [unowned self] value in
                guard let img = value.1?.convertImageToBase64String() else {
                    return
                }

                self.viewModel.params.bankStmtAttachment = img
                self.viewModel.imageSubject.onNext(value.0)

            }).disposed(by: disposeBag)
    }

    private func bindLastPage() {
        accountPageField.neverShowKeypad()
        accountPageField.rx
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
                self.viewModel.pageSubject.onNext(value.0)

            }).disposed(by: disposeBag)

        viewModel.pageSubject.bind(to: accountPageField.rx.text).disposed(by: disposeBag)
    }

    private func bindSpName() {
        accountOwnerField.neverShowKeypad()
        let onClick = accountOwnerField.rx
            .tapGesture()
            .when(.recognized)
        Observable.combineLatest(
            onClick, viewModel.sponserOwnersSubject,
            resultSelector: { value1, value2 in
                print("\(value1) \(value2)")
                self.showAccountOwnerDialog(sponsers: value2)
        }).observeOn(MainScheduler.instance)
            .subscribe()
            .disposed(by: disposeBag)

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
        viewModel.validateAndSubmit()
    }

    @IBAction func accountStatementBoxChanged(_ sender: M13Checkbox) {
        accountStatementPageView.isHidden = sender.checkState == .checked
    }

    // image
    @IBAction func accountLetterCheckBoxChanged(sender: M13Checkbox) {
        accountSalaryLetterImageView.isHidden = sender.checkState == .checked
    }
}

extension M13Checkbox {
    func applyAppCheckBoxStyle() {
        boxType = .square
        checkState = .unchecked
        hideBox = false
        secondaryCheckmarkTintColor = UIColor.appPumpkinOrange
        secondaryTintColor = UIColor.gray
        markType = .checkmark
        boxLineWidth = 1.5
        checkmarkLineWidth = 1.5
        stateChangeAnimation = .fill
    }
}
