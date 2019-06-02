//
//  LoginDetailsValidator.swift
//  Daleel
//
//  Created by Abdoelrahman on 3/30/19.
//  Copyright © 2019 abdelrahman mohamed. All rights reserved.
//

import Foundation


struct LoginDetailsValidator: Command {
    let id: String?
    let password: String?
    
    
    init(_ id: String?, _ pass: String?){
        
        self.id = id
        password = pass
    }
    
    func execute() throws {
        guard let id = id, !id.isEmpty, id.isEmail || id.isDigits else {
            throw AuthenticationError.emailOrPhone
        }
        
        guard let password = password, !password.isEmpty else {
            throw AuthenticationError.password
        }
    }
}


