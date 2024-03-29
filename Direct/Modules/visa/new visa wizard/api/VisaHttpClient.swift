//
//  VisaHttpClient.swift
//  Direct
//
//  Created by abuzeid on 6/2/19.
//  Copyright © 2019 abuzeid. All rights reserved.
//

import Foundation
import Moya
import RxSwift

// MARK: visa methods

extension ApiClientFacade {
    func sendVisaRequest(params: VisaRequestParams) -> Observable<VisaRequestResponse> {
        return Observable<VisaRequestResponse>.create { (observer) -> Disposable in
            self.visaProvider.rx.request(VisaAPIs.visaRequest(prm: params))
                .subscribeOn(ConcurrentDispatchQueueScheduler(qos: .background))
                .observeOn( ConcurrentDispatchQueueScheduler(qos: .background))
                .subscribe { [weak self] event in
                self?.parser.emitDataModelfromResponse(event: event, observer: observer)
            }.disposed(by: self.disposeBag)
            return Disposables.create()
        }
    }

    func getVisaPrice(prm: VisaPriceParams) -> Observable<VisaPriceResponse> {
        return Observable<VisaPriceResponse>.create { (observer) -> Disposable in
            self.visaProvider.rx.request(VisaAPIs.getVisaPrice(prm: prm))
                .subscribeOn(ConcurrentDispatchQueueScheduler(qos: .background))
                .observeOn( ConcurrentDispatchQueueScheduler(qos: .background))
                .subscribe { [weak self] event in
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

    func getVisaRelations() -> Observable<VisaRelationsJSONResponse> {
        return Observable<VisaRelationsJSONResponse>.create { (observer) -> Disposable in
            self.visaProvider.rx.request(VisaAPIs.getVisaReqRelation).subscribe { [weak self] event in
                self?.parser.emitDataModelfromResponse(event: event, observer: observer)
                }.disposed(by: self.disposeBag)
            return Disposables.create()
        }
    }
    
    func getUSLivingVisaRelatives() -> Observable<VisaUSLivingRelativesJSONResponse> {
        return Observable<VisaUSLivingRelativesJSONResponse>.create { (observer) -> Disposable in
            self.visaProvider.rx.request(VisaAPIs.getVisaReqRelation).subscribe { [weak self] event in
                self?.parser.emitDataModelfromResponse(event: event, observer: observer)
                }.disposed(by: self.disposeBag)
            return Disposables.create()
        }
    }
    
    func getStayPeriod() -> Observable<VisaStayPeriodJSONResponse> {
        return Observable<VisaStayPeriodJSONResponse>.create { (observer) -> Disposable in
            self.visaProvider.rx.request(VisaAPIs.getPeriodOfPrevStay).subscribe { [weak self] event in
                self?.parser.emitDataModelfromResponse(event: event, observer: observer)
                }.disposed(by: self.disposeBag)
            return Disposables.create()
        }
    }
    func getDataOfJsonModel<T:Codable>() -> Observable<T> {
        return Observable<T>.create { (observer) -> Disposable in
            self.visaProvider.rx.request(VisaAPIs.getVisaReqRelation)
                .subscribeOn(ConcurrentDispatchQueueScheduler(qos: .background))
                .observeOn( ConcurrentDispatchQueueScheduler(qos: .background))
                .subscribe { [weak self] event in
                self?.parser.emitDataModelfromResponse(event: event, observer: observer)
                }.disposed(by: self.disposeBag)
            return Disposables.create()
        }
    }
  

    func applyToVisa(path:String,params: VisaRequirementsParams) -> Observable<USVvisaRequestJSONResponse> {
        return Observable<USVvisaRequestJSONResponse>.create { (observer) -> Disposable in
            self.visaProvider.rx.request(VisaAPIs.applyToVisa(path: path, params))
                .subscribeOn(ConcurrentDispatchQueueScheduler(qos: .background))
                .observeOn( ConcurrentDispatchQueueScheduler(qos: .background)).subscribe { [weak self] event in
                self?.parser.emitDataModelfromResponse(event: event, observer: observer)
            }.disposed(by: self.disposeBag)
            return Disposables.create()
        }
    }

    func getPreviousVisaType() -> Observable<PreviousVisaTypeJSONResponse> {
        return Observable<PreviousVisaTypeJSONResponse>.create { (observer) -> Disposable in
            self.visaProvider.rx.request(VisaAPIs.getPreviousVisaType)
                .subscribeOn(ConcurrentDispatchQueueScheduler(qos: .background))
                .observeOn( ConcurrentDispatchQueueScheduler(qos: .background))
                .subscribe { [weak self] event in
                self?.parser.emitDataModelfromResponse(event: event, observer: observer)
            }.disposed(by: self.disposeBag)
            return Disposables.create()
        }
    }
}
