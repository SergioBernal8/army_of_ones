//
//  FormatterTest.swift
//  army of onesTests
//
//  Created by Sergio Bernal Reyes on 11/20/19.
//  Copyright © 2019 Sergio Bernal Reyes. All rights reserved.
//

import Foundation

import XCTest

@testable import army_of_ones


class FormatterTest: XCTestCase {
    
    func testFormatter() {
        let amount = Formatter.instance.formatCurrency(amount: 1000)
        XCTAssertEqual(amount, "1.000", "Amount format failed")
    }
}
