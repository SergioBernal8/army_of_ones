//
//  CurrencyConverterTest.swift
//  army of onesTests
//
//  Created by Sergio Bernal Reyes on 11/20/19.
//  Copyright © 2019 Sergio Bernal Reyes. All rights reserved.
//

import Foundation

import XCTest

@testable import army_of_ones


class CurrencyConverterTest: XCTestCase {
    
    func testConverter(){
        let currencies = ["AAA": 0.5, "BBB": 0.9]
        let rate = currencies["AAA"]
        XCTAssertNotNil(currencies["AAA"], "Currency is nil")
        let convertedValue = CurrencyConverter.instance.convert(amount: 10, rate: rate!)
        XCTAssertEqual(convertedValue, 5, "Conversion did fail!")
        
        let rate2 = currencies["BBB"]
        XCTAssertNotNil(currencies["BBB"], "Currency is nil")
        let convertedValue2 = CurrencyConverter.instance.convert(amount: 10, rate: rate2!)
        XCTAssertEqual(convertedValue2, 9, "Conversion did fail!")
    }
}
