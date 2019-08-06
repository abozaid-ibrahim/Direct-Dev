//
//  User.swift
//  Direct
//
//  Created by abuzeid on 7/5/19.
//  Copyright © 2019 abuzeid. All rights reserved.
//

import UIKit
import RxSwift

class User {
    private var currentUser: DirectUser?
    static let shared = User()
    var newUserData = PublishSubject<Bool>()
    private init() {
        if let data = UserDefaults.standard.value(forKey: userKey) as? Data {
            let decoder = JSONDecoder()
            currentUser = try? decoder.decode(DirectUser.self, from: data)
        }
    }

    var id: String {
        print(currentUser?.userID ?? "")
        return currentUser?.userID ?? ""
    }

    var authKey: String {
        return "bf930e30-8c28-42d6-bf8e-f4cbd0b83774"
    }

    var isUserLoggedIn: Bool {
        return currentUser != nil
    }

    var userName: String {
        return currentUser?.firstName ?? currentUser?.lastName ?? ""
    }

    func logout() {
        currentUser = nil
        UserDefaults.standard.removeObject(forKey: userKey)
        UserDefaults.standard.synchronize()
        newUserData.onNext(true)
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
        newUserData.onNext(true)
    }

    private let userKey = "asdfasdfsadfasdf"
}
