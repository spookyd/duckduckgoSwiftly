//
//  DictionaryQueryParameterUnitTests.swift
//  DuckDuckGoSwiftly
//
//  Created by Luke Davis on 6/24/17.
//  Copyright © 2017 Lucky 13 Technologies, LLC. All rights reserved.
//

@testable import DuckDuckGoSwiftly
import XCTest

class DictionaryQueryParameterUnitTests: XCTestCase {

    func testQueryParameter() {
        let expectedNumber = 123
        let expectedBoolean = true
        let expectedString = "asdf"
        let dictionary: [String: Any] = [
            "number": expectedNumber,
            "boolean": expectedBoolean,
            "string": expectedString
        ]
        let expected = "number=\(expectedNumber)"
            + "&boolean=\(expectedBoolean)"
            + "&string=\(expectedString)"
        let actual = dictionary.buildQueryString()
        XCTAssertEqual(expected, actual)
    }

}
