//
//  PersonalInfoView.swift
//  Direct
//
//  Created by abuzeid on 6/15/19.
//  Copyright © 2019 abuzeid. All rights reserved.
//

import RxSwift
import UIKit

class PersonalInfoView: UIView, PassangerInputsSection, ImagePicker {
    var params: USRequestParams?
    
    // ImagePicker
    var currentImageID: Int = 0
    private let familyImageID = 30
    private let passportImageID = 31
    private let visaImageID = 32
    private let personalPhotoID = 35
    var receivedImage = PublishSubject<(String?, UIImage?)>()
    
    var formType: CountriesIDs
    internal let disposeBag = DisposeBag()
    var contentHeight = BehaviorSubject<CGFloat>(value: 300)
    func fillParams(_ prm: inout USRequestParams) {}
    
    func isInputsValid() -> Bool {
        return true
    }
    
    override init(frame: CGRect) {
        self.formType = .US
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.formType = .US
        super.init(coder: aDecoder)
    }
    
    convenience init(formType: CountriesIDs) {
        self.init(frame: CGRect.zero)
        fromNib()
        self.formType = formType
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        pInfoSetup()
        onRecieveImageCallback()
        applyFormRules()
    }
    
    private func applyFormRules() {
        switch formType {
        case .US:
            print("donothing")
            
        case .GB:
            print("donothing")
        case .SGN:
            print("donothing")
        case .IN:
            print("donothing")
        case .CN:
            print("donothing")
        case .JP:
            print("donothing")
        case .IE:
            print("donothing")
        case .TR:
            statusPInfoField.isHidden = true
        }
    }
    
    // Family
    @IBOutlet var firstNamePInfoField: FloatingTextField!
    @IBOutlet var familyNamePInfoField: FloatingTextField!
    @IBOutlet var personalPhotoField: FloatingTextField!
    @IBOutlet var statusPInfoField: FloatingTextField!
    @IBOutlet var isHusbandWillTravelView: UIView!
    @IBOutlet var husbundPInfoField: FloatingTextField!
    @IBOutlet var familyIDView: UIView!
    @IBOutlet var familyIDPInfoField: FloatingTextField!
    @IBOutlet var passportImageField: FloatingTextField!
    
    private let dialogs = DialogBuilder()
    
    private func pInfoSetup() {
        familyIDView.isHidden = true
        isHusbandWillTravelView.isHidden = true
        statusPInfoField.rx.tapGesture().when(.recognized)
            .subscribe { _ in
                let alert = self.dialogs.buildMatrialState(callback: { [weak self] state in
                    print(state, state.string, state.apiValue)
                    self?.statusPInfoField.text = state.string
                    if state.apiValue == MartialState.single.apiValue {
                        self?.isHusbandWillTravelView.isHidden = false
                    } else {
                        self?.isHusbandWillTravelView.isHidden = true
                    }
                    self?.params?.husbandOrWifeTravelWithYou = state.apiValue.stringValue
                    
                })
                try! AppNavigator().present(alert)
            }.disposed(by: disposeBag)
        familyIDPInfoField.neverShowKeypad()
        familyIDPInfoField.rx.tapGesture().when(.recognized)
            .subscribe { _ in
                self.showImagePicker(id: self.familyImageID)
            }.disposed(by: disposeBag)
        
        passportImageField.neverShowKeypad()
        passportImageField.rx.tapGesture().when(.recognized)
            .subscribe { _ in
                self.showImagePicker(id: self.passportImageID)
            }.disposed(by: disposeBag)
        husbundPInfoField.rx.tapGesture().when(.recognized)
            .subscribe { _ in
                let alert = self.dialogs.buildAgreemnetDialog(callback: { [weak self] agreed in
                    self?.params?.husbandOrWifeTravelWithYou = agreed.apiValue.stringValue
                    self?.husbundPInfoField.text = agreed.string
                    if agreed.apiValue == AgreementValues.yes.apiValue {
                        self?.familyIDView.isHidden = false
                    } else {
                        self?.familyIDView.isHidden = true
                    }
                })
                try! AppNavigator().present(alert)
                
            }.disposed(by: disposeBag)
        
        personalPhotoField.neverShowKeypad()
        personalPhotoField.rx.tapGesture().when(.recognized)
            .subscribe { _ in
                self.showImagePicker(id: self.personalPhotoID)
            }.disposed(by: disposeBag)
    }
    
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        let image = info[.editedImage] as? UIImage
        let fileUrl = info[.imageURL] as? URL
        receivedImage.onNext((fileUrl?.lastPathComponent, image))
        
        picker.dismiss(animated: true, completion: nil)
    }
    
    private func onRecieveImageCallback() {
        receivedImage.filter { $0.0 != nil }.subscribe(onNext: { [unowned self] value in
            if self.currentImageID == self.familyImageID {
                self.params?.familyIDCopy = value.1?.convertImageToBase64String()
                self.familyIDPInfoField.text = value.0
                
            } else if self.currentImageID == self.passportImageID {
                self.params?.passportCopy = value.1?.convertImageToBase64String()
                self.passportImageField.text = value.0
            } else if self.currentImageID == self.personalPhotoID {
                self.params?.personalPhotoCopy = value.1?.convertImageToBase64String()
                self.personalPhotoField.text = value.0
            }
            
        }, onError: nil, onCompleted: nil, onDisposed: nil).disposed(by: disposeBag)
    }
}
