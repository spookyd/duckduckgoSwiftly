//
//  DuckDuckGoCategory.swift
//  DuckDuckGoSwiftly
//
//  Created by Luke Davis on 7/4/17.
//  Copyright © 2017 Lucky 13 Technologies, LLC. All rights reserved.
//

import Foundation

//    var Name: Name of category
//    var Topics: The list of nested topics
public struct DuckDuckGoCategory {
    public var name: String?
    public var topics: [DuckDuckGoTopic] = []
}

extension DuckDuckGoCategory {
    
    enum Keys: String {
        case name     = "Name"
        case topics   = "Topics"
    }
    
    public static func decode(from dicitionary: [String: Any]) -> DuckDuckGoCategory? {
        // Since categories and topics are inner mixed we have to base it on missing a name
        guard let name: String = dicitionary.parse(Keys.name.rawValue) else { return nil }
        var category = DuckDuckGoCategory()
        category.name = name
        if let topicsArray: [[String: Any]] = dicitionary.parse(Keys.topics.rawValue) {
            category.topics = topicsArray.flatMap({ DuckDuckGoTopic.decode(from: $0) })
        }
        return category
    }
    
}
