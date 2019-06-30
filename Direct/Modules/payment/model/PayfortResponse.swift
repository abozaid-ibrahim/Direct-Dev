//
//  PayfortResponse.swift
//  Direct
//
//  Created by abuzeid on 6/29/19.
//  Copyright © 2019 abuzeid. All rights reserved.
//

import Foundation

struct PayfortResponse: Codable {
    let status, responseMessage, serviceCommand, deviceID: String?
    let sdkToken, signature, responseCode, merchantIdentifier: String?
    let language, accessCode: String?
    
    enum CodingKeys: String, CodingKey {
        case status
        case responseMessage = "response_message"
        case serviceCommand = "service_command"
        case deviceID = "device_id"
        case sdkToken = "sdk_token"
        case signature
        case responseCode = "response_code"
        case merchantIdentifier = "merchant_identifier"
        case language
        case accessCode = "access_code"
    }
    
    init(status: String?, responseMessage: String?, serviceCommand: String?, deviceID: String?, sdkToken: String?, signature: String?, responseCode: String?, merchantIdentifier: String?, language: String?, accessCode: String?) {
        self.status = status
        self.responseMessage = responseMessage
        self.serviceCommand = serviceCommand
        self.deviceID = deviceID
        self.sdkToken = sdkToken
        self.signature = signature
        self.responseCode = responseCode
        self.merchantIdentifier = merchantIdentifier
        self.language = language
        self.accessCode = accessCode
    }
    
    
}
