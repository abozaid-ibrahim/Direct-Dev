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
    // previous visa
    @IBOutlet var hasPreviousVisaSegment: UISegmentedControl!
    @IBOutlet var previousVisaLbl: UILabel!
    @IBOutlet var previousVisaView: UIView!
    @IBOutlet var previousVisaImageField: FloatingTextField!
    //===================================================<<
    
    var params: USRequestParams?
    var countryName: String!
    
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
    }
    
    private func setup() {
        setFonts()
        cancelReasonSwitch()
        relativeSwitchChanged()
        changePreviousVisaSelection()
        questionsSetup()
        onRecieveImageCallback()
    }
    
    @IBOutlet weak var cancelViewHeight: NSLayoutConstraint!
    @IBOutlet weak var relativesViewHeight: NSLayoutConstraint!
    @IBOutlet weak var previousVisaViewHeight: NSLayoutConstraint!
    func isInputsValid() -> Bool {
        guard let type = formType else {
            return false
        }
        if !relativesView.isHidden {
            guard relativityField.hasText else {
                relativityField.setError.onNext(true)
                return false
            }
            relativityField.setError.onNext(false)
        }
        if !visaCanceledBeforeView.isHidden {
            guard cancelationReasonField.hasText else {
                cancelationReasonField.setError.onNext(true)
                return false
            }
            cancelationReasonField.setError.onNext(false)
        }
        if !previousVisaView.isHidden {
            guard previousVisaImageField.hasText else {
                previousVisaImageField.setError.onNext(true)
                return false
            }
            previousVisaImageField.setError.onNext(false)
        }
        return true
    }
    
    var neededHeight: CGFloat {
        var basic = 10
        let unit = 140
        basic += visaCanceledBeforeView.isHidden ? 0 : unit
        basic += relativesView.isHidden ? 0 : unit
        basic += previousVisaView.isHidden ? 0 : unit
        if !relativesView.isHidden {
            basic -= relativityField.isHidden ? 50 : 0
        }
        if !visaCanceledBeforeView.isHidden {
            basic -= cancelationReasonField.isHidden ? 50 : 0
        }
        if !previousVisaView.isHidden {
            basic -= previousVisaImageField.isHidden ? 50 : 0
        }
        return CGFloat(basic)
    }
    
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        let image = info[.originalImage] as? UIImage
        let fileUrl = info[.imageURL] as? URL
        receivedImage.onNext((fileUrl?.lastPathComponent, image?.apiSize()))
        picker.dismiss(animated: true, completion: nil)
    }
    
    private func applyFormRules() {
        guard let type = formType else {
            print("exit")
            return
        }
        
        switch type {
        case .US, .GB: // BR
            relativesView.isHidden = false
            visaCanceledBeforeView.isHidden = false
            previousVisaView.isHidden = true
        case .SGN:
            relativesView.isHidden = true
            visaCanceledBeforeView.isHidden = true
            
        case .TR:
            relativesView.isHidden = true
            visaCanceledBeforeView.isHidden = true
        case .IN, .CN, .JP, .IE:
            relativesView.isHidden = true
            visaCanceledBeforeView.isHidden = true
        }
        contentHeight.onNext(neededHeight)
    }
    
    private func setFonts() {
        visaCancelationSegment.appFont()
        relativeINCountrySegment.appFont()
        hasPreviousVisaSegment.appFont()
    }
    
    private func onRecieveImageCallback() {
        receivedImage.filter { $0.0 != nil }.subscribe(onNext: { [unowned self] value in
            if self.currentImageID == self.previousVisaImageID {
                self.params?.visaReqID = value.1?.convertImageToBase64String()
                self.previousVisaImageField.text = value.0
            }
            
        }, onError: nil, onCompleted: nil, onDisposed: nil).disposed(by: disposeBag)
    }
    
    private func questionsSetup() {
        // ever you travedled
        previousVisaLbl.text = "هل سبق وحصلت على تأشيرة " + countryString + Str.before
        relativeInCountryLbl.text = "هل لديك اى اقارب فى " + countryString + "؟"
        visaCancelationLbl.text = "هل تم رفض دخولك أو الغاء تأشيرتك الى " + countryString + Str.before
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
    }
    
    @IBAction func hasPreviousVisaChanged(_: UISegmentedControl) {
        changePreviousVisaSelection()
        contentHeight.onNext(neededHeight)
    }
    
    private func changePreviousVisaSelection() {
        if hasPreviousVisaSegment.selectedSegmentIndex == Segment.no {
            previousVisaImageField.isHidden = true
            previousVisaViewHeight.constant = 90
        } else {
            previousVisaImageField.isHidden = false
            previousVisaViewHeight.constant = 135
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
