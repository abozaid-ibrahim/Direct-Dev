//
//  PersonalInfoView.swift
//  Direct
//
//  Created by abuzeid on 6/15/19.
//  Copyright © 2019 abuzeid. All rights reserved.
//

import Photos
import RxSwift
import UIKit

enum VisaType {
    case study, torrerist
}

class PersonalInfoView: UIView, PassangerInputsSection, ImagePicker {
    var params: USRequestParams?
    var visaType: VisaType?
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
    @IBOutlet var acceptanceImageField: FloatingTextField!
    @IBOutlet var titleLbl: UILabel!
    
    @IBOutlet var acceptanceVisaView: UIView!
    @IBOutlet var martialStateView: UIView!
    @IBOutlet var personalPictureView: UIView!
    @IBOutlet var passportView: UIView!
    private let dialogs = DialogBuilder()
    
    // ImagePicker
    var currentImageID: Int = 0
    private let familyImageID = 30
    private let passportImageID = 31
    private let visaImageID = 32
    private let personalPhotoID = 35
    private let acceptanceUniversityID = 36
    
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
        let type = formType!
        
        switch type {
        case .US, CountriesIDs.GB:
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
        basic += acceptanceVisaView.isHidden ? 0 : unit
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
        titleLbl.font = .appBoldFontWith(size: 15)
        titleLbl.textColor = UIColor.appBlack
    }
    
    private func applyFormRules() {
        guard let type = formType else {
            print("exit")
            return
        }
        
        switch type {
        case .US, .GB: // BR
            print("show all items")
        case .SGN, .TR:
            hideAllExcepSelfIdentity()
        case .IN, .CN, .JP, .IE:
            hideIsHusbendWillTravelWithYou()
        }
        if visaType! == .study {
            acceptanceVisaView.isHidden = false
        } else {
            acceptanceVisaView.isHidden = true
        }
        contentHeight.onNext(neededHeight)
    }
    
    private func hideIsHusbendWillTravelWithYou() {
        isHusbandWillTravelView.isHidden = true
        contentHeight.onNext(neededHeight)
    }
    
    private func hideAllExcepSelfIdentity() {
        isHusbandWillTravelView.isHidden = true
        martialStateView.isHidden = false
        personalPictureView.isHidden = true
        familyIDView.isHidden = true
        passportView.isHidden = false
        contentHeight.onNext(neededHeight)
    }
    
    private func validateNameAndIdentity() -> Bool {
        guard let params = self.params else {
            return false
        }
        params.firstName = firstNamePInfoField.text
        params.familyName = familyNamePInfoField.text
        
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
        if visaType! == .study {
            if params.universityAcceptanceImage.isValidText {
                acceptanceImageField.setError.onNext(false)
            } else {
                acceptanceImageField.setError.onNext(true)
                return false
            }
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
    
    private func pInfoSetup() {
        familyIDView.isHidden = true
        isHusbandWillTravelView.isHidden = true
        statusPInfoField.neverShowKeypad()
        statusPInfoField.rx.tapGesture().when(.recognized)
            .subscribe { _ in
                let alert = self.dialogs.buildMatrialState(callback: { [weak self] state in
                    guard let self = self else { return }
                    self.statusPInfoField.text = state.string
                    if state.apiValue == MartialState.single.apiValue {
                        self.isHusbandWillTravelView.isHidden = true
                        self.showFamilyIDView(isSingle: true)
                    } else {
                        self.isHusbandWillTravelView.isHidden = false
                        self.showFamilyIDView(isSingle: false)
                    }
                    
                    self.params?.martialStatus = state.apiValue.stringValue
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
        
        acceptanceImageField.neverShowKeypad()
        acceptanceImageField.rx.tapGesture().when(.recognized)
            .subscribe { _ in
                self.showImagePicker(id: self.acceptanceUniversityID)
            }.disposed(by: disposeBag)
    }
    
    private func showFamilyIDView(isSingle: Bool) {
        guard let type = self.formType else { return }
        switch type {
        case .US:
            familyIDView.isHidden = isSingle
            
        default:
            familyIDView.isHidden = true
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        emitImageInfo(receivedImage, picker, didFinishPickingMediaWithInfo: info)
    }
    
    private func onRecieveImageCallback() {
        receivedImage.filter { $0.0 != nil }.subscribe(onNext: { [unowned self] value in
            guard let img = value.1?.convertImageToBase64String() else {
                return
            }
            
            if self.currentImageID == self.familyImageID {
                self.params?.familyIDCopy = img
                self.familyIDPInfoField.text = value.0
                
            } else if self.currentImageID == self.passportImageID {
                self.params?.passportCopy = img
                self.passportImageField.text = value.0
            } else if self.currentImageID == self.personalPhotoID {
                self.params?.personalPhotoCopy = img
                self.personalPhotoField.text = value.0
            } else if self.currentImageID == self.acceptanceUniversityID {
                self.params?.universityAcceptanceImage = img
                self.acceptanceImageField.text = value.0
            }
            
        }).disposed(by: disposeBag)
    }
}

