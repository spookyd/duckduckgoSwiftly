//
//  ResponseSpecTests.swift
//  DuckDuckGoSwiftly
//
//  Created by Luke Davis on 6/25/17.
//  Copyright © 2017 Lucky 13 Technologies, LLC. All rights reserved.
//

@testable import DuckDuckGoSwiftly
import Nimble
import Quick

class ResponseSpecTests: QuickSpec {
    override func spec() { // swiftlint:disable:this function_body_length
        describe("Response") {
            var response: Response!
            var networkResponse: (data: Data?, urlResponse: URLResponse?, error: Error?)!
            describe("init") {
                var dataType: DataType!
                beforeEach {
                    dataType = .data
                }
                describe("network error response") {
                    var error: NSError!
                    beforeEach {
                        error = NSError(domain: UUID().uuidString,
                                code: Int(arc4random()),
                                userInfo: nil)
                        networkResponse = (nil, nil, error)
                        response = Response(response: networkResponse, with: dataType)
                    }
                    it("creates a .failure case") {
                        expect({
                            if case .failure(_) = response! {
                                return .succeeded
                            }
                            return .failed(reason: "incorrect enum case")
                        }).to(succeed())
                    }
                }
                describe("incorrect URLResponse Type") {
                    var urlResponse: URLResponse!
                    beforeEach {
                        urlResponse = URLResponse()
                        networkResponse = (nil, urlResponse, nil)
                        response = Response(response: networkResponse, with: dataType)
                    }
                    it("creates a .failure case") {
                        expect({
                            if case .failure(_) = response! {
                                return .succeeded
                            }
                            return .failed(reason: "incorrect enum case")
                        }).to(succeed())
                    }
                    it("contains an unknown response error") {
                        expect({
                            guard case .failure(let error) = response! else {
                                return .failed(reason: "incorrect enum case")
                            }
                            expect(error).to(beAnInstanceOf(NetworkDispatcherError.self))
                            expect({
                                let error = error as! NetworkDispatcherError // swiftlint:disable:this force_cast
                                if case .unknownServiceResponse = error {
                                    return .succeeded
                                }
                                return .failed(reason: "Incorrect error case")
                            }).to(succeed())
                            return .succeeded
                        }).to(succeed())
                    }
                }
                describe("correct HTTPURLResponse") {
                    var httpResponse: HTTPURLResponse!
                    context("invalid status") {
                        beforeEach {
                            let url = URL(string: "https://duckduckgo.com")!
                            httpResponse = HTTPURLResponse(url: url,
                                                           statusCode: 500,
                                                           httpVersion: nil,
                                                           headerFields: nil)
                            networkResponse = (nil, httpResponse, nil)
                            response = Response(response: networkResponse, with: dataType)
                        }
                        it("creates an httpResponse .failure ") {
                            expect({
                                guard case .failure(let error) = response! else {
                                    return .failed(reason: "incorrect enum case")
                                }
                                expect(error).to(beAnInstanceOf(NetworkDispatcherError.self))
                                expect({
                                    let error = error as! NetworkDispatcherError // swiftlint:disable:this force_cast
                                    guard case .httpResponse(let status) = error else {
                                        return .failed(reason: "incorrect enum case")
                                    }
                                    expect(status) == 500
                                    return .succeeded
                                }).to(succeed())
                                return .succeeded
                            }).to(succeed())
                        }
                    }
                    context("200 status") {
                        var data: Data?
                        beforeEach {
                            let url = URL(string: "https://duckduckgo.com")!
                            httpResponse = HTTPURLResponse(url: url,
                                                           statusCode: 200,
                                                           httpVersion: nil,
                                                           headerFields: nil)
                            networkResponse = (data, httpResponse, nil)
                            response = Response(response: networkResponse, with: dataType)
                        }
                        describe("when missing data") {
                            it("generates a NetworkDispatchError") {
                                expect({
                                    guard case .failure(let error) = response! else {
                                        return .failed(reason: "incorrect enum case")
                                    }
                                    expect(error).to(beAnInstanceOf(NetworkDispatcherError.self))
                                    return .succeeded
                                }).to(succeed())
                            }
                            it("which is a missingResponseData case") {
                                expect({
                                    guard case .failure(let error) = response! else {
                                        return .failed(reason: "incorrect case")
                                    }
                                    let err = error as! NetworkDispatcherError // swiftlint:disable:this force_cast
                                    guard case .missingResponseData = err else {
                                        return .failed(reason: "incorrect enum case")
                                    }
                                    return .succeeded
                                }).to(succeed())
                            }
                        }
                        describe("when containing valid json data type") {
                            beforeEach {
                                dataType = .json
                                data = Data(base64Encoded: "ew0KInJlc3VsdCI6ICJkdWNrZHVja2dvIg0KfQ==")
                                networkResponse = (data, httpResponse, nil)
                                response = Response(response: networkResponse, with: dataType)
                            }
                            it("returns correctly parsed json") {
                                guard case .json(let jsonData) = response! else {
                                    XCTFail()
                                    return
                                }
                                let actual = jsonData["result"] as! String // swiftlint:disable:this force_cast
                                expect(actual) == "duckduckgo"
                            }
                        }
                        describe("when containing invalid json data type") {
                            beforeEach {
                                dataType = .json
                                data = Data(base64Encoded: "Tm90IHZhbGlkIGpzb24gZGF0YQ==")
                                networkResponse = (data, httpResponse, nil)
                                response = Response(response: networkResponse, with: dataType)
                            }
                            it("generates a NetworkDispatchError") {
                                expect({
                                    guard case .failure(let error) = response! else {
                                        return .failed(reason: "incorrect enum case")
                                    }
                                    expect(error).to(beAnInstanceOf(NetworkDispatcherError.self))
                                    return .succeeded
                                }).to(succeed())
                            }
                            it("which is a jsonParsingError case") {
                                expect({
                                    guard case .failure(let error) = response! else {
                                        return .failed(reason: "incorrect case")
                                    }
                                    let err = error as! NetworkDispatcherError // swiftlint:disable:this force_cast
                                    guard case .jsonParsingError = err else {
                                        return .failed(reason: "incorrect enum case")
                                    }
                                    return .succeeded
                                }).to(succeed())
                            }
                        }
                        describe("when containing valid raw data type") {
                            beforeEach {
                                data = Data(base64Encoded: "ZHVja2R1Y2tnbw==")
                                networkResponse = (data, httpResponse, nil)
                                response = Response(response: networkResponse, with: dataType)
                            }
                            it("returns the raw data") {
                                guard case .data(let responseData) = response! else {
                                    XCTFail()
                                    return
                                }
                                expect(responseData) == data
                            }
                        }
                    }
                }
            }
        }
    }
}
