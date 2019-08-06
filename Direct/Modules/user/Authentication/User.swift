//
//  User.swift
//  Direct
//
//  Created by abuzeid on 7/5/19.
//  Copyright © 2019 abuzeid. All rights reserved.
//

import UIKit

class User {
    private static var currentUser: DirectUser?
    static var id: String {
        return currentUser?.userID ?? ""
    }

    static var authKey: String {
        return "bf930e30-8c28-42d6-bf8e-f4cbd0b83774"
    }

    static var isUserLoggedIn: Bool {
        return currentUser != nil
    }

    static var userName: String {
        return currentUser?.username ?? ""
    }

    static func logout() {
        currentUser = nil
        UserDefaults.standard.removeObject(forKey: userKey)
        UserDefaults.standard.synchronize()
    }

    static func saveUser(_ data: Data) {
        let decoder = JSONDecoder()
        let user = try? decoder.decode(DirectUserResponse.self, from: data)
        guard let duser = user?.userLogin?.first else {
            return
        }
        currentUser = duser
        UserDefaults.standard.set(object: duser, forKey: userKey)
        UserDefaults.standard.synchronize()
    }

    private static let userKey = "asdfasdfsadfasdf"
}
