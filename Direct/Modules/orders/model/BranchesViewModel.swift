//
//  BranchesViewModel.swift
//  Direct
//
//  Created by abuzeid on 7/13/19.
//  Copyright © 2019 abuzeid. All rights reserved.
//

import Foundation

import RxDataSources
import RxSwift

class BranchesViewModel: BaseViewModel {
    private let disposeBag = DisposeBag()
    var showProgress = PublishSubject<Bool>()
    private let network = ApiClientFacade()
    
    var branches: Observable<BranchesResponse?> {
        return Observable<BranchesResponse?>.create { observer in
            self.showProgress.onNext(true)
            self.network.getBranches().subscribe(onNext: { [unowned self] value in
                observer.onNext(value)
                self.showProgress.onNext(false)
            }).disposed(by: self.disposeBag)
            return Disposables.create()
        }
    }
}
