//
//  Foundation+Extensions.swift
//  DuckDuckGoSwiftly
//
//  Created by Luke Davis on 6/15/17.
//  Copyright © 2017 Lucky 13 Technologies, LLC. All rights reserved.
//

import Foundation

extension String {
    static func random() -> String {
        return UUID().uuidString
    }
}

extension Int {
    static func random() -> Int {
        return Int(arc4random())
    }
}
