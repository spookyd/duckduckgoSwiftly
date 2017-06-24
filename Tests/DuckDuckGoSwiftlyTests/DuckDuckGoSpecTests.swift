//
//  DuckDuckGoTests.swift
//  DuckDuckGoSwiftly
//
//  Created by Luke Davis on 6/14/17.
//  Copyright © 2017 Lucky 13 Technologies, LLC. All rights reserved.
//

import DuckDuckGoSwiftly
import Nimble
import Quick

class DuckDuckGoSpec: QuickSpec {
    override func spec() {

        describe("a Duck Duck Go Request") {
            var duckDuckGo: DuckDuckGo!
            var mockDispatcher: MockMockDispatcher!
            beforeEach {
                mockDispatcher = MockMockDispatcher()
                duckDuckGo = DuckDuckGo(dispatcher: mockDispatcher)
            }
            describe("init") {
                var duckDuckGo: DuckDuckGo!
                context("with client name") {
                    var clientName: String!
                    var host: String!
                    beforeEach {
                        clientName = String.random()
                        host = "https://api.duckduckgo.com"
                        duckDuckGo = DuckDuckGo(clientName: clientName)
                    }
                    it("has client name in the dispatcher") {
                        expect(duckDuckGo.dispatcher.environment.clientName) == clientName
                    }
                    it("has correct default url") {
                        expect(duckDuckGo.dispatcher.environment.host) == host
                    }
                }
                context("with dispatcher") {
                    var dispatcher: MockMockDispatcher!
                    beforeEach {
                        dispatcher = MockMockDispatcher()
                        duckDuckGo = DuckDuckGo(dispatcher: dispatcher)
                    }
                    it("has matching host") {
                        expect(duckDuckGo.dispatcher.environment.host) == dispatcher.environment.host
                    }
                    it("has matching client name") {
                        expect(duckDuckGo.dispatcher.environment.clientName)
                            .to(equal(dispatcher.environment.clientName))
                    }
                }
            }

            describe("instant answer") {
                describe("request") {
                    var q: String!
                    var request: InstantAnswerRequest!
                    beforeEach {
                        q = String.random()
                        duckDuckGo.instantAnswer(inquery: q, closure: { _ in })
                        request = mockDispatcher.instantAnswerRequest
                    }
                    it("is an InstantAnswerRequest") {
                        expect(request).to(beAKindOf(InstantAnswerRequest.self))
                    }
                    describe("mapped parameters") {
                        /*
                         "no_redirect": noRedirect.queryStringParameterValue(),
                         "no_html": noHTML.queryStringParameterValue(),
                         "skip_disambig": skipDisambiguation.queryStringParameterValue(),
                         "format": format.queryStringParameterValue(),
                         "pretty": format.prettyOptionQueryStringParameterValue(),
                         */
                        var parameters: [String: String]!
                        beforeEach {
                            parameters = request.queryParameters
                        }
                        it("contains client name") {
                            let clientName = parameters["t"]
                            expect(clientName).notTo(beNil())
                            expect(clientName) == duckDuckGo.dispatcher.environment.clientName
                        }
                        it("contains query") {
                            let query = parameters["q"]
                            expect(query).notTo(beNil())
                            expect(query) == q
                        }
                        it("contains no redirect and defaults to 1") {
                            let noRedirect = parameters["no_redirect"]
                            expect(noRedirect).notTo(beNil())
                            expect(noRedirect) == "1"
                        }
                        it("contains no html options and defaults to 1") {
                            let noRedirect = parameters["no_html"]
                            expect(noRedirect).notTo(beNil())
                            expect(noRedirect) == "1"
                        }
                        it("contains skip disambig options and defaults to 1") {
                            let noRedirect = parameters["skip_disambig"]
                            expect(noRedirect).notTo(beNil())
                            expect(noRedirect) == "1"
                        }
                        it("contains format options and defaults to json") {
                            let noRedirect = parameters["format"]
                            expect(noRedirect).notTo(beNil())
                            expect(noRedirect) == "json"
                        }
                        it("contains pretty options and defaults to 1") {
                            let noRedirect = parameters["pretty"]
                            expect(noRedirect).notTo(beNil())
                            expect(noRedirect) == "1"
                        }
                    }
                }
                describe("closure is called") {
                    var answer: InstantAnswer!
                    context("when request is successful") {
                        beforeEach {
                            answer = InstantAnswer.makeInstantAnswer()
                            mockDispatcher.response = .json(answer.makeDictionaryRepresentation())
                        }
                        it("answer is non-nil") {
                            duckDuckGo.instantAnswer(inquery: String.random()) { answer in
                                expect(answer.answer).notTo(beNil())
                            }
                        }
                    }
                    context("when request is unsuccessful") {
                        beforeEach {
                            mockDispatcher.response = .failure(NetworkDispatcherError.jsonParsingError)
                        }
                        it("answer is nil") {
                            duckDuckGo.instantAnswer(inquery: String.random()) { answer in
                                expect(answer.answer).to(beNil())
                            }
                        }
                    }
                }
            }
        }

    }
}
