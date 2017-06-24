//
//  InstantAnswerRequest.swift
//  DuckDuckGo
//
//  Created by Luke Davis on 6/13/17.
//  Copyright © 2017 Lucky 13 Technologies, LLC. All rights reserved.
//

import Foundation

public enum HTTPMethod: String {
    case get = "GET"
}

public enum DataType {
    case json
    case xml
    case data
}

public protocol Request {
    var urlString: String { get }
    var method: HTTPMethod { get }
    var queryParameters: [String: String] { get }
    var dataType: DataType { get }
}

/**
 q: query
 
 
 format: output format (json or xml)
 
 If format=='json', you can also pass:
 
 callback: function to callback (JSONP format)
 pretty: 1 to make JSON look pretty (like JSONView for Chrome/Firefox)
 
 
 no_redirect: 1 to skip HTTP redirects (for !bang commands).
 
 
 no_html: 1 to remove HTML from text, e.g. bold and italics.
 
 
 skip_disambig: 1 to skip disambiguation (D) Type.
 */
public struct InstantAnswerRequest: Request {
    
    public enum Format {
        case xml
        case json(pretty: Bool)
    }
    
    var query: String
    var clientName: String = ""
    public var skipDisambiguation: Bool = true
    public var noHTML: Bool = true
    public var noRedirect: Bool = true
    // Only supporting json now
    var format: Format = .json(pretty: true)
    
    public var urlString: String {
        return ""
    }
    
    public var method: HTTPMethod {
        return .get
    }
    
    public var queryParameters: [String : String] {
        return [
            "q": query,
            "no_redirect": noRedirect.queryStringParameterValue(),
            "no_html": noHTML.queryStringParameterValue(),
            "skip_disambig": skipDisambiguation.queryStringParameterValue(),
            "format": format.queryStringParameterValue(),
            "pretty": format.prettyOptionQueryStringParameterValue(),
            "t": clientName
        ]
    }
    
    public var dataType: DataType {
        switch format {
        case .json(pretty: _): return .json
        default: return .xml
        }
    }
    
    public init(query: String) {
        self.query = query.replacingOccurrences(of: " ", with: "+")
            .addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
    }
}

private extension Bool {
    func queryStringParameterValue() -> String {
        return self ? "1" : "0"
    }
}

private extension InstantAnswerRequest.Format {
    func queryStringParameterValue() -> String {
        switch self {
        case .xml: return "xml"
        default: return "json"
        }
    }
    
    func prettyOptionQueryStringParameterValue() -> String {
        switch self {
        case let .json(pretty): return pretty.queryStringParameterValue()
        default: return true.queryStringParameterValue()
        }
    }
}

