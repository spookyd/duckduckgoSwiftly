//
//  InstantAnswerUnitTests.swift
//  DuckDuckGoSwiftly
//
//  Created by Luke Davis on 6/24/17.
//  Copyright © 2017 Lucky 13 Technologies, LLC. All rights reserved.
//

@testable import DuckDuckGoSwiftly
import XCTest

class InstantAnswerUnitTests: XCTestCase {

    typealias Keys = InstantAnswer.Keys

    var validDictionary: [String: Any]!
    var invalidKeyDictionary: [String: Any]!
    var missingKeyDictionary: [String: Any]!

    override func setUp() {
        super.setUp()
        validDictionary = ValidDictionary().makeInstantAnswer()
        invalidKeyDictionary = validDictionary.reduce([:]) {
            var map = $0
            map?["invalid_\($1.0)"] = $1.1
            return map
        }
        missingKeyDictionary = [:]
    }

    override func tearDown() {
        super.tearDown()
    }

    func testDecode_mapsCorrectValues() {
        let instantAnswer = InstantAnswer.decode(from: validDictionary)
        XCTAssertEqual(validDictionary[Keys.abstract.rawValue] as? String, instantAnswer.abstract)
        XCTAssertEqual(validDictionary[Keys.abstractText.rawValue] as? String,
                       instantAnswer.abstractText)
        XCTAssertEqual(validDictionary[Keys.abstractSource.rawValue] as? String,
                       instantAnswer.abstractSource)
        XCTAssertEqual(validDictionary[Keys.abstractURL.rawValue] as? String,
                       instantAnswer.abstractURL?.absoluteString)
        XCTAssertEqual(validDictionary[Keys.imageURL.rawValue] as? String,
                       instantAnswer.imageURL?.absoluteString)
        XCTAssertEqual(validDictionary[Keys.heading.rawValue] as? String,
                       instantAnswer.heading)
        XCTAssertEqual(validDictionary[Keys.answer.rawValue] as? String,
                       instantAnswer.answer)
        XCTAssertEqual(validDictionary[Keys.answerType.rawValue] as? String,
                       instantAnswer.answerType)
        XCTAssertEqual(validDictionary[Keys.definition.rawValue] as? String,
                       instantAnswer.definition)
        XCTAssertEqual(validDictionary[Keys.definitionSource.rawValue] as? String,
                       instantAnswer.definitionSource)
        XCTAssertEqual(validDictionary[Keys.definitionURL.rawValue] as? String,
                       instantAnswer.definitionURL?.absoluteString)
        XCTAssertEqual((validDictionary[Keys.relatedTopics.rawValue] as? [Any])?.count,
                       instantAnswer.relatedTopics.count)
        XCTAssertEqual((validDictionary[Keys.results.rawValue] as? [Any])?.count,
                       instantAnswer.results.count)
        XCTAssertEqual(validDictionary[Keys.type.rawValue] as? String,
                       instantAnswer.type?.rawValue)
        XCTAssertEqual(validDictionary[Keys.redirect.rawValue] as? String,
                       instantAnswer.redirect?.absoluteString)
    }

}
