//
//  TestCurrencyService.swift
//  army of onesTests
//
//  Created by Sergio Bernal Reyes on 11/20/19.
//  Copyright © 2019 Sergio Bernal Reyes. All rights reserved.
//

import Foundation

import XCTest

@testable import army_of_ones

class CurrencyServiceTest: XCTestCase {
    
    func testSuccessResponse(){
        let mockService = MockCurrencyRepository()
        mockService.getGBGCurrency { (result) in
            switch result{
            case .success(let data):
                XCTAssertNotNil(data, "Found nil response")
            default:
                XCTAssertNil(result, "Found not nil error")
            }
        }
    }
}
