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

    let commonProvider = MoyaProvider<CommonAPIs>(plugins: [NetworkLoggerPlugin(verbose: true, responseDataFormatter: APIDateFromatter().JSONResponseDataFormatter)])
    let paymentProvider = MoyaProvider<PaymentAPIs>(plugins: [NetworkLoggerPlugin(verbose: true, responseDataFormatter: APIDateFromatter().JSONResponseDataFormatter)])

    let visaProvider = MoyaProvider<VisaAPIs>(plugins: [NetworkLoggerPlugin(verbose: true, responseDataFormatter: APIDateFromatter().JSONResponseDataFormatter)])

    //    func downloadRepositories(_ username: String) {
    //        provider.request(.zen) { result in
    //            do {
    //                let response = try result.get()
    //                let value = try response.mapNSArray()
    //
    //            } catch {
    //                let printableError = error as CustomStringConvertible
    //
    //            }
    //        }
}

func log(_ value: Any) {
    #if DEBUG
        print("logger:\(value)")
    #endif
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
        }
    }

    func getCities(country: String) -> Observable<CountryCitiesResponse> {
        return Observable<CountryCitiesResponse>.create { (observer) -> Disposable in
            self.commonProvider.rx.request(CommonAPIs.getCities(cid: country)).subscribe { [weak self] event in
                self?.parser.emitDataModelfromResponse(event: event, observer: observer)
            }.disposed(by: self.disposeBag)
            return Disposables.create()
        }
    }

    func getRelationList() -> Observable<RelativesResponse> {
        return Observable<RelativesResponse>.create { (observer) -> Disposable in
            self.commonProvider.rx.request(.relationsList).subscribe { [weak self] event in
                self?.parser.emitDataModelfromResponse(event: event, observer: observer)
            }.disposed(by: self.disposeBag)
            return Disposables.create()
        }
    }
}
