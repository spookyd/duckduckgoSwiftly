//
//  DuckDuckDispatcher.swift
//  DuckDuckGoSwiftly
//
//  Created by Luke Davis on 6/14/17.
//  Copyright © 2017 Lucky 13 Technologies, LLC. All rights reserved.
//

import Foundation

public enum NetworkDispatcherError: Error {
    case invalidURL(string: String)
    case httpResponse(code: Int)
    case unknownServiceResponse
    case missingResponseData
    case jsonParsingError
}

public struct Environment {
    public var host: String
    public var clientName: String
    public var headers: [String: String] = [:]
    public var cachePolicy: URLRequest.CachePolicy = .reloadIgnoringLocalAndRemoteCacheData
    
    public init(host: String, clientName: String) {
        self.host = host
        self.clientName = clientName
    }
}

public protocol Dispatcher {
    
    var environment: Environment { get }
    
    func execute(request: Request, closure: @escaping (Response) -> Void)
    
}

public class NetworkDispatcher: Dispatcher {
    
    public var environment: Environment
    
    public required init(environment: Environment) {
        self.environment = environment
    }
    
    public func execute(request: Request, closure: @escaping (Response) -> Void) {
        
        let queryString = request.queryParameters.buildQueryString()
        guard let url = URL(string: "\(request.urlString)?\(queryString)") else {
            closure(.failure(NetworkDispatcherError.invalidURL(string: request.urlString)))
            return
        }
        var urlRequest = URLRequest(url: url, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 10)
        urlRequest.httpMethod = request.method.rawValue
        urlRequest.allHTTPHeaderFields = environment.headers

        let session = URLSession.shared

        let dataTask = session.dataTask(with: urlRequest) { (data, urlResponse, error) in
            closure(Response(response: (data, urlResponse, error), with: request.dataType))
        }

        dataTask.resume()
    }
}

extension Dictionary {

    func buildQueryString() -> String {
        return self.map {
            "\($0)=\($1)"
            }.reduce("") {
                $0.characters.count == 0 ? "\($1)" : "\($0)&\($1)"
        }
    }

}
