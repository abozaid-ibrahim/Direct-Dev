//
//  JsonParser.swift
//  Direct
//
//  Created by abuzeid on 5/27/19.
//  Copyright © 2019 abuzeid. All rights reserved.
//

import Foundation
import RxSwift
import Alamofire
import Moya
class JsonParser{
    func emitDataModelfromResponse<T:Codable>(event:SingleEvent<Response>,observer: AnyObserver<T>){
        switch event {
        case let .success(response):
            do{
             let response = try JSONDecoder().decode(T.self, from: response.data)
                observer.onNext(response)
            }catch let error {
                print(">>> parsing error \(error)")
                observer.onError(NetworkFailure.failedToParseData)
            }
        case let .error(error):
            observer.onError(error)
        }
    }

}
