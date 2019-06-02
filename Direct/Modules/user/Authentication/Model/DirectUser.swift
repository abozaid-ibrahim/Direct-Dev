//
//  DirectUser.swift
//  Direct
//
//  Created by Abdoelrhman Eaita on 6/2/19.
//  Copyright © 2019 abuzeid. All rights reserved.
//

import Foundation


// MARK: - Welcome
struct DirectUserResponse: Codable {
    let userLogin: [DirectUser]?
    
    enum CodingKeys: String, CodingKey {
        case userLogin = "User Login"
    }
}

// MARK: - UserLogin
struct DirectUser: Codable {
    let firstName, lastName, userPhone, usereMail: String?
    let userDeviceID, userDeviceType, userID, username: String?
    let userLang, emailVerification: String?
    let phoneVerification: Int?
    let status, success: String?
    
    enum CodingKeys: String, CodingKey {
        case firstName, lastName, userPhone, usereMail
        case userDeviceID = "userDeviceId"
        case userDeviceType
        case userID = "userId"
        case username, userLang
        case emailVerification = "email_verification"
        case phoneVerification = "phone_verification"
        case status, success
    }
}
