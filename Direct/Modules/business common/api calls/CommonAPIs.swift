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
    case getAllCountries,
        getCities(cid: String)
    case biometricChoices
    case relationsList
    case userProfile(String)
    case userRepositories(String)
    case getAboutUs
    case getBranches,
        getFaqs,
        submitContactUsForm(ContactUsFormParams),
    contactUsPageData
}

// share base url cross all of the APIs∑
extension TargetType {
    public var baseURL: URL { return URL(string: "https://dev.visa.directksa.com/backend/api/")! }
    var appLang: String {
        return AppLanguage.langCode
    }

    var tokenKeyValue: String {
        return User.authKey
    }

    var prmEncoder: JSONEncoder {
        let encoder = JSONEncoder()
        encoder.keyEncodingStrategy = .useDefaultKeys
        return encoder
    }
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
        case .getCities:
            return "get-city"
        case .getAboutUs:
            return "get-about-page"
        case .getBranches:
            return "get-branch"
        case .getFaqs:
            return "get-faq-page"
        case .submitContactUsForm:
            return "contact-us"
        case .contactUsPageData:
            return "contact-page-data"
        }
    }

    public var method: Moya.Method {
        switch self {
        case .getAllCountries, .biometricChoices, .relationsList, .getCities, .getAboutUs, .getBranches, .submitContactUsForm,.contactUsPageData:
            return .post

        default:
            return .get
        }
    }

    public var task: Task {
        switch self {
        case let .getCities(cid):
            return .requestParameters(parameters: ["cid": cid, "key": tokenKeyValue, "lang": appLang], encoding: URLEncoding.default)
        case let .submitContactUsForm(prm):
            return .requestJSONEncodable(prm)

        default:
            return .requestParameters(parameters: ["key": tokenKeyValue, "lang": appLang], encoding: URLEncoding.default)
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
        var header: [String: String] = [:]
        header["Content-type"] = "application/x-www-form-urlencoded; charset=utf-8"
//        header["Content-type"] = "application/json"
//        header["Accept"] = "application/json"
        return header
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
