//
//  NetworkErrors.swift
//  Direct
//
//  Created by abuzeid on 5/26/19.
//  Copyright © 2019 abuzeid. All rights reserved.
//

import Foundation
enum NetworkFailure: Error {
    case generalFailure, failedToParseData
}
