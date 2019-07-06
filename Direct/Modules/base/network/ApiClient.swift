//
//  ApiClient.swift
//  Direct
//
//  Created by abuzeid on 5/15/19.
//  Copyright © 2019 abuzeid. All rights reserved.
//

import Foundation
import Moya
import RxOptional
import RxSwift

// CALL Netowkr, get response , parse it to model , pass it ot view model

class ApiClientFacade {
    let parser = JsonParser()
    let disposeBag = DisposeBag()
    let moyaLogger = NetworkLoggerPlugin(verbose: true, responseDataFormatter: APIDateFromatter().JSONResponseDataFormatter)

    let commonProvider = MoyaProvider<CommonAPIs>(plugins: [])
    let paymentProvider = MoyaProvider<PaymentAPIs>(plugins: [])
    lazy var ordersProvider = MoyaProvider<OrdersAPIs>(plugins: [self.moyaLogger])
    lazy var visaProvider = MoyaProvider<VisaAPIs>(plugins: [])
    lazy var sponsersProvider = MoyaProvider<SponsersAPIs>(plugins: [])
}

// MARK: Common Apis

extension ApiClientFacade {
    //    }

    func getCountries() -> Observable<NewVisaCountriesResponse> {
        return Observable<NewVisaCountriesResponse>.create { (observer) -> Disposable in
            self.commonProvider.rx.request(.getAllCountries).observeOn(MainScheduler.instance).subscribe { [weak self] event in
                self?.parser.emitDataModelfromResponse(event: event, observer: observer)
            }.disposed(by: self.disposeBag)
            return Disposables.create()
        }
        .share(replay: 0, scope: .whileConnected)
    }

    func getBiometricChoices() -> Observable<BioChoicesResponse> {
        return Observable<BioChoicesResponse>.create { (observer) -> Disposable in
            self.commonProvider.rx.request(.biometricChoices).subscribe { [weak self] event in
                self?.parser.emitDataModelfromResponse(event: event, observer: observer)
            }.disposed(by: self.disposeBag)
            return Disposables.create()
        }.share()
    }

    func getCities(country: String) -> Observable<CountryCitiesResponse> {
        return Observable<CountryCitiesResponse>.create { (observer) -> Disposable in
            self.commonProvider.rx.request(CommonAPIs.getCities(cid: country)).subscribe { [weak self] event in
                self?.parser.emitDataModelfromResponse(event: event, observer: observer)
            }.disposed(by: self.disposeBag)
            return Disposables.create()
        }.share()
    }

    func getRelationList() -> Observable<RelativesResponse> {
        return Observable<RelativesResponse>.create { (observer) -> Disposable in
            self.commonProvider.rx.request(.relationsList).subscribe { [weak self] event in
                self?.parser.emitDataModelfromResponse(event: event, observer: observer)
            }.disposed(by: self.disposeBag)
            return Disposables.create()
        }.share()
    }
}
