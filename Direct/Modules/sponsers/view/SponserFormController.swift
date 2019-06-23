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
protocol BaseViewController {
    var disposeBag: DisposeBag { get }
    var showProgress: BehaviorRelay<Bool> { get }
}

extension BaseViewController {
    func subscribeToProgress() {
        showProgress.subscribe(onNext: { value in

            if value {
                Progress.show()
            } else {
                Progress.hide()
            }

        }).disposed(by: disposeBag)
    }
}

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
    private let viewModel = SponserFormViewModel()
    var showProgress = BehaviorRelay<Bool>(value: false)

    // MARK: dependencies

    var index: Int?
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.getSponsorOwners()
        viewModel.showProgress.bind(to: showProgress).disposed(by: disposeBag)
        subscribeToProgress()
        configureBinding()
    }

    private func configureBinding() {
        // sponser name
        bindSpName()
        bindImage()
        bindLastPage()
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
        try! AppNavigator().push(.successPackage)
    }

    @IBAction func accountStatementBoxChanged(_ sender: M13Checkbox) {
        accountStatementPageView.isHidden = sender.checkState == .checked
    }

    // image
    @IBAction func accountLetterCheckBoxChanged(sender: M13Checkbox) {
        accountSalaryLetterImageView.isHidden = sender.checkState == .checked
    }

    func setSponserName() {
        let attributedString = NSMutableAttributedString(string: "بيانات المتكفل بمصاريف المسافر ( عامر )", attributes: [
            .font: UIFont(name: "Cairo-Bold", size: 15.0)!,
            .foregroundColor: UIColor(white: 66.0 / 255.0, alpha: 1.0),
            .kern: 0.0,
        ])
        attributedString.addAttribute(.foregroundColor, value: UIColor(red: 253.0 / 255.0, green: 133.0 / 255.0, blue: 13.0 / 255.0, alpha: 1.0), range: NSRange(location: 31, length: 8))
    }
}

class ImagePickerView: UIView, ImagePicker {
    var disposeBag = DisposeBag()
    var currentImageID: Int = 0

    var receivedImage = PublishSubject<(String?, UIImage?)>()
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        let image = info[.originalImage] as? UIImage
        let fileUrl = info[.imageURL] as? URL
        receivedImage.onNext((fileUrl?.lastPathComponent, image?.apiSize()))
        picker.dismiss(animated: true, completion: nil)
    }
}
