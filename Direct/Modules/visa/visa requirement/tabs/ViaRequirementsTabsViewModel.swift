//
//  ViaRequirementsTabsViewModel.swift
//  Direct
//
//  Created by abuzeid on 7/6/19.
//  Copyright © 2019 abuzeid. All rights reserved.
//

import UIKit


import Foundation
import RxSwift

class ViaRequirementsTabsViewModel {
    var trackNo: String
    init() {
        self.trackNo = "trackNo"
    }
    
    private let disposeBag = DisposeBag()
    //    var showProgress = PublishSubject<Bool>()
    private let network = ApiClientFacade()
    var countriesList: Observable<[NewVisaServices]> {
        return Observable<[NewVisaServices]>.create { observer in
            self.network.getCountries().subscribe(onNext: { [unowned self] value in
                observer.onNext(value.newVisaServices ?? [])
            }).disposed(by: self.disposeBag)
            return Disposables.create()
        }
    }
//    func getCountries(){
//        network.getCountries().subscribe(onNext: {[unowned self] value in
//            value.
//        }).disposed(by: disposeBag)
//    }
}

