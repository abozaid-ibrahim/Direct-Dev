//
//  NewVisaViewController.swift
//  Direct
//
//  Created by abuzeid on 4/29/19.
//  Copyright © 2019 abuzeid. All rights reserved.
//

import PanModal
import RxCocoa
import RxGesture
import RxOptional
import RxSwift
import UIKit

class NewDirectVisaController: UIViewController, SwipeUpDismissable {
    let disposeBag = DisposeBag()
    var dismessed: PublishSubject<Bool> = PublishSubject()
    var initialTouchPoint: CGPoint = CGPoint(x: 0, y: 0)
    var defaultFrame: CGRect? {
        didSet {
            view.frame = defaultFrame ?? CGRect.zero
        }
    }

    // MARK: IBuilder ====================================>>
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet var doNotesLbl: UILabel!
    @IBOutlet var totalCostPlaceholder: UILabel!

    @IBOutlet var dontNotesLbl: UILabel!
    @IBOutlet var totalCostField: UILabel!
    @IBOutlet var cobonField: UITextField!
    @IBOutlet var dateField: SpinnerTextField!
    @IBOutlet var countryField: SpinnerTextField!
    @IBOutlet var biometricField: SpinnerTextField!
    @IBOutlet var visaField: SpinnerTextField!
    @IBOutlet var passangersCountField: SpinnerTextField!
    @IBOutlet var relationsField: SpinnerTextField!
    @IBOutlet var titleLbl: UILabel!
    @IBOutlet var rightNotesContainer: UIStackView!
    @IBOutlet var wrongNotesContainer: UIStackView!
    //===================================================<<

    private let viewModel = NewDirectVisaViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        enableSwipeUpToDismiss()
        titleLbl.font = UIFont(name: AppFonts.boldFont, size: 20)
        totalCostPlaceholder.font = UIFont(name: AppFonts.boldFont, size: 15)
        totalCostField.font = UIFont(name: AppFonts.boldFont, size: 15)
        title = "دايركت فيزا"
        viewModel.showProgress.subscribe(onNext: { [weak self] value in
            self?.showProgress = value
        }, onError: nil, onCompleted: nil, onDisposed: nil).disposed(by: disposeBag)
        bindDataToUI()
        setONClickViews()
        viewModel.viewDidLoad()
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    private func bindDataToUI() {
        relationsField.isHidden = true
        wrongNotesContainer.isHidden = true
        rightNotesContainer.isHidden = true
        viewModel.doNotesText.subscribe(onNext: { [unowned self] value in
            if (value ?? "").isEmpty {
                self.rightNotesContainer.isHidden = true
            } else {
                self.rightNotesContainer.isHidden = false
                self.doNotesLbl.text = value
            }
        }, onError: nil, onCompleted: nil, onDisposed: nil).disposed(by: disposeBag)
        viewModel.dontNotesText.subscribe(onNext: { [unowned self] value in
            if (value ?? "").isEmpty {
                self.wrongNotesContainer.isHidden = true
            } else {
                self.wrongNotesContainer.isHidden = false
                self.dontNotesLbl.text = value
            }
        }, onError: nil, onCompleted: nil, onDisposed: nil).disposed(by: disposeBag)
        viewModel.totalCost.bind(to: totalCostField.rx.text).disposed(by: disposeBag)
        viewModel.selectedCountryName.bind(to: countryField.text).disposed(by: disposeBag)
        viewModel.passangersCount.map { $0 == nil ? nil : "\($0!.0 + $0!.1)" }.bind(to: passangersCountField.text).disposed(by: disposeBag)
        viewModel.selectedBio.bind(to: biometricField.text).disposed(by: disposeBag)
        viewModel.selectedRelation.bind(to: relationsField.text).disposed(by: disposeBag)
        viewModel.selectedVisaType.bind(to: visaField.text).disposed(by: disposeBag)
        viewModel.selectedDate.map { $0?.displayFormat }.bind(to: dateField.text).disposed(by: disposeBag)
        viewModel.passangersCount.map { $0 == nil ? true : ($0!.0 + $0!.1) <= 1 }.debug(">>>hide", trimOutput: true).bind(to: relationsField.rx.isHidden).disposed(by: disposeBag)



    }

    var showProgress: Bool? {
        didSet {
            if showProgress ?? false {
                Progress.show()
            } else {
                Progress.hide()
            }
        }
    }

    @IBAction func addCobonAction(_ sender: Any) {}

    @IBAction func orderAction(_ sender: Any) {
        viewModel.submitVisaRequest()
    }

    private func setONClickViews() {
        countryField.rx.tapGesture().when(.recognized)
            .subscribe(onNext: { _ in
                self.viewModel.showCountriesSpinner()
            }).disposed(by: disposeBag)
        
        passangersCountField.rx.tapGesture().when(.recognized)
            .subscribe(onNext: { _ in
                self.viewModel.showPasangersCountSpinner()
            }).disposed(by: disposeBag)

        dateField.rx.tapGesture().when(.recognized)
            .subscribe(onNext: { _ in
                self.viewModel.showDatePickerDialog()
            }).disposed(by: disposeBag)
        visaField.rx.tapGesture().when(.recognized)
            .subscribe(onNext: { _ in
                self.viewModel.showVisaTypes()
            }).disposed(by: disposeBag)

        biometricField.rx.tapGesture().when(.recognized)
            .subscribe(onNext: { _ in
                self.viewModel.showBiometricSpinner()
            }).disposed(by: disposeBag)
       
        relationsField.rx.tapGesture().when(.recognized)
            .subscribe(onNext: { _ in
                self.viewModel.showRelationsSpinner()
            }).disposed(by: disposeBag)
    }
}
