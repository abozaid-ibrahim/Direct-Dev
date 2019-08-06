//
//  User.swift
//  Direct
//
//  Created by abuzeid on 7/5/19.
//  Copyright © 2019 abuzeid. All rights reserved.
//

import UIKit

class User {
    private var currentUser: DirectUser?
    static let shared = User()
    private init() {
        if let user = UserDefaults.standard.value(forKey: userKey) as? DirectUser {
            currentUser = user
        }
    }

    var id: String {
        return currentUser?.userID ?? ""
    }

    var authKey: String {
        return "bf930e30-8c28-42d6-bf8e-f4cbd0b83774"
    }

    var isUserLoggedIn: Bool {
        return currentUser != nil
    }

    var userName: String {
        return currentUser?.username ?? ""
    }

    func logout() {
        currentUser = nil
        UserDefaults.standard.removeObject(forKey: userKey)
        UserDefaults.standard.synchronize()
    }

    func saveUser(_ data: Data) {
        let decoder = JSONDecoder()
        let user = try? decoder.decode(DirectUserResponse.self, from: data)
        guard let duser = user?.userLogin?.first else {
            return
        }
        currentUser = duser
        UserDefaults.standard.set(object: duser, forKey: userKey)
        UserDefaults.standard.synchronize()
    }

    private let userKey = "asdfasdfsadfasdf"
}
