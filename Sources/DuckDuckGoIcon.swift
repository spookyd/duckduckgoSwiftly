//
//  DuckDuckGoIcon.swift
//  DuckDuckSwift
//
//  Created by Luke Davis on 6/13/17.
//  Copyright © 2017 Lucky 13 Technologies, LLC. All rights reserved.
//

import Foundation

//    var URL: URL of icon
//    var Height: height of icon (px)
//    var Width: width of icon (px)
public struct DuckDuckGoIcon {
    public var url: URL?
    public var height: Float?
    public var width: Float?
}

extension DuckDuckGoIcon {
    
    enum Keys: String {
        case url    = "URL"
        case height = "Height"
        case width  = "Width"
    }
    
    public static func decode(from dictionary: [String: Any]) -> DuckDuckGoIcon? {
        var result = DuckDuckGoIcon()
        result.url = dictionary.parseURL(Keys.url.rawValue)
        result.height = dictionary.parse(Keys.height.rawValue)
        result.width = dictionary.parse(Keys.width.rawValue)
        return result
    }
    
}
