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
    var formType: CountriesIDs? {
        didSet {
            applyFormRules()
        }
    }
    
    internal let disposeBag = DisposeBag()
    var contentHeight = BehaviorSubject<CGFloat>(value: 300)
    func fillParams(_ prm: inout USRequestParams) {}
    
    func isInputsValid() -> Bool {
        guard let type = formType else {
            print("exit")
            return false
        }
        
        switch type {
        case .US , CountriesIDs.GB:
            return isValidatePersonalSectionTextFields()

        default:
            return validateNameAndIdentity()
        }
    }
    
    var neededHeight: CGFloat {
        var basic = 130
        let unit = 55
        basic += isHusbandWillTravelView.isHidden ? 0 : unit
        basic += familyIDView.isHidden ? 0 : unit
        basic += martialStateView.isHidden ? 0 : unit
        basic += passportView.isHidden ? 0 : unit
        basic += personalPictureView.isHidden ? 0 : unit
        print("i>contentH \(basic)")
        return CGFloat(basic)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        pInfoSetup()
        contentHeight.onNext(neededHeight)
        onRecieveImageCallback()
    }
    
    private func applyFormRules() {
        guard let type = formType else {
            print("exit")
            return
        }
        
        switch type {
        case .US, .GB: // BR
            print("show all items")
        case .SGN , .TR:
            hideAllExcepSelfIdentity()
        case .IN ,.CN,.JP,.IE:
            hideIsHusbendWillTravelWithYou()
          
        }
    }
    
    private func hideIsHusbendWillTravelWithYou() {
        isHusbandWillTravelView.isHidden = true
        contentHeight.onNext(neededHeight)
    }
    private func hideAllExcepSelfIdentity() {
        isHusbandWillTravelView.isHidden = true
        familyIDView.isHidden = true
        martialStateView.isHidden = true
        personalPictureView.isHidden = true
        passportView.isHidden = false
        contentHeight.onNext(neededHeight)
    }
    
    private func validateNameAndIdentity() -> Bool {
        guard let params = self.params else {
            return false
        }
        if params.firstName.isValidText {
            firstNamePInfoField.setError.onNext(false)
        } else {
            firstNamePInfoField.setError.onNext(true)
            return false
        }
        if params.familyName.isValidText {
            familyNamePInfoField.setError.onNext(false)
        } else {
            familyNamePInfoField.setError.onNext(true)
            return false
        }
        if params.passportCopy.isValidText {
            passportImageField.setError.onNext(false)
        } else {
            passportImageField.setError.onNext(true)
            return false
        }
        return true
    }
    
    func isValidatePersonalSectionTextFields() -> Bool {
        guard let params = self.params else {
            return false
        }
        if !validateNameAndIdentity() {
            return false
        }
        if params.martialStatus.isValidText {
            statusPInfoField.setError.onNext(false)
        } else {
            statusPInfoField.setError.onNext(true)
            return false
        }
        if !isHusbandWillTravelView.isHidden {
            if husbundPInfoField.text.isValidText {
                husbundPInfoField.setError.onNext(false)
            } else {
                husbundPInfoField.setError.onNext(true)
                return false
            }
        }
        
        if !familyIDView.isHidden {
            if params.familyIDCopy.isValidText {
                familyIDPInfoField.setError.onNext(false)
            } else {
                familyIDPInfoField.setError.onNext(true)
                return false
            }
        }
        
        if params.personalPhotoCopy.isValidText {
            personalPhotoField.setError.onNext(false)
        } else {
            personalPhotoField.setError.onNext(true)
            return false
        }
        return true
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
    
    @IBOutlet var martialStateView: UIView!
    @IBOutlet var personalPictureView: UIView!
    @IBOutlet var passportView: UIView!
    private let dialogs = DialogBuilder()
    
    private func pInfoSetup() {
        familyIDView.isHidden = true
        isHusbandWillTravelView.isHidden = true
        statusPInfoField.rx.tapGesture().when(.recognized)
            .subscribe { _ in
                let alert = self.dialogs.buildMatrialState(callback: { [weak self] state in
                    print(state, state.string, state.apiValue)
                    guard let self = self else { return }
                    self.statusPInfoField.text = state.string
                    if state.apiValue == MartialState.single.apiValue {
                        self.isHusbandWillTravelView.isHidden = true
                    } else {
                        self.isHusbandWillTravelView.isHidden = false
                    }
                    self.params?.husbandOrWifeTravelWithYou = state.apiValue.stringValue
                    self.contentHeight.onNext(self.neededHeight)
                    
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
                    guard let self = self else { return }
                    self.params?.husbandOrWifeTravelWithYou = agreed.apiValue.stringValue
                    self.husbundPInfoField.text = agreed.string
                    if agreed.apiValue == AgreementValues.yes.apiValue {
                        self.familyIDView.isHidden = false
                    } else {
                        self.familyIDView.isHidden = true
                    }
                    self.contentHeight.onNext(self.neededHeight)
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
