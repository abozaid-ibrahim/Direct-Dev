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

class ApiClientFacade {
    //    private let provider = MoyaProvider<CommonAPIs>()

    private let provider = MoyaProvider<CommonAPIs>(plugins: [NetworkLoggerPlugin(verbose: true, responseDataFormatter: APIDateFromatter().JSONResponseDataFormatter)])

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
    func get() {
        provider.rx.request(.zen).subscribe { event in
            switch event {
            case let .success(response):
                // do something with the data
                log("scuccess")
            case let .error(error):
                log(error)
            }
        }
    }
}

func log(_ value: Any) {
    #if DEBUG
        print("logger:\(value)")
    #endif
}
