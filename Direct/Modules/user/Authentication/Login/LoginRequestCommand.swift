//
//  LoginRequestCommand.swift
//  Daleel
//
//  Created by Abdoelrahman on 3/30/19.
//  Copyright © 2019 abdelrahman mohamed. All rights reserved.
//

import Foundation
import Moya

typealias UserResponse = ((Result<DirectUser, Error>) -> Void)?

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
        provider.request(.login(id: id, password: password)) { response in
            switch response {
            case let .failure(error):
                self.completion?(.failure(error))
            case let .success(value):
                print(value)
                let decoder = JSONDecoder()

                let user = try? decoder.decode(DirectUserResponse.self, from: value.data)
                guard let duser = user?.userLogin?.first else {
                    self.completion?(.failure(APIError.decodeError))
                    return
                }
                self.completion?(.success(duser))
            }
        }
    }
}

enum APIError: Error {
    case decodeError
}
