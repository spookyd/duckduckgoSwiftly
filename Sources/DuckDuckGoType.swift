//
//  DuckDuckGoType.swift
//  DuckDuckSwift
//
//  Created by Luke Davis on 6/13/17.
//  Copyright © 2017 Lucky 13 Technologies, LLC. All rights reserved.
//

import Foundation

/// Represents the type of Duck Duck Go results
public enum DuckDuckGoType {
    case article, disambiguation, category, name, exclusive
    
    static func fromString(_ shortName: String) -> DuckDuckGoType? {
        switch shortName {
        case "A":
            return .article
        case "D":
            return .disambiguation
        case "C":
            return .category
        case "N":
            return .name
        case "E":
            return .exclusive
        default:
            return nil
        }
    }
}
