//
//  InputsJsonBuilder.swift
//  Direct
//
//  Created by abuzeid on 6/7/19.
//  Copyright © 2019 abuzeid. All rights reserved.
//

import Foundation
class InputJsonBuilder {
    func buildPassangers(_ input: [String]) -> String {
        var output = "["
        input.forEach {
            let key = $0.split(separator: "-", maxSplits: 2, omittingEmptySubsequences: true)
            output += "{\"\(key[0])\":\"\(key[1])\"},"
        }
        output.removeLast()
        output += "]"
        return output
    }
}
