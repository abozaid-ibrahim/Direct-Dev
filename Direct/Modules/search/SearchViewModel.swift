//
//  SearchViewModel.swift
//  Direct
//
//  Created by abuzeid on 5/27/19.
//  Copyright © 2019 abuzeid. All rights reserved.
//

import Foundation
import RxOptional
import RxSwift

class SearchCountriesViewModel {
    var disposeBag = DisposeBag()
    var countriesList = PublishSubject<[NewVisaService]>()
    private var network: ApiClientFacade?
    init(network: ApiClientFacade? = ApiClientFacade()) {
        self.network = network
    }
    
    func viewDidLoad() {
        network?.getCountries().subscribe(onNext: { [weak self] countries in
            self?.countriesList.onNext(countries.newVisaServices)
            }, onError: { [weak self] err in
                self?.countriesList.onError(err)
            }, onCompleted: nil, onDisposed: nil).disposed(by: disposeBag)
    }
}
