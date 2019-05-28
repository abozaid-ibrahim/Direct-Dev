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
    private let parser = JsonParser()
    private let disposeBag = DisposeBag()
    private let commonProvider = MoyaProvider<CommonAPIs>(plugins: [NetworkLoggerPlugin(verbose: true, responseDataFormatter: APIDateFromatter().JSONResponseDataFormatter)])

    private let visaProvider = MoyaProvider<VisaAPIs>(plugins: [NetworkLoggerPlugin(verbose: true, responseDataFormatter: APIDateFromatter().JSONResponseDataFormatter)])

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

    func getCountries() -> Observable<[NewVisaService]> {
        let observable = Observable<[NewVisaService]>.create { (observer) -> Disposable in

            self.commonProvider.rx.request(.getAllCountries).subscribe { event in
                switch event {
                case let .success(response):
                    if let countries = try? JSONDecoder().decode(NewVisaCountriesResponse.self, from: response.data) {
                        observer.onNext(countries.newVisaServices)
                    } else {
                        observer.onError(NetworkFailure.failedToParseData)
                    }
                case let .error(error):
                    observer.onError(error)
                }
            }.disposed(by: self.disposeBag)
            return Disposables.create()
        }
        return observable
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
}

func log(_ value: Any) {
    #if DEBUG
        print("logger:\(value)")
    #endif
}
