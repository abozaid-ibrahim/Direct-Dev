//
//  PassangersQuestionsStepVC.swift
//  Direct
//
//  Created by abuzeid on 6/11/19.
//  Copyright © 2019 abuzeid. All rights reserved.
//

import RxSwift
import UIKit

class PassangersQuestionsStepVC: UIViewController {
    // MARK: IBuilder ====================================>>

    @IBOutlet private var contentView: UIView!
    @IBOutlet private var everYouTraveledLbl: UILabel!
    @IBOutlet private var everYouTraveledSegment: UISegmentedControl!
    @IBOutlet private var everTraveledDetailsSection: UIStackView!
    @IBOutlet private var previousVisaImageField: FloatingTextField!
    @IBOutlet private var arrivalDateField: UITextField!
    @IBOutlet private var durationField: UITextField!
    @IBOutlet private var licenceSegment: UISegmentedControl!
    //===================================================<<
    private let disposeBag = DisposeBag()
    var selectedDate = PublishSubject<Date?>()
    var selectedDuration = PublishSubject<String?>()

    var travelledBeforeHere: Int {
        return everYouTraveledSegment.selectedSegmentIndex
    }

    var travel_date: String?
    var haveLicense: Int {
        return licenceSegment.selectedSegmentIndex
    }

    var contentHeight = BehaviorSubject<CGFloat>(value: 90)

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        addActionsToFields()
        setViewAppearance()
    }

    private func addActionsToFields() {
        arrivalDateField.rx.tapGesture().when(.recognized)
            .subscribe(onNext: { _ in

                self.showDatePickerDialog()
            }).disposed(by: disposeBag)
        selectedDate.map { $0?.displayFormat }.bind(to: arrivalDateField.rx.text).disposed(by: disposeBag)
        
        durationField.rx.tapGesture().when(.recognized)
            .subscribe(onNext: { _ in
                
                self.showDurationSpinner()
            }).disposed(by: disposeBag)
        selectedDate.map { $0?.displayFormat }.bind(to: arrivalDateField.rx.text).disposed(by: disposeBag)
        selectedDuration.bind(to: durationField.rx.text).disposed(by: disposeBag)

    }

    private func setupUI() {
        licenceSegment.appFont()
        everYouTraveledSegment.appFont()
        arrivalDateField.neverShowKeypad()
        durationField.neverShowKeypad()
    }

    @IBAction func everTraveledChanged(_ sender: UISegmentedControl) {
        setViewAppearance()
    }
    private func  showDurationSpinner() {
        let bios = ["day","month","year"]
        let dest = Destination.selectableSheet(data: bios, titleText: "Choose".localized, style: .textCenter)
        let vc = dest.controller() as! SelectableTableSheet
        vc.selectedItem.asObservable().subscribe { event in
            switch event.event {
            case let .next(value):
//                let bio = self.relativesList.filter { $0.name == value }
//                if let bioObj = bio.first {
//                    self.visaRequestData.relation_with_travelers = bioObj.id
//                    self.visaRequestData.relation_with_travelersText = bioObj.name
//                }
                
                self.selectedDuration.onNext(value)
                
            default:
                break
            }
            
            }.disposed(by: disposeBag)
        try! AppNavigator().presentModally(vc)
    }
    private func showDatePickerDialog() {
        let hint = "Choose arrival date".localized
        let dest = Destination.datePicker(title: hint)
        let vc = dest.controller() as! DatePickerController
        vc.selectedDate.asObservable().subscribe { event in
            switch event.event {
            case let .next(value):
                self.travel_date = value!.apiFormat
                self.selectedDate.onNext(value)
            default:
                break
            }

        }.disposed(by: disposeBag)
        try! AppNavigator().presentModally(vc)
    }

    private func setViewAppearance() {
        let height = everYouTraveledSegment.selectedSegmentIndex == 0 ? 90 : 250
        let hide = everYouTraveledSegment.selectedSegmentIndex == 0
        contentView.isHidden = hide
        contentHeight.onNext(CGFloat(height))
    }
}
