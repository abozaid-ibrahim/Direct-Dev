//
//  OrdersHistoryViewModel.swift
//  Direct
//
//  Created by abuzeid on 7/6/19.
//  Copyright © 2019 abuzeid. All rights reserved.
//

import Foundation
import RxDataSources
import RxSwift

class OrdersHistoryViewModel: BaseViewModel {
    var trackNo: String
    init(trackNo: String) {
        self.trackNo = trackNo
    }

    private let disposeBag = DisposeBag()
    var showProgress = PublishSubject<Bool>()
    private let network = ApiClientFacade()

    var completedVisa: Observable<[CompletedVisa]> {
        return Observable<[CompletedVisa]>.create { observer in
            self.showProgress.onNext(true)
            self.network.getCompletedOrders(trackNo: self.trackNo)
                .subscribe(onNext: { [unowned self] value in
                    observer.onNext(value.completedVisa ?? [])
                    self.showProgress.onNext(false)
                }).disposed(by: self.disposeBag)
            return Disposables.create()
        }
    }
}
