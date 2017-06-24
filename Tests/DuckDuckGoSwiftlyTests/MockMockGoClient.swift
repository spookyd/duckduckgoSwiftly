//
//  MockMockGoClient.swift
//  DuckDuckGoSwiftly
//
//  Created by Luke Davis on 6/14/17.
//  Copyright © 2017 Lucky 13 Technologies, LLC. All rights reserved.
//

@testable import DuckDuckGoSwiftly
import Foundation

class MockMockDispatcher: Dispatcher {

    var environment: Environment
    var request: Request?
    var instantAnswerRequest: InstantAnswerRequest? {
        return request as? InstantAnswerRequest
    }
    var response: Response?

    required init() {
        self.environment = Environment(host: UUID().uuidString, clientName: UUID().uuidString)
    }

    func execute(request: Request, closure: @escaping (Response) -> Void) {
        self.request = request
        if let response = response {
            closure(response)
        }
    }

}
