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
    
    static func getLoginCommand(id: String, password: String) -> Command {
        let validatorCommand = LoginDetailsValidator(id, password)
        let reuqestCommand = LoginRequestCommand(id, password: password)
        let combined = CommandsCombiner(validatorCommand, reuqestCommand)
        return combined
    }
}
