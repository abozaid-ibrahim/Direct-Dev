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
//MARK: visa methods
extension ApiClientFacade{
    
    func sendVisaRequest(params: VisaRequestParams) -> Observable<VisaRequestResponse> {
        return Observable<VisaRequestResponse>.create { (observer) -> Disposable in
            self.visaProvider.rx.request(VisaAPIs.visaRequest(prm: params)).subscribe { [weak self] event in
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
    
    func applyToUSVisa(params: USRequestParams) -> Observable<USVvisaRequestJSONResponse> {
        return Observable<USVvisaRequestJSONResponse>.create { (observer) -> Disposable in
            self.visaProvider.rx.request(VisaAPIs.applyToUS(params)).subscribe { [weak self] event in
                self?.parser.emitDataModelfromResponse(event: event, observer: observer)
                }.disposed(by: self.disposeBag)
            return Disposables.create()
        }
    }
    func applyToUKVisa(params: USRequestParams) -> Observable<USVvisaRequestJSONResponse> {
        return Observable<USVvisaRequestJSONResponse>.create { (observer) -> Disposable in
            self.visaProvider.rx.request(VisaAPIs.applyToUK(params)).subscribe { [weak self] event in
                self?.parser.emitDataModelfromResponse(event: event, observer: observer)
                }.disposed(by: self.disposeBag)
            return Disposables.create()
        }
    }
    
    func getPreviousVisaType() -> Observable<PreviousVisaTypeJSONResponse> {
        return Observable<PreviousVisaTypeJSONResponse>.create { (observer) -> Disposable in
            self.visaProvider.rx.request(VisaAPIs.getPreviousVisaType).subscribe { [weak self] event in
                self?.parser.emitDataModelfromResponse(event: event, observer: observer)
                }.disposed(by: self.disposeBag)
            return Disposables.create()
        }
    }
}
