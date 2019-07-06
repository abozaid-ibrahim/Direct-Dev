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
//            Logger.log(">>>response \(String(describing: String(data: response.data, encoding: .utf8)) )")

            do {
                let object = try JSONDecoder().decode(T.self, from: response.data)
                observer.onNext(object)
            } catch {
                Logger.log(">>> parsing error \(error)")
                observer.onError(NetworkFailure.failedToParseData)
            }
        case let .error(error):
            Logger.log(">>> error: error \(error)")
            observer.onError(error)
        }
    }
}
class Logger{
    static func log(_ value:Any) {
        DispatchQueue.global().async {
            print(value)
        }
    }
}
