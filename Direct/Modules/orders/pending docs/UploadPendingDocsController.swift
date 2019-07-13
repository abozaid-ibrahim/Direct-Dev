//
//  UploadAttachController.swift
//  Direct
//
//  Created by abuzeid on 7/9/19.
//  Copyright © 2019 abuzeid. All rights reserved.
//

import PanModal
import RxSwift
import UIKit

class UploadPendingDocsController: UIViewController, StyledActionBar {
    private let viewModel = UploadAttachViewModel()
    @IBOutlet private var bankField: FloatingTextField!
    @IBOutlet private var accountNameField: FloatingTextField!
    @IBOutlet private var ammountField: FloatingTextField!
    @IBOutlet private var transactionDateField: FloatingTextField!
    internal let disposeBag = DisposeBag()
    var request: CompletedVisa?
    @IBOutlet private var submitBtn: UIButton!
    
    // MARK: - Pan Modal Presentable
    
    var panScrollable: UIScrollView? {
        return nil
    }
    
    var shortFormHeight: PanModalHeight {
        return .contentHeight(240)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupActionBar(.withTitle(Str.uploadPendingDocsTitle))
        configureBinding()
    }
    
    private func configureBinding() {
        accountNameField.rx.text.bind(to: viewModel.nameValue).disposed(by: disposeBag)
        ammountField.rx.text.bind(to: viewModel.amountValue).disposed(by: disposeBag)
        // date
        transactionDateField.neverShowKeypad()
        viewModel.selectedDate.map { $0?.displayFormat }.bind(to: transactionDateField.rx.text).disposed(by: disposeBag)
        transactionDateField.rx.tapGesture().when(.recognized)
            .subscribe(onNext: { _ in
                self.viewModel.showDatePickerDialog()
            }).disposed(by: disposeBag)
        // banks
        viewModel.selectedBank.map { $0?.paymentName }.filterNil()
            .bind(to: bankField.rx.text).disposed(by: disposeBag)
        bankField.neverShowKeypad()
        bankField.rx.tapGesture().when(.recognized)
            .subscribe(onNext: { _ in
                self.viewModel.showBanksListDialog()
            }).disposed(by: disposeBag)
        
        // button enables
        viewModel.validInputs
            .map { $0 ? UIColor.appPumpkinOrange : UIColor.disabledBtnBg }.bind(to: submitBtn.rx.backgroundColor).disposed(by: disposeBag)
        viewModel.validInputs
            .bind(to: submitBtn.rx.isEnabled).disposed(by: disposeBag)
        // set action
        Observable.combineLatest(
            submitBtn.rx.tapGesture().when(.recognized),
            viewModel.nameValue,
            viewModel.amountValue,
            viewModel.selectedDate,
            viewModel.selectedBank)
            .subscribe(onNext: { [unowned self] (_, name,amount,date,bank) in
                self.viewModel.submit(prm: self.request!,
                                      name: name!,
                                      amount: amount!,
                                      date: date!.apiFormat,
                                      bank: bank!.id)
            }).disposed(by: disposeBag)
        viewModel.operationCompleted.subscribe(onNext: {[unowned self] value in
            self.navigationController?.popViewController()
        }).disposed(by: disposeBag)
    }
}
