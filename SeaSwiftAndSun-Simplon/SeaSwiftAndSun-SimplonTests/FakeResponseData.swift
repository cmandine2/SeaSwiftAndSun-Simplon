//
//  FakeResponseData.swift
//  SeaSwiftAndSun-SimplonTests
//
//  Created by Keyhan Mortezaeifar on 13/12/2023.
//

import Foundation

class FakeResponseData {
    static let responseOK = HTTPURLResponse(url: URL(string: "https://api.airtable.com/v0/app0uFVsj3OmbD18z/Surf%20Destinations")!, statusCode: 200, httpVersion: nil, headerFields: nil)
    static let responseKO = HTTPURLResponse(url: URL(string: "https://api.airtable.com/v0/app0uFVsj3OmbD18z/Surf%20Destinations")!, statusCode: 500, httpVersion: nil, headerFields: nil)
    static let tokenOK = "pataYYzFkFa1ALxIA.2b34c14d6ac57424d9f8db291e18ceb40e0340547cf72f20ae81573070bd7a0a"
    static let tokenKO = ""
    
    class QuoteError: Error {}
    static let error = QuoteError()
    
    static let incorrectData = "error".data(using: .utf8)
    static var correctData: Data {
        let bundle = Bundle(for: FakeResponseData.self)
        let url = bundle.url(forResource: "DataTest", withExtension: "json")!
        let data = try! Data(contentsOf: url)
        return data
    }
}
