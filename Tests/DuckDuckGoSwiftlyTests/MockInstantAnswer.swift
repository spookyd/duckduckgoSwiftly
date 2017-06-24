//
//  MockInstantAnswer.swift
//  DuckDuckGoSwiftly
//
//  Created by Luke Davis on 6/15/17.
//  Copyright © 2017 Lucky 13 Technologies, LLC. All rights reserved.
//

@testable import DuckDuckGoSwiftly
import Foundation

extension InstantAnswer {
    static func makeInstantAnswer() -> InstantAnswer {
        var answer = InstantAnswer()
        answer.abstract = String.random()
        answer.abstractSource = String.random()
        answer.answer = String.random()
        return answer
    }

    func makeDictionaryRepresentation() -> [String: Any] {
        return [
            "Abstract": self.abstract ?? "",
            "Answer": self.answer ?? ""
            ]
    }

}
