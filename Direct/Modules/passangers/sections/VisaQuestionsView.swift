//
//  VisaQuestionsView.swift
//  Direct
//
//  Created by abuzeid on 6/16/19.
//  Copyright © 2019 abuzeid. All rights reserved.
//

import M13Checkbox
import RxCocoa
import RxGesture
import RxSwift
import UIKit

class VisaQuestionsView: UIView, ImagePicker {
    // MARK: IBuilder ====================================>>
    
    @IBOutlet var relativesView: UIView!
    @IBOutlet private var relativeInCountryLbl: UILabel!
    @IBOutlet private var relativeINCountrySegment: UISegmentedControl!
    @IBOutlet private var relativityField: FloatingTextField!
    // cancelation
    @IBOutlet var visaCanceledBeforeView: UIView!
    @IBOutlet private var cancelationReasonField: FloatingTextField!
    @IBOutlet private var visaCancelationLbl: UILabel!
    @IBOutlet private var visaCancelationSegment: UISegmentedControl!
    // previous visa
    @IBOutlet var hasPreviousVisaSegment: UISegmentedControl!
    @IBOutlet var previousVisaLbl: UILabel!
    @IBOutlet var previousVisaView: UIView!
    @IBOutlet var previousVisaImageField: FloatingTextField!
    @IBOutlet private var previousVisaIsAvaliableBox: M13Checkbox!
    @IBOutlet private var previousVisaNoImageContainer: UIView!
    @IBOutlet private var previousVisaCountryField: FloatingTextField!
    @IBOutlet private var previousVisaTypeField: FloatingTextField!
    @IBOutlet private var previousVisaDateField: FloatingTextField!
    @IBOutlet private var checkboxContainer: UIView!
    //===================================================<<
    
    var params: VisaRequirementsParams?
    var countryName: String! {
        didSet {
            previousVisaLbl.text = "هل سبق وحصلت على تأشيرة " + countryString + Str.before
            relativeInCountryLbl.text = "هل لديك اى اقارب فى " + countryString + "؟"
            visaCancelationLbl.text = "هل تم رفض دخولك أو الغاء تأشيرتك الى " + countryString + Str.before
        }
    }
    
    // ImagePicker
    var currentImageID: Int = 0
    private let previousVisaImageID = 99
    var receivedImage = PublishSubject<(String?, UIImage?)>()
    var formType: CountriesIDs? {
        didSet {
            applyFormRules()
        }
    }
    
    let viewModel = VisaQuestionsViewModel()
    
    private let dialogs = DialogBuilder()
    private var countryString: String {
        return " \(countryName ?? "") "
    }
    
    internal let disposeBag = DisposeBag()
    var contentHeight = BehaviorSubject<CGFloat>(value: 618)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setup()
        contentHeight.onNext(neededHeight)
    }
    
    private func setup() {
        setFonts()
        cancelReasonSwitch()
        relativeSwitchChanged()
        changePreviousVisaSelection()
        questionsSetup()
        onRecieveImageCallback()
        viewModel.getRelatives()
        viewModel.getPreviousVisaTypes()
    }
    
    @IBOutlet var cancelViewHeight: NSLayoutConstraint!
    @IBOutlet var relativesViewHeight: NSLayoutConstraint!
    @IBOutlet var previousVisaViewHeight: NSLayoutConstraint!
    func isInputsValid() -> Bool {
        guard formType != nil else {
            return false
        }
        if !relativityField.isHidden {
            guard relativityField.hasText else {
                relativityField.setError.onNext(true)
                return false
            }
            relativityField.setError.onNext(false)
        }
        if !cancelationReasonField.isHidden {
            guard cancelationReasonField.hasText else {
                cancelationReasonField.setError.onNext(true)
                return false
            }
            cancelationReasonField.setError.onNext(false)
        }
        if (!previousVisaImageField.isHidden) && self.previousVisaIsAvaliableBox.checkState == .unchecked{
            guard previousVisaImageField.hasText else {
                previousVisaImageField.setError.onNext(true)
                return false
            }
            previousVisaImageField.setError.onNext(false)
        }
        if previousVisaIsAvaliableBox.checkState == .checked {
            guard previousVisaTypeField.hasText else {
                previousVisaTypeField.setError.onNext(true)
                return false
            }
            previousVisaTypeField.setError.onNext(false)
            
            guard previousVisaDateField.hasText else {
                previousVisaDateField.setError.onNext(true)
                return false
            }
            previousVisaDateField.setError.onNext(false)
            
            guard previousVisaCountryField.hasText else {
                previousVisaCountryField.setError.onNext(true)
                return false
            }
            previousVisaCountryField.setError.onNext(false)
        }
        return true
    }
    
    var neededHeight: CGFloat {
        var basic = 10
        if !visaCanceledBeforeView.isHidden {
            basic += 90
            if visaCancelationSegment.selectedSegmentIndex == Segment.yes {
                basic += 49
            }
        }
        if !relativesView.isHidden {
            basic += 90
            if relativeINCountrySegment.selectedSegmentIndex == Segment.yes {
                basic += 49
            }
        }
        
        if !previousVisaView.isHidden {
            basic += 90
            if hasPreviousVisaSegment.selectedSegmentIndex == Segment.yes { 
                basic += 89
            }
            // add bottom view
            if previousVisaIsAvaliableBox.checkState == .checked { //textfield appear
                basic += 145
            }
        }
        
        return CGFloat(basic)
    }
    
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        emitImageInfo(receivedImage, picker, didFinishPickingMediaWithInfo: info)
    }
    
    var prevVisaImageAvaliable = BehaviorRelay<Bool>(value: true)
    @IBAction func onVisaAvaliableChanged(_ sender: M13Checkbox) {
        prevVisaImageAvaliable.accept(sender.checkState != .checked)
        contentHeight.onNext(neededHeight)
    }
    
    private func applyFormRules() {
        guard let type = formType else {
            print("exit")
            return
        }
        
        switch type {
        case .US: // BR
            relativesView.isHidden = false
            visaCanceledBeforeView.isHidden = false
            previousVisaView.isHidden = false
            
        case .GB: // BR
            relativesView.isHidden = false
            visaCanceledBeforeView.isHidden = false
            previousVisaView.isHidden = true
        case .SGN:
            relativesView.isHidden = true
            visaCanceledBeforeView.isHidden = true
            
        case .TR:
            relativesView.isHidden = true
            visaCanceledBeforeView.isHidden = true
        case .IE:
            relativesView.isHidden = true
            visaCanceledBeforeView.isHidden = true
        case .IN, .CN:
            relativesView.isHidden = true
            visaCanceledBeforeView.isHidden = true
        case .JP:
            relativesView.isHidden = true
            visaCanceledBeforeView.isHidden = true
        }
        contentHeight.onNext(neededHeight)
    }
    
    private func setFonts() {
        visaCancelationSegment.appFont()
        relativeINCountrySegment.appFont()
        hasPreviousVisaSegment.appFont()
        visaCancelationLbl.font = .appBoldFontWith(size: 15)
        relativeInCountryLbl.font = .appBoldFontWith(size: 15)
        previousVisaLbl.font = .appBoldFontWith(size: 15)
        visaCancelationLbl.textColor = UIColor.appBlack
        relativeInCountryLbl.textColor = UIColor.appBlack
        previousVisaLbl.textColor = UIColor.appBlack
    }
    
    private func onRecieveImageCallback() {
        receivedImage.filter { $0.0 != nil }.subscribe(onNext: { [unowned self] value in
            if self.currentImageID == self.previousVisaImageID {
                self.params?.visaReqID = value.1?.convertImageToBase64String()
                self.previousVisaImageField.text = value.0
            }
        }).disposed(by: disposeBag)
    }
    
    private func questionsSetup() {
        // ever you travedled
        previousVisaImageField.neverShowKeypad()
        previousVisaImageField.rx.tapGesture().when(.recognized)
            .subscribe { _ in
                self.showImagePicker(id: self.previousVisaImageID)
            }.disposed(by: disposeBag)
        
        relativityField.neverShowKeypad()
        relativityField.rx.tapGesture().when(.recognized)
            .subscribe { _ in
                self.dialogs.buildRelationsSpinner(self.disposeBag, self.viewModel.relativesList, selected: { relative in
                    self.params?.relative_type = relative.id.int ?? 0
                    self.relativityField.text = relative.name
                })
            }.disposed(by: disposeBag)
        
        viewModel.selectedRelation.bind(to: relativityField.rx.text).disposed(by: disposeBag)
        previousVisaSetup()
    }
    
    private func previousVisaSetup() {
//        date
        previousVisaIsAvaliableBox.applyAppCheckBoxStyle()
        prevVisaImageAvaliable.bind(to: previousVisaNoImageContainer.rx.isHidden).disposed(by: disposeBag)
        viewModel.selectedDate.map { $0?.displayFormat }.bind(to: previousVisaDateField.rx.text).disposed(by: disposeBag)
        viewModel.selectedDate.map { $0?.apiFormat }.subscribe(onNext: {[unowned self] value in
            self.params?.periodOfPreviousStay  = value
        }).disposed(by: disposeBag)

        previousVisaDateField.neverShowKeypad()
        previousVisaDateField.rx.tapGesture().when(.recognized)
            .subscribe(onNext: { _ in
                self.viewModel.showDatePickerDialog()
            }).disposed(by: disposeBag)
// type
        previousVisaTypeField.neverShowKeypad()
        viewModel.selectedVisaType.subscribe(onNext: { [unowned self] value in
            self.params?.typeOfPreviousVisa = value.id
        }).disposed(by: disposeBag)
        viewModel.selectedVisaType.map { $0.name }.bind(to: previousVisaTypeField.rx.text).disposed(by: disposeBag)
        previousVisaTypeField.rx.tapGesture().when(.recognized)
            .subscribe(onNext: { _ in
                self.viewModel.showVisaTypes()
            }).disposed(by: disposeBag)
        
        
        //country
//        previousVisaCountryField.rx.text.subscribe(onNext: {[unowned self] value in
//            self.params.cou
//        }).disposed(by: disposeBag)
    }
    
    @IBAction func hasPreviousVisaChanged(_: UISegmentedControl) {
        changePreviousVisaSelection()
        contentHeight.onNext(neededHeight)
    }
    
    private func changePreviousVisaSelection() {
        if hasPreviousVisaSegment.selectedSegmentIndex == Segment.no {
            previousVisaImageField.isHidden = true
            checkboxContainer.isHidden = true
            previousVisaViewHeight.constant = 90
        } else {
            previousVisaImageField.isHidden = false
            previousVisaViewHeight.constant = 135
            checkboxContainer.isHidden = false
        }
    }
    
    @IBAction func cancelReasonChanged(_: UISegmentedControl) {
        cancelReasonSwitch()
        contentHeight.onNext(neededHeight)
    }
    
    private func cancelReasonSwitch() {
        if visaCancelationSegment.selectedSegmentIndex == Segment.no {
            cancelationReasonField.isHidden = true
            cancelViewHeight.constant = 90
        } else {
            cancelationReasonField.isHidden = false
            cancelViewHeight.constant = 135
        }
    }
    
    @IBAction func hasRelativeDidChange(_: UISegmentedControl) {
        relativeSwitchChanged()
        contentHeight.onNext(neededHeight)
    }
    
    private func relativeSwitchChanged() {
        if relativeINCountrySegment.selectedSegmentIndex == Segment.no {
            relativityField.isHidden = true
            relativesViewHeight.constant = 90
        } else {
            relativityField.isHidden = false
            relativesViewHeight.constant = 135
        }
    }
}
