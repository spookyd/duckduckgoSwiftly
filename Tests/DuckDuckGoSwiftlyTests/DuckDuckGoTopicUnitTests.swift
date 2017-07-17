//
//  DuckDuckGoTopicUnitTests.swift
//  DuckDuckGoSwiftly
//
//  Created by Luke Davis on 6/24/17.
//  Copyright © 2017 Lucky 13 Technologies, LLC. All rights reserved.
//

@testable import DuckDuckGoSwiftly
import XCTest

class DuckDuckGoTopicUnitTests: XCTestCase {

    typealias Keys = DuckDuckGoTopic

    var dictionary: [String: Any]!

    override func setUp() {
        super.setUp()
        dictionary = ValidDictionary().makeDuckDuckGoTopic()
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testDecode() {
        let actual = DuckDuckGoTopic.decode(from: dictionary)
        XCTAssertTrue((dictionary[DuckDuckGoTopic.Keys.result.rawValue] as? String)?.contains(actual?.result ?? "") ?? false)
        XCTAssertEqual(dictionary[DuckDuckGoTopic.Keys.firstURL.rawValue] as? String, actual?.firstURL?.absoluteString)
        XCTAssertEqual(dictionary[DuckDuckGoTopic.Keys.text.rawValue] as? String, actual?.text)
    }

}
