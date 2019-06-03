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
    @IBOutlet weak var doNotesLbl: UILabel!
    
    @IBOutlet weak var dontNotesLbl: UILabel!
    @IBOutlet var totalCostField: UILabel!
    @IBOutlet var cobonField: UITextField!
    @IBOutlet var dateField: SpinnerTextField!
    @IBOutlet var countryField: SpinnerTextField!
    @IBOutlet var biometricField: SpinnerTextField!
    @IBOutlet var visaField: SpinnerTextField!
    @IBOutlet var passangersCountField: SpinnerTextField!
    @IBOutlet var relationsField: SpinnerTextField!
    @IBOutlet weak var rightNotesContainer: UIStackView!
    @IBOutlet weak var wrongNotesContainer: UIStackView!
    //===================================================<<

    private let viewModel = NewDirectVisaViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        enableSwipeUpToDismiss()
//        relationsField.isHidden = true
        title = "دايركت فيزا"
        viewModel.showProgress.subscribe(onNext: { [weak self] value in
            self?.showProgress = value
        }, onError: nil, onCompleted: nil, onDisposed: nil).disposed(by: disposeBag)
        self.wrongNotesContainer.isHidden = true
        self.rightNotesContainer.isHidden = true
        viewModel.priceNotes.subscribe(onNext: {[unowned self] value in
           let notes = value.filter{$0.note_type != nil}
            let rightNotes = notes.filter{$0.note_type ?? -1 == 1}.map{$0.text ?? ""}
            let dontNotes = notes.filter{$0.note_type ?? -1 == 0}.map{$0.text ?? ""}
            self.doNotesLbl.text = rightNotes.joined(separator: "\n-")
             self.dontNotesLbl.text = dontNotes.joined(separator: "\n-")
            if self.doNotesLbl.text!.isEmpty{
                self.rightNotesContainer.isHidden = false

            }
            if self.dontNotesLbl.text!.isEmpty{
                self.wrongNotesContainer.isHidden = false
                
            }
            }, onError: nil, onCompleted: nil, onDisposed:  nil).disposed(by: disposeBag)
            
        viewModel.totalCost.bind(to: totalCostField.rx.text).disposed(by: disposeBag)
        setONClickViews()
        viewModel.viewDidLoad()
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
        viewModel.selectedCountryName.bind(to: countryField.text).disposed(by: disposeBag)

        passangersCountField.rx.tapGesture().when(.recognized)
            .subscribe(onNext: { _ in
                self.viewModel.showPasangersCountSpinner()
            }).disposed(by: disposeBag)
        viewModel.passangersCount.map { $0 == nil ? nil : "\($0!.0 + $0!.1)" }.bind(to: passangersCountField.text).disposed(by: disposeBag)

        dateField.rx.tapGesture().when(.recognized)
            .subscribe(onNext: { _ in
                self.viewModel.showDatePickerDialog()
            }).disposed(by: disposeBag)
        viewModel.selectedDate.map { $0?.displayFormat }.bind(to: dateField.text).disposed(by: disposeBag)
        visaField.rx.tapGesture().when(.recognized)
            .subscribe(onNext: { _ in
                self.viewModel.showVisaTypes()
            }).disposed(by: disposeBag)
        viewModel.selectedVisaType.bind(to: visaField.text).disposed(by: disposeBag)

        biometricField.rx.tapGesture().when(.recognized)
            .subscribe(onNext: { _ in
                self.viewModel.showBiometricSpinner()
            }).disposed(by: disposeBag)
        viewModel.selectedBio.bind(to: biometricField.text).disposed(by: disposeBag)

        relationsField.rx.tapGesture().when(.recognized)
            .subscribe(onNext: { _ in
                self.viewModel.showRelationsSpinner()
            }).disposed(by: disposeBag)
        viewModel.selectedRelation.bind(to: relationsField.text).disposed(by: disposeBag)
    }
}
