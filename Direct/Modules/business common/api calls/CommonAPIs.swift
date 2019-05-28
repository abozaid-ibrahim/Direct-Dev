//
//  CommonAPIs.swift
//  Direct
//
//  Created by abuzeid on 5/15/19.
//  Copyright © 2019 abuzeid. All rights reserved.
//

import Foundation
import Moya

public enum CommonAPIs {
    case getAllCountries
    case biometricChoices
    case relationsList

    case userProfile(String)
    case userRepositories(String)
}
//share base url cross all of the APIs
extension TargetType{
    public var baseURL: URL { return URL(string: "https://dev.visa.directksa.com/backend/api/")! }

}
extension CommonAPIs: TargetType {
    public var path: String {
        switch self {
        case .biometricChoices:
            return "get-bio-option"
        case let .userProfile(name):
            return "/users/\(name.urlEscaped)"
        case let .userRepositories(name):
            return "/users/\(name.urlEscaped)/repos"
        case .getAllCountries:
            return "get-new-services-by-country"
        case .relationsList:
            return "get-sponsor-bank-statement-relation"
        }
    }

    public var method: Moya.Method {
        switch self {
        case .getAllCountries, .biometricChoices, .relationsList:
            return .post

        default:
            return .get
        }
    }

    public var task: Task {
        switch self {
        case .userRepositories:
            return .requestParameters(parameters: ["sort": "pushed"], encoding: URLEncoding.default)
        default:
            return .requestParameters(parameters: ["key": "bf930e30-8c28-42d6-bf8e-f4cbd0b83774", "lang": "en"], encoding: URLEncoding.default)
        }
    }

    public var validationType: ValidationType {
        switch self {
        case .getAllCountries:
            return .successCodes
        default:
            return .none
        }
    }

    public var sampleData: Data {
        switch self {
        case .getAllCountries:
            return "".data(using: String.Encoding.utf8)!
        default:
            return "{no data handled, mock it if you need}".data(using: String.Encoding.utf8)!
        }
    }

    public var headers: [String: String]? {
        return nil
    }
}

public func url(_ route: TargetType) -> String {
    return route.baseURL.appendingPathComponent(route.path).absoluteString
}

// MARK: - Response Handlers

extension Moya.Response {
    func mapNSArray() throws -> NSArray {
        let any = try mapJSON()
        guard let array = any as? NSArray else {
            throw MoyaError.jsonMapping(self)
        }
        return array
    }
}

// MARK: - Provider support

private extension String {
    var urlEscaped: String {
        return addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
    }
}

struct APIDateFromatter {
    func JSONResponseDataFormatter(_ data: Data) -> Data {
        do {
            let dataAsJSON = try JSONSerialization.jsonObject(with: data)
            let prettyData = try JSONSerialization.data(withJSONObject: dataAsJSON, options: .prettyPrinted)
            return prettyData
        } catch {
            return data // fallback to original data if it can't be serialized.
        }
    }
}
