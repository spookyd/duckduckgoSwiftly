//
//  DuckDuckGoResults.swift
//  DuckDuckSwift
//
//  Created by Luke Davis on 4/2/16.
//  Copyright © 2016 Lucky 13 Technologies, LLC. All rights reserved.
//

import Foundation


/**
 Abstract: topic summary (can contain HTML, e.g. italics)
 AbstractText: topic summary (with no HTML)
 AbstractSource: name of Abstract source
 AbstractURL: deep link to expanded topic page in AbstractSource
 Image: link to image that goes with Abstract
 Heading: name of topic that goes with Abstract
 
 Answer: instant answer
 AnswerType: type of Answer, e.g. calc, color, digest, info, ip, iploc, phone, pw, rand, regexp, unicode, upc, or zip (see the tour page for examples).
 
 Definition: dictionary definition (may differ from Abstract)
 DefinitionSource: name of Definition source
 DefinitionURL: deep link to expanded definition page in DefinitionSource
 
 Type: response category, i.e. A (article), D (disambiguation), C (category), N (name), E (exclusive), or nothing.
 
 Redirect: !bang redirect URL
 */
public struct DuckDuckGoResponse {
    public var abstract: String?
    public var abstractText: String?
    public var abstractSource: String?
    public var abstractURL: URL?
    public var imageURL: URL?
    public var heading: String?
    public var answer: String?
    public var answerType: String?
    public var definition: String?
    public var definitionSource: String?
    public var definitionURL: URL?
    public var relatedTopics: [DuckDuckGoTopic] = []
    public var results: [DuckDuckGoTopic] = []
    public var type: DuckDuckGoType?
    public var redirect: URL?
}

extension DuckDuckGoResponse {
    
    public static func decode(from dictionary: [String: Any]) -> DuckDuckGoResponse {
        var result = DuckDuckGoResponse()
        result.abstract = dictionary.parse("Abstract")
        result.abstractSource = dictionary.parse("AbstractSource")
        result.abstractText = dictionary.parse("AbstractText")
        result.abstractURL = dictionary.parseURL("AbstractURL")
        result.heading = dictionary.parse("Heading")
        result.imageURL = dictionary.parseURL("Image")
        result.answer = dictionary.parse("Answer")
        result.answerType = dictionary.parse("AnswerType")
        result.definition = dictionary.parse("Definition")
        result.definitionSource = dictionary.parse("DefinitionSource")
        result.definitionURL = dictionary.parseURL("DefinitionURL")
        if let topics: [Any] = dictionary.parse("RelatedTopics") {
            var relatedTopics: [DuckDuckGoTopic] = []
            for topic in topics {
                if let topicDictionary = topic as? [String: Any] {
                    if let topicParsed = DuckDuckGoTopic.decode(from: topicDictionary) {
                        relatedTopics.append(topicParsed)
                    }
                }
            }
            result.relatedTopics = relatedTopics
        }
        if let topics: [Any] = dictionary.parse("Results") {
            var relatedTopics: [DuckDuckGoTopic] = []
            for topic in topics {
                if let topicDictionary = topic as? [String: Any] {
                    if let topicParsed = DuckDuckGoTopic.decode(from: topicDictionary) {
                        relatedTopics.append(topicParsed)
                    }
                }
            }
            result.results = relatedTopics
        }
        if let shortName: String = dictionary.parse("Type") {
            result.type = DuckDuckGoType.fromString(shortName)
        }
        result.redirect = dictionary.parseURL("Redirect")
        return result
    }
    
}
