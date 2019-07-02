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
    var passangers = PublishSubject<[ConfirmPassangerItem]>()
    var validSponsors = BehaviorSubject<Bool>(value: false)
    var enablePayment = BehaviorSubject<Bool>(value: false)
    var successIndices = PublishSubject<[Int]>()
    private let disposeBag = DisposeBag()
    init() {
        configure()
        bindTableWithSuccessInputs()
    }
 
    func configure() {
        Observable.combineLatest(passangers, validSponsors, resultSelector: { psngrs, validSponsor in
            let allItemFilled = (psngrs.indices(where: { $0.isFormFilled }) ?? []).count == psngrs.count
            self.enablePayment.onNext(allItemFilled && validSponsor)

        }).observeOn(MainScheduler.instance)
            .subscribe()
            .disposed(by: disposeBag)
    }

    func loadPassangers(with info: VisaRequestParams) {
        var passangers: [ConfirmPassangerItem] = []
        for index in 0 ..< (info.no_of_adult ?? "0").intValue {
            passangers.append(ConfirmPassangerItem(text: Str.adult, isFormFilled: false, index: index + 1, userType: .adult))
        }
        for index in 0 ..< (info.no_of_child ?? "0").intValue {
            passangers.append(ConfirmPassangerItem(text: Str.child, isFormFilled: false, index: index + 1, userType: .child))
        }
        self.passangers.onNext(passangers)
    }

    func bindTableWithSuccessInputs() {
//        let filled = passangersInfoScreen.successInputIndexes
        Observable.combineLatest(passangers, successIndices, resultSelector: { psngrs, succ in
            var updatedPasses = psngrs
            for index in succ {
                updatedPasses[index].isFormFilled = true
            }
            print(Thread.current)
            self.passangers.onNext(updatedPasses)

        }).observeOn(MainScheduler.instance)
            .subscribe()
            .disposed(by: disposeBag)

    }
}
