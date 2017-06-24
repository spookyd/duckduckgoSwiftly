//
//  DuckDuckGoTypeUnitTests.swift
//  DuckDuckGoSwiftly
//
//  Created by Luke Davis on 6/23/17.
//  Copyright © 2017 Lucky 13 Technologies, LLC. All rights reserved.
//

@testable import DuckDuckGoSwiftly
import XCTest

class DuckDuckGoTypeUnitTests: XCTestCase {

    func testFromString_article() {
        let type = DuckDuckGoType.fromString("A")
        XCTAssertEqual(DuckDuckGoType.article, type)
    }

    func testFromString_disambiguation() {
        let type = DuckDuckGoType.fromString("D")
        XCTAssertEqual(DuckDuckGoType.disambiguation, type)
    }

    func testFromString_category() {
        let type = DuckDuckGoType.fromString("C")
        XCTAssertEqual(DuckDuckGoType.category, type)
    }

    func testFromString_name() {
        let type = DuckDuckGoType.fromString("N")
        XCTAssertEqual(DuckDuckGoType.name, type)
    }

    func testFromString_exclusive() {
        let type = DuckDuckGoType.fromString("E")
        XCTAssertEqual(DuckDuckGoType.exclusive, type)
    }

    func testFromString_invalid() {
        let type = DuckDuckGoType.fromString("invalid")
        XCTAssertNil(type)
    }

}
