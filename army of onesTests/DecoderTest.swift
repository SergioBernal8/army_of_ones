//
//  DecoderTest.swift
//  army of onesTests
//
//  Created by Sergio Bernal Reyes on 11/20/19.
//  Copyright © 2019 Sergio Bernal Reyes. All rights reserved.
//

import XCTest

@testable import army_of_ones

class DecoderTest: XCTestCase {
    
    func testDecondingNotNil() {
        let response = CurrencyResponse(base: "USD", success: true, timestamp: 123, rates: ["" : 0.0])
        let data = MockEncoder().encode(data: response).data(using: .utf8)
        XCTAssertNotNil(data, "Found nil conver")
        let currencyResponse: CurrencyResponse? = JsonDecoder().decode(data: data!)
        XCTAssertNotNil(currencyResponse, "Found nil conversion")
    }
    
    func testDecondingNil() {
        let response = CurrencyResponse(base: "USD", success: true, timestamp: 123, rates: ["" : 0.0])
        let coder = MockEncoder()
        coder.mockCase = .error
        let data = coder.encode(data: response).data(using: .utf8)
        XCTAssertNotNil(data, "Found nil conver")
        let currencyResponse: CurrencyResponse? = JsonDecoder().decode(data: data!)
        XCTAssertNil(currencyResponse, "Not Found nil in response")
    }
}
