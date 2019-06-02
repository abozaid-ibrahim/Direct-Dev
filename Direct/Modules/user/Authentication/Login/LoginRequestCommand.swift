//
//  LoginRequestCommand.swift
//  Daleel
//
//  Created by Abdoelrahman on 3/30/19.
//  Copyright © 2019 abdelrahman mohamed. All rights reserved.
//

import Foundation
import Moya

typealias UserResponse = ((DirectUser) -> Void)?

struct LoginRequestCommand: Command {
    let id: String
    let password: String
    var completion: UserResponse
    init(_ id: String, password: String, completion: UserResponse) {
        self.id = id
        self.password = password
        self.completion = completion
    }
    
    func execute() throws {
//        UserRequest.login(phone: id, password: password).send(DaleelUser.self, completion: completion)
        let provider = MoyaProvider<AuthAPI>()
        provider.request(.login(id: id, password: password)) { (response) in
            switch response {
            case .failure(let error):
                print(error)
            case .success(let value):
                print(value)
//                let user = try decoder.decode(DirectUserResponse.self, from: value.data)
//                completion(posts, nil)
            }
        }
    }
}
