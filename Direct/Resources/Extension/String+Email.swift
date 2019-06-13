//
//  String+Email.swift
//  Direct
//
//  Created by Abdoelrhman Eaita on 5/31/19.
//  Copyright © 2019 abuzeid. All rights reserved.
//

import Foundation

extension String {
    var isEmail: Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,20}"
        let emailTest = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: self)
    }
}
