//
//  SponserFormController.swift
//  Direct
//
//  Created by abuzeid on 6/22/19.
//  Copyright © 2019 abuzeid. All rights reserved.
//

import M13Checkbox
import RxCocoa
import RxSwift
import UIKit

class SponserFormController: UIViewController {
    @IBOutlet private var accountOwnerField: FloatingTextField!
    @IBOutlet private var accountImageView: AccountImageView!
    @IBOutlet private var accountPageField: FloatingTextField!
    @IBOutlet private var accountImageField: FloatingTextField!
    @IBOutlet private var submitBtn: UIButton!
    var index: Int?
    private let disposeBag = DisposeBag()
    let viewModel = SponserFormViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        Observable.combineLatest(viewModel.nameSubject,
                                 viewModel.imageSubject,
                                 viewModel.pageSubject,
                                 resultSelector: { _, _, _ in

        })

        accountImageField.rx.tapGesture().when(.recognized)
            .subscribe(onNext: { _ in
                self.accountImageView.showImagePicker()
            }).disposed(by: disposeBag)

        accountImageView.receivedImage.filter { $0.0 != nil }.subscribe(onNext: { [unowned self] value in
            guard let img = value.1?.convertImageToBase64String() else {
                return
            }
//                self.params?.familyIDCopy = img
            self.accountImageField.text = value.0
        }, onError: nil, onCompleted: nil, onDisposed: nil).disposed(by: disposeBag)
    }

    @IBAction func checkoutNextAction(_: Any) {}

    @IBAction func accountPageCheckBoxChanged(_: M13Checkbox) {}

    func setSponserName() {
        let attributedString = NSMutableAttributedString(string: "بيانات المتكفل بمصاريف المسافر ( عامر )", attributes: [
            .font: UIFont(name: "Cairo-Bold", size: 15.0)!,
            .foregroundColor: UIColor(white: 66.0 / 255.0, alpha: 1.0),
            .kern: 0.0,
        ])
        attributedString.addAttribute(.foregroundColor, value: UIColor(red: 253.0 / 255.0, green: 133.0 / 255.0, blue: 13.0 / 255.0, alpha: 1.0), range: NSRange(location: 31, length: 8))
    }
}



class AccountImageView: UIView, ImagePicker {
    var disposeBag = DisposeBag()
    var currentImageID: Int = 0
    var accountImageID: Int = 44
    var receivedImage = PublishSubject<(String?, UIImage?)>()
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        let image = info[.originalImage] as? UIImage
        let fileUrl = info[.imageURL] as? URL
        receivedImage.onNext((fileUrl?.lastPathComponent, image?.apiSize()))
        picker.dismiss(animated: true, completion: nil)
    }
}
