//
//  DuckDuckGoTopic.swift
//  DuckDuckSwift
//
//  Created by Luke Davis on 6/13/17.
//  Copyright © 2017 Lucky 13 Technologies, LLC. All rights reserved.
//

import Foundation

//    var Result: HTML link(s) to related topic(s)
//    var FirstURL: first URL in Result
//    var Icon: icon associated with related topic(s)
//    var Text: text from first URL
public struct DuckDuckGoTopic {
    public var result: String?
    public var firstURL: URL?
    public var icon: DuckDuckGoIcon?
    public var text: String?
}

extension DuckDuckGoTopic {
    
    public static func decode(from dicitionary: [String: Any]) -> DuckDuckGoTopic? {
        var result = DuckDuckGoTopic()
        result.firstURL = dicitionary.parseURL("FirstURL")
        if let iconDictionary: [String: Any] = dicitionary.parse("Icon") {
            result.icon = DuckDuckGoIcon.decode(from: iconDictionary)
        }
        result.result = dicitionary.parse("Result")
        result.text = dicitionary.parse("Text")
        return result
    }
    
}
