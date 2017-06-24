//
//  Response.swift
//  DuckDuckGoSwiftly
//
//  Created by Luke Davis on 6/14/17.
//  Copyright © 2017 Lucky 13 Technologies, LLC. All rights reserved.
//

import Foundation

public typealias JSON = [String: Any]

public enum Response {
    case json(JSON)
    case data(Data)
    case failure(Error)
    
    init(response: (data: Data?, urlResponse: URLResponse?, error: Error?), with dataType: DataType) {
        if let error = response.error {
            self = .failure(error)
            return
        }
        guard let urlResponse = response.urlResponse as? HTTPURLResponse else {
            self = .failure(NetworkDispatcherError.unknownServiceResponse)
            return
        }
        if urlResponse.statusCode == 200 {
            guard let data = response.data else {
                self = .failure(NetworkDispatcherError.missingResponseData)
                return
            }
            switch dataType {
            case .json:
                guard let json: [String: Any] = (try? JSONSerialization.jsonObject(with: data, options: .allowFragments)) as? [String: Any] else  {
                    self = .failure(NetworkDispatcherError.jsonParsingError)
                    return
                }
                self = .json(json)
            default:
                self = .data(data)
            }
        } else {
            self = .failure(NetworkDispatcherError.httpResponse(code: urlResponse.statusCode))
        }
    }
    
}
