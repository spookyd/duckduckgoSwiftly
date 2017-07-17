//
//  InstantAnswerFixture.swift
//  DuckDuckGoSwiftly
//
//  Created by Luke Davis on 6/24/17.
//  Copyright © 2017 Lucky 13 Technologies, LLC. All rights reserved.
//

@testable import DuckDuckGoSwiftly
import Foundation

struct ValidDictionary {
    func makeInstantAnswer() -> [String: Any] {
        return [
            InstantAnswer.Keys.abstract.rawValue: UUID().uuidString,
            InstantAnswer.Keys.abstractText.rawValue: UUID().uuidString,
            InstantAnswer.Keys.abstractSource.rawValue: UUID().uuidString,
            InstantAnswer.Keys.abstractURL.rawValue: "http://duckduckgo.com",
            InstantAnswer.Keys.imageURL.rawValue: "http://duckduckgo.com",
            InstantAnswer.Keys.heading.rawValue: UUID().uuidString,
            InstantAnswer.Keys.answer.rawValue: UUID().uuidString,
            InstantAnswer.Keys.answerType.rawValue: UUID().uuidString,
            InstantAnswer.Keys.definition.rawValue: UUID().uuidString,
            InstantAnswer.Keys.definitionSource.rawValue: UUID().uuidString,
            InstantAnswer.Keys.definitionURL.rawValue: "http://duckduckgo.com",
            InstantAnswer.Keys.relatedTopics.rawValue: [
                makeDuckDuckGoTopic(),
                makeDuckDuckGoTopic(),
                makeDuckDuckGoTopic()
            ],
            InstantAnswer.Keys.results.rawValue: [
                makeDuckDuckGoTopic(),
                makeDuckDuckGoTopic(),
                makeDuckDuckGoTopic()
            ],
            InstantAnswer.Keys.type.rawValue: "E",
            InstantAnswer.Keys.redirect.rawValue: "http://duckduckgo.com"
        ]
    }

    func makeDuckDuckGoTopic() -> [String: Any] {
        return [
            DuckDuckGoTopic.Keys.result.rawValue: "<a href=\"http://url\">\(UUID().uuidString)</a>",
            DuckDuckGoTopic.Keys.firstURL.rawValue: "http://duckduckgo.com",
            DuckDuckGoTopic.Keys.icon.rawValue: self.makeDuckDuckGoIcon()
        ]
    }
    
    func makeDuckDuckGoCategory() -> [String: Any] {
        return [
            DuckDuckGoCategory.Keys.name.rawValue: UUID().uuidString,
            DuckDuckGoCategory.Keys.topics.rawValue: [
                makeDuckDuckGoTopic(),
                makeDuckDuckGoTopic(),
                makeDuckDuckGoTopic()
            ]
        ]
    }

    func makeDuckDuckGoIcon() -> [String: Any] {
        return [
            DuckDuckGoIcon.Keys.url.rawValue: "http://duckduckgo.com",
            DuckDuckGoIcon.Keys.height.rawValue: Float(arc4random()),
            DuckDuckGoIcon.Keys.width.rawValue: Float(arc4random())
        ]
    }

}
