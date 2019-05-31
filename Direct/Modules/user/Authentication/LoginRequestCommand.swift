//
//  LoginRequestCommand.swift
//  Daleel
//
//  Created by Abdoelrahman on 3/30/19.
//  Copyright © 2019 abdelrahman mohamed. All rights reserved.
//

import Foundation

struct LoginRequestCommand: Command {
    
    let id: String
    let password: String
    
    init(_ id: String, password: String) {
        self.id = id
        self.password = password
    }
    
    func execute() throws {
//        UserRequest.login(phone: id, password: password).send(DaleelUser.self, completion: completion)
    }
}
