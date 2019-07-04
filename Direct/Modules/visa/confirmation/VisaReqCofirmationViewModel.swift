//
//  VisaReqCofirmationViewModel.swift
//  Direct
//
//  Created by abuzeid on 7/2/19.
//  Copyright © 2019 abuzeid. All rights reserved.
//

import Foundation
import RxSwift

class VisaReqCofirmationViewModel {
    private var passangersBuffer: [ConfirmPassangerItem] = []
    // updated one
    var tablePassangers = PublishSubject<[ConfirmPassangerItem]>()
    var bioOptions = PublishSubject<[BioOption]>()
    var selectedBioOption = PublishSubject<BioOption>()
    private let network = ApiClientFacade()
    var validSponsors = BehaviorSubject<Bool>(value: false)
    var enablePayment = BehaviorSubject<Bool>(value: false)
    var successIndices = PublishSubject<[Int]>()
    private let disposeBag = DisposeBag()
    init() {
        configure()
        bindTableWithSuccessInputs()
    }
    
    func configure() {
        Observable.combineLatest(tablePassangers, validSponsors, selectedBioOption.map{_ in return true})
            .subscribe(onNext: { [unowned self] psngrs, validSponsor, _validDate in
                let allItemFilled = (psngrs.indices(where: { $0.isFormFilled }) ?? []).count == psngrs.count
                self.enablePayment.onNext(allItemFilled && validSponsor && _validDate)
            }).disposed(by: disposeBag)
        
        network.getBiometricChoices()
            .map { $0.bioOption }
            .bind(to: bioOptions)
            .disposed(by: disposeBag)
    }
    
    func loadPassangers(with info: VisaRequestParams) {
        var buffer: [ConfirmPassangerItem] = []
        for index in 0 ..< (info.no_of_adult ?? "0").intValue {
            buffer.append(ConfirmPassangerItem(text: Str.adult, isFormFilled: false, index: index + 1, userType: .adult))
        }
        for index in 0 ..< (info.no_of_child ?? "0").intValue {
            buffer.append(ConfirmPassangerItem(text: Str.child, isFormFilled: false, index: index + 1, userType: .child))
        }
        passangersBuffer = buffer
        tablePassangers.onNext(buffer)
    }
    
    func bindTableWithSuccessInputs() {
        successIndices.filterEmpty()
            .distinctUntilChanged()
            .subscribe(onNext: { [unowned self] value in
                for index in value {
                    self.passangersBuffer[index].isFormFilled = true
                }
                print(Thread.current)
                self.tablePassangers.onNext(self.passangersBuffer)
            }).disposed(by: disposeBag)
    }
    
    func showBioOptions(click: Observable<UITapGestureRecognizer>) {
        Observable.combineLatest(click, bioOptions)
            .subscribe(onNext: { [unowned self] _, data in
                
                let names = data.map { $0.name }
                let dest = Destination.selectableSheet(data: names, titleText: Str.choose, style: .textCenter)
                let selectionController = dest.controller() as! SelectableTableSheet
                selectionController.selectedItem.subscribe(onNext: { [unowned self] value in
                    
                    let itms = data.filter { $0.name == value }
                    if let visa = itms.first {
                        self.selectedBioOption.onNext(visa)
                    }
                }).disposed(by: self.disposeBag)
                
                try! AppNavigator().presentModally(selectionController)
            }).disposed(by: disposeBag)
    }
}
