//
//  InstantAnswer.swift
//  DuckDuckGoSwiftly
//
//  Created by Luke Davis on 6/14/17.
//  Copyright © 2017 Lucky 13 Technologies, LLC. All rights reserved.
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
public struct InstantAnswer {
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
    
    init() {
        
    }
}

extension InstantAnswer {
    
    enum Keys: String {
        case abstract           = "Abstract"
        case abstractText       = "AbstractSource"
        case abstractSource     = "AbstractText"
        case abstractURL        = "AbstractURL"
        case imageURL           = "Image"
        case heading            = "Heading"
        case answer             = "Answer"
        case answerType         = "AnswerType"
        case definition         = "Definition"
        case definitionSource   = "DefinitionSource"
        case definitionURL      = "DefinitionURL"
        case relatedTopics      = "RelatedTopics"
        case results            = "Results"
        case type               = "Type"
        case redirect           = "Redirect"
    }
    
    public static func decode(from dictionary: [String: Any]) -> InstantAnswer {
        var result = InstantAnswer()
        result.abstract = dictionary.parse(Keys.abstract.rawValue)
        result.abstractText = dictionary.parse(Keys.abstractText.rawValue)
        result.abstractSource = dictionary.parse(Keys.abstractSource.rawValue)
        result.abstractURL = dictionary.parseURL(Keys.abstractURL.rawValue)
        result.imageURL = dictionary.parseURL(Keys.imageURL.rawValue)
        result.heading = dictionary.parse(Keys.heading.rawValue)
        result.answer = dictionary.parse(Keys.answer.rawValue)
        result.answerType = dictionary.parse(Keys.answerType.rawValue)
        result.definition = dictionary.parse(Keys.definition.rawValue)
        result.definitionSource = dictionary.parse(Keys.definitionSource.rawValue)
        result.definitionURL = dictionary.parseURL(Keys.definitionURL.rawValue)
        if let topics: [Any] = dictionary.parse(Keys.relatedTopics.rawValue) {
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
        if let topics: [Any] = dictionary.parse(Keys.results.rawValue) {
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
        if let shortName: String = dictionary.parse(Keys.type.rawValue) {
            result.type = DuckDuckGoType.fromString(shortName)
        }
        result.redirect = dictionary.parseURL(Keys.redirect.rawValue)
        return result
    }
    
}
