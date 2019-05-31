//
//  Command.swift
//  Daleel
//
//  Created by Abdoelrahman on 3/30/19.
//  Copyright © 2019 abdelrahman mohamed. All rights reserved.
//

import Foundation

protocol Command {
    func execute() throws
    func undo() throws
}

extension Command {
    func undo() throws {}
}
