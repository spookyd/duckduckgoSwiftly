//
//  DictionaryParserUnitTests.swift
//  DuckDuckGoSwiftly
//
//  Created by Luke Davis on 6/23/17.
//  Copyright © 2017 Lucky 13 Technologies, LLC. All rights reserved.
//

@testable import DuckDuckGoSwiftly
import XCTest

class DictionaryParserUnitTests: XCTestCase {

    func testParse() {
        let key = "some_key"
        let expected = 5
        let dictionary: [String: Any] = [key: expected]
        let actual: Int? = dictionary.parse(key)
        XCTAssertEqual(expected, actual)
    }

    func testParse_nil() {
        let key = "some_key"
        let value = 5
        let dictionary: [String: Any] = [key: value]
        let actual: String? = dictionary.parse(key)
        XCTAssertNil(actual)
    }

    func testParseURL() {
        let key = "some_key"
        let value = "http://duckduckgo.com"
        let dictionary: [String: Any] = [key: value]
        let actual: URL? = dictionary.parseURL(key)
        XCTAssertEqual(value, actual?.absoluteString)
    }

    func testParseURL_nil() {
        let key = "some_key"
        let value = "not valid url"
        let dictionary: [String: Any] = [key: value]
        let actual: URL? = dictionary.parseURL(key)
        XCTAssertNil(actual)
    }

}
