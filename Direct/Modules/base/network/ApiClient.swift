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
    //    }

    func getCountries() -> Observable<NewVisaCountriesResponse> {
        return Observable<NewVisaCountriesResponse>.create { (observer) -> Disposable in
            self.commonProvider.rx.request(.getAllCountries).subscribe { [weak self] event in
                self?.parser.emitDataModelfromResponse(event: event, observer: observer)
            }.disposed(by: self.disposeBag)
            return Disposables.create()
        }
    }

    func getBiometricChoices() -> Observable<BioChoicesResponse> {
        return Observable<BioChoicesResponse>.create { (observer) -> Disposable in
            self.commonProvider.rx.request(.biometricChoices).subscribe { [weak self] event in
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

    func sendVisaRequest(params: VisaRequestParams) -> Observable<VisaRequestResponse> {
        return Observable<VisaRequestResponse>.create { (observer) -> Disposable in
            self.visaProvider.rx.request(VisaAPIs.visaRequest(prm: params)).subscribe { [weak self] event in
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

    func getVisaPrice(prm: VisaPriceParams) -> Observable<VisaPriceResponse> {
        return Observable<VisaPriceResponse>.create { (observer) -> Disposable in
            self.visaProvider.rx.request(VisaAPIs.getVisaPrice(prm: prm)).subscribe { [weak self] event in
                self?.parser.emitDataModelfromResponse(event: event, observer: observer)
            }.disposed(by: self.disposeBag)
            return Disposables.create()
        }
    }

    func getVisaRequirements(country: String) -> Observable<VisaRequirementForCountryResponse> {
        return Observable<VisaRequirementForCountryResponse>.create { (observer) -> Disposable in
            self.visaProvider.rx.request(VisaAPIs.visaRequirementForCountry(cid: country)).subscribe { [weak self] event in
                self?.parser.emitDataModelfromResponse(event: event, observer: observer)
            }.disposed(by: self.disposeBag)
            return Disposables.create()
        }
    }
}

func log(_ value: Any) {
    #if DEBUG
        print("logger:\(value)")
    #endif
}
