//
//  ViewModelTest.swift
//  army of onesTests
//
//  Created by Sergio Bernal Reyes on 11/20/19.
//  Copyright © 2019 Sergio Bernal Reyes. All rights reserved.
//

import Foundation


import Foundation

import XCTest

@testable import army_of_ones

class ViewModelTest: XCTestCase {
    
    func testRequestCurrenciesNotEmpty() {
        let model = MainViewModel(repository: MockCurrencyRepository())
        model.getCurrencies()
        XCTAssertGreaterThan(model.rates.count, 0)
    }
    
    func testRequestCurrenciesError() {
        let service = MockCurrencyRepository()
        service.mockCase = .error
        let model = MainViewModel(repository: service)
        model.getCurrencies()
        XCTAssertTrue(model.rates.isEmpty, "Found currencies were there souldn't be")
    }
    
    func testConvertCurrenciesNotEmpty() {
        let model = MainViewModel(repository: MockCurrencyRepository())
        model.getCurrencies()
        XCTAssertGreaterThan(model.rates.count, 0)
        model.convertCurrency(for: 10)
        XCTAssertNotEqual(model.chartScale, 1.0, "Chart scale should't be 1.0")
    }
    
    func testConvertCurrenciesEmpty() {
        let service = MockCurrencyRepository()
        service.mockCase = .error
        let model = MainViewModel(repository: service)
        model.getCurrencies()
        XCTAssertTrue(model.rates.isEmpty, "Found currencies were there souldn't be")
        model.convertCurrency(for: 10)
    }
}
