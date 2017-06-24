//
//  ResultParser.swift
//  DuckDuckSwift
//
//  Created by Luke Davis on 6/13/17.
//  Copyright © 2017 Lucky 13 Technologies, LLC. All rights reserved.
//

import Foundation

extension Dictionary where Value == Any {
    func parse<T>(_ key: Key) -> T? {
        guard let anything = self[key],
            let value = anything as? T else {
            return nil
        }
        return value
    }
    func parseURL(_ key: Key) -> URL? {
        if let url: String = self.parse(key) {
            return URL(string: url)
        }
        return nil
    }
}
