//
//  InstantAnswerRequestSpecTests.swift
//  DuckDuckGoSwiftly
//
//  Created by Luke Davis on 6/21/17.
//  Copyright © 2017 Lucky 13 Technologies, LLC. All rights reserved.
//

@testable import DuckDuckGoSwiftly
import Nimble
import Quick

class InstantAnswerRequestSpec: QuickSpec {
    override func spec() { // swiftlint:disable:this function_body_length
        describe("Instant Answer Request") {
            var request: InstantAnswerRequest!
            describe("init") {
                var query: String!
                describe("prepares query") {
                    context("when valid") {
                        beforeEach {
                            query = "A sentence with spaces ('and' {special} \"characters\")"
                            request = InstantAnswerRequest(query: query)
                        }
                        it("replaces all spaces with +") {
                            expect(request.query.components(separatedBy: "+").count)
                                == query.components(separatedBy: " ").count
                        }
                        it("percent encodes characters such as ', {, }, (") {
                            expect(request.query).to(contain("%7B", "%7D", "%22"))
                        }
                    }
                    context("when invalid") {
                        beforeEach {
                            query = ""
                            request = InstantAnswerRequest(query: query)
                        }
                        it("creates an empty query") {
                            expect(request.query) == ""
                        }
                    }
                }
                describe("properties set correctly") {
                    it("uses a GET method") {
                        expect(request.method.rawValue) == HTTPMethod.get.rawValue
                    }
                    it("does not add additional string to url path") {
                        expect(request.urlString) == ""
                    }
                }
            }
            describe("parameters") {
                let query = UUID().uuidString
                request = InstantAnswerRequest(query: query)
                context("false options") {
                    beforeEach {
                        request.noHTML = false
                        request.noRedirect = false
                        request.skipDisambiguation = false
                    }
                    describe("noHTML parameter") {
                        it("maps to 0") {
                            expect(request.queryParameters["no_html"]) == "0"
                        }
                    }
                    describe("noRedirect parameter") {
                        it("maps to 0") {
                            expect(request.queryParameters["no_redirect"]) == "0"
                        }
                    }
                    describe("skipDisambiguous parameter") {
                        it("maps to 0") {
                            expect(request.queryParameters["skip_disambig"]) == "0"
                        }
                    }
                }
                context("true options") {
                    beforeEach {
                        request.noHTML = true
                        request.noRedirect = true
                        request.skipDisambiguation = true
                    }
                    describe("noHTML parameter") {
                        it("maps to 1") {
                            expect(request.queryParameters["no_html"]) == "1"
                        }
                    }
                    describe("noRedirect parameter") {
                        it("maps to 1") {
                            expect(request.queryParameters["no_redirect"]) == "1"
                        }
                    }
                    describe("skipDisambiguous parameter is 0") {
                        it("maps to 1") {
                            expect(request.queryParameters["skip_disambig"]) == "1"
                        }
                    }
                }
            }
        }
    }
}
