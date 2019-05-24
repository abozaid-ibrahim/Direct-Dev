//
//  CommonAPIs.swift
//  Direct
//
//  Created by abuzeid on 5/15/19.
//  Copyright © 2019 abuzeid. All rights reserved.
//

import Foundation
import Moya

// curl --location --request POST "/" \
// --header "Content-Type: application/x-www-form-urlencoded" \
// --data "key=bf930e30-8c28-42d6-bf8e-f4cbd0b83774&lang=en"

// MARK: - Provider setup

public enum CommonAPIs {
    case getAllCountries
    case zen
    case userProfile(String)
    case userRepositories(String)
}

extension CommonAPIs: TargetType {
    public var baseURL: URL { return URL(string: "https://dev.visa.directksa.com/backend/api/")! }
    public var path: String {
        switch self {
        case .zen:
            return "/zen"
        case let .userProfile(name):
            return "/users/\(name.urlEscaped)"
        case let .userRepositories(name):
            return "/users/\(name.urlEscaped)/repos"
        case .getAllCountries:
            return "get-new-services-by-country"
        }
    }

    public var method: Moya.Method {
        return .get
    }

    public var task: Task {
        switch self {
        case .userRepositories:
            return .requestParameters(parameters: ["sort": "pushed"], encoding: URLEncoding.default)
        default:
            return .requestPlain
        }
    }

    public var validationType: ValidationType {
        switch self {
        case .zen:
            return .successCodes
        default:
            return .none
        }
    }

    public var sampleData: Data {
        switch self {
        case .zen:
            return "Half measures are as bad as nothing at all.".data(using: String.Encoding.utf8)!
        case let .userProfile(name):
            return "{\"login\": \"\(name)\", \"id\": 100}".data(using: String.Encoding.utf8)!
        case let .userRepositories(name):
            return "[{\"name\": \"\(name)\"}]".data(using: String.Encoding.utf8)!
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
