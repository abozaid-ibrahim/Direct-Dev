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
    var selectedDuration = PublishSubject<Period?>()
    var stayPeriod: [Period] = []

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
        getPeriod()
    }

    private func addActionsToFields() {
        arrivalDateField.neverShowKeypad()
        arrivalDateField.rx.tapGesture().when(.recognized)
            .subscribe(onNext: { _ in

                self.showDatePickerDialog()
            }).disposed(by: disposeBag)
        selectedDate.map { $0?.displayFormat }.bind(to: arrivalDateField.rx.text).disposed(by: disposeBag)
        durationField.neverShowKeypad()
        durationField.rx.tapGesture().when(.recognized)
            .subscribe(onNext: { _ in

                self.showDurationSpinner()
            }).disposed(by: disposeBag)
        selectedDate.map { $0?.displayFormat }.bind(to: arrivalDateField.rx.text).disposed(by: disposeBag)
        selectedDuration.map { $0?.name ?? "" }.bind(to: durationField.rx.text).disposed(by: disposeBag)
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

    private let network = ApiClientFacade()
    var selectedRelation = PublishSubject<String?>()

    var relativesList: [USRelative] = []
    func getPeriod() {
        let rel = network.getStayPeriod()
        rel.debug().subscribe(onNext: { [weak self] bios in
            self?.stayPeriod.removeAll()
            self?.stayPeriod.append(contentsOf: bios.periods ?? [])
        }, onError: nil, onCompleted: nil, onDisposed: nil).disposed(by: disposeBag)
    }

    private func showDurationSpinner() {
        let bios = stayPeriod.map { $0.name ?? "" }
        let dest = Destination.selectableSheet(data: bios, titleText: "Choose".localized, style: .textCenter)
        let vc = dest.controller() as! SelectableTableSheet
        vc.selectedItem.asDriver(onErrorJustReturn: "").drive(onNext: { value in
            let bio = self.stayPeriod.filter { $0.name == value }
            self.selectedDuration.onNext(bio.first)
        }).disposed(by: disposeBag)
        try! AppNavigator().presentModally(vc)
    }

    private func showDatePickerDialog() {
        let hint = "Choose".localized
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
        let height = everYouTraveledSegment.selectedSegmentIndex == 0 ? 90 : 260
        let hide = everYouTraveledSegment.selectedSegmentIndex == 0
        contentView.isHidden = hide
        contentHeight.onNext(CGFloat(height))
    }
}
