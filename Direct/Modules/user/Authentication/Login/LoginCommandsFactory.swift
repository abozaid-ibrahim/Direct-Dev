//
//  LoginCommandsFactory.swift
//  Daleel
//
//  Created by Abdoelrahman on 3/30/19.
//  Copyright © 2019 abdelrahman mohamed. All rights reserved.
//

import Foundation

struct LoginCommandsFactory {
    
    private init() {}
    
    static func getLoginCommand(id: String, password: String, completion: UserResponse) -> Command {
        let validatorCommand = LoginDetailsValidator(id, password)
        let reuqestCommand = LoginRequestCommand(id, password: password, completion: completion)
        let combined = CommandsCombiner(validatorCommand, reuqestCommand)
        return combined
    }
}
