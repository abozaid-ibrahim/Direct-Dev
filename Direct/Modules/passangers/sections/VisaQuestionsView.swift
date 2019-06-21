//
//  VisaQuestionsView.swift
//  Direct
//
//  Created by abuzeid on 6/16/19.
//  Copyright © 2019 abuzeid. All rights reserved.
//

import RxCocoa
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
    //===================================================<<
    
    var params: USRequestParams?
    var countryName: String!

    // ImagePicker
    var currentImageID: Int = 0
    private let visaImageID = 32
    var receivedImage = PublishSubject<(String?, UIImage?)>()
    var formType: CountriesIDs? {
        didSet {
            applyFormRules()
        }
    }
    let viewModel = VisaQuestionsViewModel()

    private let dialogs = DialogBuilder()
    private var countryString: String {
        return countryName ?? ""
    }
    internal let disposeBag = DisposeBag()
    var contentHeight = BehaviorSubject<CGFloat>(value: 200)
    
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
        onRecieveImageCallback()
    }
    
    private func setup() {
        setFonts()
    }
    
    func fillParams(_: inout USRequestParams) {}
    
    func isInputsValid() -> Bool {
        guard let type = formType else {
            print("exit")
            return false
        }
        
        switch type {
        case .US, CountriesIDs.GB:
            return validateHasRelatives()
            
        default:
            return validateVisaCancelation()
        }
    }
    
    var neededHeight: CGFloat {
        var basic = 10
        let unit = 140
        basic += visaCanceledBeforeView.isHidden ? 0 : unit
        basic += relativesView.isHidden ? 0 : unit
        return CGFloat(basic)
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
            print("hida all")
        case .IN, .CN, .JP, .IE:
            print("hida all")
        }
    }
    
    private func setFonts() {
        visaCancelationSegment.appFont()
        relativeINCountrySegment.appFont()
    }
    
    private func onRecieveImageCallback() {
        receivedImage.filter { $0.0 != nil }.subscribe(onNext: { [unowned self] value in
            if self.currentImageID == self.visaImageID {
                self.params?.visaReqID = value.1?.convertImageToBase64String()
//                self.previousVisaImageField.text = value.0
            }
            
        }, onError: nil, onCompleted: nil, onDisposed: nil).disposed(by: disposeBag)
    }
    
    private func questionsSetup() {
        switch formType! {
        case .US, .GB:
            relativesView.isHidden = false
            visaCanceledBeforeView.isHidden = false
            
        case .TR:
            relativesView.isHidden = true
            visaCanceledBeforeView.isHidden = true
            
        default:
            relativesView.isHidden = true
            visaCanceledBeforeView.isHidden = true
        }
        // ever you travedled
//        previousVisaLbl.text = "هل سبق وحصلت على تأشيرة " + countryString + Str.before
        relativeInCountryLbl.text = "هل لديك اى اقارب فى " + countryString + "؟"
        visaCancelationLbl.text = "هل تم رفض دخولك أو الغاء تأشيرتك الى " + countryString + Str.before
//        previousVisaImageField.neverShowKeypad()
//        previousVisaImageField.rx.tapGesture().when(.recognized)
//            .subscribe { _ in
//                //                self.showImagePicker(id: self.visaImageID)
//            }.disposed(by: disposeBag)
       
        relativityField.neverShowKeypad()
        relativityField.rx.tapGesture().when(.recognized)
            .subscribe { _ in
                self.dialogs.buildRelationsSpinner(self.disposeBag,self.viewModel.relativesList, selected: {relative in
                    self.params?.relative_type = relative.id.int ?? 0
                    self.relativityField.text = relative.name
                })
            }.disposed(by: disposeBag)
        viewModel.selectedRelation.bind(to: relativityField.rx.text).disposed(by: disposeBag)
    }
    
    @IBAction func cancelReasonChanged(_: UISegmentedControl) {
        cancelReasonSwitch()
    }
    
    private func cancelReasonSwitch() {
        if visaCancelationSegment.selectedSegmentIndex == Segment.no {
            cancelationReasonField.isHidden = true
        } else {
            cancelationReasonField.isHidden = false
        }
    }
    
    @IBAction func hasRelativeDidChange(_: UISegmentedControl) {
        relativeSwitchChanged()
    }
    
    private func validateVisaCancelation() -> Bool {
        return false
    }
    
    private func validateHasRelatives() -> Bool {
        return false
    }
    
    private func relativeSwitchChanged() {
        if relativeINCountrySegment.selectedSegmentIndex == Segment.no {
            relativityField.isHidden = true
        } else {
            relativityField.isHidden = false
        }
    }
}
