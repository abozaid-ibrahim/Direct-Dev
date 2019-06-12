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

    @IBOutlet private weak var contentView: UIView!
    @IBOutlet private var everYouTraveledLbl: UILabel!
    @IBOutlet private var everYouTraveledSegment: UISegmentedControl!
    @IBOutlet private var everTraveledDetailsSection: UIStackView!
    @IBOutlet private var previousVisaImageField: FloatingTextField!
    @IBOutlet private var arrivalDateField: UITextField!
    @IBOutlet private var durationField: UITextField!
    @IBOutlet private var licenceSegment: UISegmentedControl!
    //===================================================<<
    private let disposeBag = DisposeBag()
    
    var travelledBeforeHere: Int {
        return everYouTraveledSegment.selectedSegmentIndex
    }

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
                let hint = "Choose arrival date".localized
                try? AppNavigator().presentModally(Destination.datePicker(title: hint))
            }).disposed(by: disposeBag)
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

    private func setViewAppearance() {
        let height = everYouTraveledSegment.selectedSegmentIndex == 0 ? 90 : 250
        let hide = everYouTraveledSegment.selectedSegmentIndex == 0
        contentView.isHidden = hide
        contentHeight.onNext(CGFloat(height))
    }
}
