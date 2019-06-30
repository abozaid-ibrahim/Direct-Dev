//
//  PayfortCredentials.swift
//  Direct
//
//  Created by abuzeid on 6/29/19.
//  Copyright © 2019 abuzeid. All rights reserved.
//

import Alamofire
import Foundation
import Moya

enum PayFortCredintials {
    case development(udid: String)
    case production(udid: String)
    
    var merchantId: String {
        switch self {
        case .development:
            return "krkOMyEe"
        default:
            return "krkOMyEe"
        }
    }
    
    var accessCode: String {
        switch self {
        case .development:
            return "g7I1s8T76rFltT3jVv6W"
        default:
            return "g7I1s8T76rFltT3jVv6W"
        }
    }
    
    var shaRequest: String {
        switch self {
        case .development:
            return "dssaerfsfe"
        default:
            return "dssaerfsfe"
        }
    }
    
    var currency: String { return "SAR" }
    
    func signature(uid: String) -> String {
        return Encryption.sha256Hex(string: self.preSignature(uid)) ?? "Can't happen."
    }
    
    private func preSignature(_ uid: String) -> String {
        return self.shaRequest + "access_code=\(self.accessCode)" + "device_id=\(uid)" + "language=enmerchant_identifier=\(self.merchantId)" + "service_command=SDK_TOKEN\(self.shaRequest)"
    }
    
    func parameters(with udid: String) -> [String: Any] {
        return ["access_code": accessCode,
                "device_id": udid,
                "language": "en",
                "merchant_identifier": merchantId,
                "service_command": "SDK_TOKEN",
                "signature": signature(uid: udid)]
    }
}

enum ServerPaths: String {
    case payfortSDKToken = "FortAPI/paymentApi"
}

extension PayFortCredintials: TargetType {
    var sampleData: Data {
        return "{}".data(using: .utf8)!
    }
    
    public var task: Task {
        switch self {
        case .development:
            return .requestParameters(parameters: self.parameters!, encoding: URLEncoding.default)
        default:
            return .requestParameters(parameters: self.parameters!, encoding: URLEncoding.default)
        }
    }
    
    var headers: [String: String]? {
        var header = HTTPHeaders()
        header["Content-type"] = "application/x-www-form-urlencoded; charset=utf-8"
        header["Content-type"] = "application/json"
        header["Accept"] = "application/json"
        return header
    }
    
    var method: HTTPMethod {
        return .post
    }
    
    var mainURL: URL {
        switch self {
        case .development:
            return URL(string: "https://sbpaymentservices.payfort.com")!
        default:
            return URL(string: "https://paymentservices.payfort.com")!
        }
    }
    
    var path: String {
        return ServerPaths.payfortSDKToken.rawValue
    }
    
    var parameters: Parameters? {
        switch self {
        case .development(let udid):
            return parameters(with: udid)
        case .production(let udid):
            return parameters(with: udid)
        }
    }
}
