//
//  DuckDuckGoType.swift
//  DuckDuckSwift
//
//  Created by Luke Davis on 6/13/17.
//  Copyright © 2017 Lucky 13 Technologies, LLC. All rights reserved.
//

import Foundation

/// Represents the type of Duck Duck Go results
public enum DuckDuckGoType: String {
    case article        = "A"
    case disambiguation = "D"
    case category       = "C"
    case name           = "N"
    case exclusive      = "E"
    
    static func fromString(_ shortName: String) -> DuckDuckGoType? {
        switch shortName {
        case DuckDuckGoType.article.rawValue:
            return .article
        case DuckDuckGoType.disambiguation.rawValue:
            return .disambiguation
        case DuckDuckGoType.category.rawValue:
            return .category
        case DuckDuckGoType.name.rawValue:
            return .name
        case DuckDuckGoType.exclusive.rawValue:
            return .exclusive
        default:
            return nil
        }
    }
}
