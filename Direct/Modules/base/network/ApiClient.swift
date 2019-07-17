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
    lazy var visaProvider = MoyaProvider<VisaAPIs>(plugins: [self.moyaLogger])
    lazy var sponsersProvider = MoyaProvider<SponsersAPIs>(plugins: [])
}

// MARK: Common Apis

extension ApiClientFacade {
    //    }

    func getCountries() -> Observable<NewVisaCountriesResponse> {
        return Observable<NewVisaCountriesResponse>.create { (observer) -> Disposable in
            self.commonProvider.rx.request(.getAllCountries)
                .subscribeOn(ConcurrentDispatchQueueScheduler(qos: .background))
                .observeOn( ConcurrentDispatchQueueScheduler(qos: .background))                .observeOn(MainScheduler.instance).subscribe { [weak self] event in
                self?.parser.emitDataModelfromResponse(event: event, observer: observer)
            }.disposed(by: self.disposeBag)
            return Disposables.create()
        }
        .share(replay: 0, scope: .whileConnected)
    }

    func getAboutUs() -> Observable<AboutUsResponse> {
        return Observable<AboutUsResponse>.create { (observer) -> Disposable in
                self.commonProvider.rx.request(.getAboutUs)
                    .subscribeOn(ConcurrentDispatchQueueScheduler(qos: .background))
                    .observeOn( ConcurrentDispatchQueueScheduler(qos: .background))                    .subscribe { [weak self] event in
                    self?.parser.emitDataModelfromResponse(event: event, observer: observer)
                }.disposed(by: self.disposeBag)
                return Disposables.create()
            }
        .share(replay: 0, scope: .whileConnected)
    }

    func getFaqs() -> Observable<FaqsResponse> {
        return Observable<FaqsResponse>.create { (observer) -> Disposable in
            self.commonProvider.rx.request(.getFaqs)
                .subscribeOn(ConcurrentDispatchQueueScheduler(qos: .background))
                .observeOn( ConcurrentDispatchQueueScheduler(qos: .background))                .subscribe { [weak self] event in
                self?.parser.emitDataModelfromResponse(event: event, observer: observer)
            }.disposed(by: self.disposeBag)
            return Disposables.create()
        }
        .share(replay: 0, scope: .whileConnected)
    }

    func submitContactUs(prm: ContactUsFormParams) -> Observable<ContactUsFormResponse> {
        return Observable<ContactUsFormResponse>.create { (observer) -> Disposable in
            self.commonProvider.rx.request(.submitContactUsForm(prm))
                .subscribeOn(ConcurrentDispatchQueueScheduler(qos: .background))
                .subscribe { [weak self] event in
                self?.parser.emitDataModelfromResponse(event: event, observer: observer)
            }.disposed(by: self.disposeBag)
            return Disposables.create()
        }
        .share(replay: 0, scope: .whileConnected)
    }

    func getContactUs() -> Observable<ContactUsPageDataResponse> {
        return Observable<ContactUsPageDataResponse>.create { (observer) -> Disposable in
            self.commonProvider.rx.request(.contactUsPageData)
                .subscribeOn(ConcurrentDispatchQueueScheduler(qos: .background))
                .observeOn( ConcurrentDispatchQueueScheduler(qos: .background))                .subscribe { [weak self] event in
                self?.parser.emitDataModelfromResponse(event: event, observer: observer)
            }.disposed(by: self.disposeBag)
            return Disposables.create()
        }
        .share(replay: 0, scope: .whileConnected)
    }

    func getBranches() -> Observable<BranchesResponse> {
        return Observable<BranchesResponse>.create { (observer) -> Disposable in
            self.commonProvider.rx.request(.getBranches)
                .subscribeOn(ConcurrentDispatchQueueScheduler(qos: .background))
                .observeOn( ConcurrentDispatchQueueScheduler(qos: .background))                .subscribe { [weak self] event in
                self?.parser.emitDataModelfromResponse(event: event, observer: observer)
            }.disposed(by: self.disposeBag)
            return Disposables.create()
        }
        .share(replay: 0, scope: .whileConnected)
    }

    func getBiometricChoices() -> Observable<BioChoicesResponse> {
        return Observable<BioChoicesResponse>.create { (observer) -> Disposable in
            self.commonProvider.rx.request(.biometricChoices)
                .subscribeOn(ConcurrentDispatchQueueScheduler(qos: .background))
                .observeOn( ConcurrentDispatchQueueScheduler(qos: .background))
                .subscribe { [weak self] event in
                self?.parser.emitDataModelfromResponse(event: event, observer: observer)
            }.disposed(by: self.disposeBag)
            return Disposables.create()
        }.share()
    }

    func getCities(country: String) -> Observable<CountryCitiesResponse> {
        return Observable<CountryCitiesResponse>.create { (observer) -> Disposable in
            self.commonProvider.rx.request(CommonAPIs.getCities(cid: country))
                .subscribeOn(ConcurrentDispatchQueueScheduler(qos: .background))
                .observeOn( ConcurrentDispatchQueueScheduler(qos: .background))
                .subscribe { [weak self] event in
                self?.parser.emitDataModelfromResponse(event: event, observer: observer)
            }.disposed(by: self.disposeBag)
            return Disposables.create()
        }.share()
    }

    func getRelationList() -> Observable<RelativesResponse> {
        return Observable<RelativesResponse>.create { (observer) -> Disposable in
            self.commonProvider.rx.request(.relationsList)
                .subscribeOn(ConcurrentDispatchQueueScheduler(qos: .background))
                .observeOn( ConcurrentDispatchQueueScheduler(qos: .background))
                .subscribe { [weak self] event in
                self?.parser.emitDataModelfromResponse(event: event, observer: observer)
            }.disposed(by: self.disposeBag)
            return Disposables.create()
        }.share()
    }
}
