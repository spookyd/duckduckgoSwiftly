//
//  DuckDuckGoCategoryUnitTests.swift
//  DuckDuckGoSwiftly
//
//  Created by Luke Davis on 7/16/17.
//  Copyright © 2017 Lucky 13 Technologies, LLC. All rights reserved.
//

@testable import DuckDuckGoSwiftly
import XCTest

class DuckDuckGoCategoryUnitTests: XCTestCase {
    
    typealias Keys = DuckDuckGoCategory
    
    var dictionary: [String: Any]!
    
    override func setUp() {
        super.setUp()
        dictionary = ValidDictionary().makeDuckDuckGoCategory()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testDecode() {
        let actual = DuckDuckGoCategory.decode(from: dictionary)
        XCTAssertEqual(dictionary[DuckDuckGoCategory.Keys.name.rawValue] as? String, actual?.name)
        XCTAssertEqual((dictionary[DuckDuckGoCategory.Keys.topics.rawValue] as? [[String: Any]])?.count, actual?.topics.count)
    }
    
}
