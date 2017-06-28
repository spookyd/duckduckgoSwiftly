//
//  DuckDuckGoIconUnitTests.swift
//  DuckDuckGoSwiftly
//
//  Created by Luke Davis on 6/24/17.
//  Copyright © 2017 Lucky 13 Technologies, LLC. All rights reserved.
//

@testable import DuckDuckGoSwiftly
import XCTest

class DuckDuckGoIconUnitTests: XCTestCase {

    typealias Keys = DuckDuckGoIcon.Keys

    var dictionary: [String: Any]!

    override func setUp() {
        super.setUp()
        dictionary = ValidDictionary().makeDuckDuckGoIcon()
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testDecode() {
        let actual = DuckDuckGoIcon.decode(from: dictionary)
        XCTAssertEqual(dictionary[Keys.url.rawValue] as? String, actual?.url?.absoluteString)
        XCTAssertEqual(dictionary[Keys.height.rawValue] as? Float, actual?.height)
        XCTAssertEqual(dictionary[Keys.width.rawValue] as? Float, actual?.width)
    }

}
