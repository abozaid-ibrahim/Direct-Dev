//
//  PassangerFormViewModel.swift
//  Direct
//
//  Created by abuzeid on 6/13/19.
//  Copyright © 2019 abuzeid. All rights reserved.
//

import Foundation
import RxSwift
class VisaQuestionsViewModel {
    private let network = ApiClientFacade()
    var selectedRelation = PublishSubject<String?>()
    var selectedVisaType = PublishSubject<PreviousVisaType>()
    var selectedDate = PublishSubject<Date?>()

    var relativesList: [Relative] = []

    private let disposeBag = DisposeBag()
    func getRelatives() {
        let rel = network.getRelationList().retry(2)
        rel.subscribe(onNext: { [weak self] bios in
            self?.relativesList.append(contentsOf: bios.relatives )
        }, onError: nil, onCompleted: nil, onDisposed: nil).disposed(by: disposeBag)
    }

    func showDatePickerDialog() {
        let dest = Destination.datePicker(title: nil)
        let vc = dest.controller() as! DatePickerController
        vc.selectedDate.subscribe(onNext: { [unowned self] value in
            self.selectedDate.onNext(value)
        }).disposed(by: disposeBag)

        try! AppNavigator().presentModally(vc)
    }
    private var visaTypesBuffer :[PreviousVisaType]  = []
    func showVisaTypes() {
        let data = visaTypesBuffer
        let str = data.filter { $0.name != nil }.map { $0.name ?? "" }
        let dest = Destination.selectableSheet(data: str, titleText: Str.choose, style: .textCenter)
        let vc = dest.controller() as! SelectableTableSheet
        vc.selectedItem
            .map { value in data.filter { $0.name ?? "" == value } }
            .map{$0.first}
            .filterNil()
            .bind(to: selectedVisaType).disposed(by: disposeBag)

        try! AppNavigator().presentModally(vc)
    }
    func getPreviousVisaTypes() {
        network.getPreviousVisaType().retry(2).subscribe(onNext: { [unowned self] value in
            if let types = value.previousVisaType {
                self.visaTypesBuffer = types
            }
            }).disposed(by: disposeBag)
    }
}

struct Segment {
    static let no = 0
    static let yes  = 1
}
