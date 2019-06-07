//
//  DirectTests.swift
//  DirectTests
//
//  Created by abuzeid on 6/7/19.
//  Copyright © 2019 abuzeid. All rights reserved.
//

import XCTest

class PassangersTests: XCTestCase {


    func testJsonBuilder() {
        let input  = ["egypt-2011","saudi-2010"]
        XCTAssertEqual(InputJsonBuilder().buildPassangers(input), "[{\"egypt\":\"2011\"},{\"saudi\":\"2010\"}]")
    }

}
