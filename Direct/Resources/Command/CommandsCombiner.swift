//
//  CommandsCombiner.swift
//  Daleel
//
//  Created by Abdoelrahman on 3/30/19.
//  Copyright © 2019 abdelrahman mohamed. All rights reserved.
//

import Foundation

struct CommandsCombiner: Command {
    
    
    let commands: [Command]
    
    init(_ commands: Command...) {
        self.commands = commands
    }
    
    func execute() throws {
        try commands.forEach { try $0.execute() }
    }
}
