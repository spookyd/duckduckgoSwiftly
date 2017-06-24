//
//  DuckDuckGo.swift
//  DuckDuckGoSwiftly
//
//  Created by Luke Davis on 6/14/17.
//  Copyright © 2017 Lucky 13 Technologies, LLC. All rights reserved.
//

import Foundation

public struct DuckDuckGo {
    
    public var dispatcher: Dispatcher
    
    public init(clientName: String) {
        let environment = Environment(host: "https://api.duckduckgo.com", clientName: clientName)
        self.dispatcher = NetworkDispatcher(environment: environment)
    }
    
    public init(dispatcher: Dispatcher) {
        self.dispatcher = dispatcher
    }
    
    public func instantAnswer(inquery: String,
                              closure: @escaping (InstantAnswer) -> Void) {
        instantAnswer(request: InstantAnswerRequest(query: inquery), closure: closure)
    }
    
    public func instantAnswer(request: InstantAnswerRequest,
                              closure: @escaping (InstantAnswer) -> Void) {
        var instantRequest = request
        instantRequest.clientName = dispatcher.environment.clientName
        dispatcher.execute(request: instantRequest) { response in
            switch response {
            case let .json(json): closure(InstantAnswer.decode(from: json))
            case .data(_): closure(InstantAnswer()) // Need to handle
            case .failure(_): closure(InstantAnswer()) // We should not be here need to handle
            }
        }
    }
    
}
