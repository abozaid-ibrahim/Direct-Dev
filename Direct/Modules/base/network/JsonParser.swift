//
//  JsonParser.swift
//  Direct
//
//  Created by abuzeid on 5/27/19.
//  Copyright © 2019 abuzeid. All rights reserved.
//

import Alamofire
import Foundation
import Moya
import RxSwift
class JsonParser {
    func emitDataModelfromResponse<T: Codable>(event: SingleEvent<Response>, observer: AnyObserver<T>) {
        switch event {
        case let .success(response):
            do {
                let object = try JSONDecoder().decode(T.self, from: response.data)
                print(object)
                observer.onNext(object)
            } catch let error{
                print(">>> parsing error \(error)")
                observer.onError(NetworkFailure.failedToParseData)
            }
        case let .error(error):
            observer.onError(error)
        }
    }
}
