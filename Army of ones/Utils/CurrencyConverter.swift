//
//  CurrencyConverter.swift
//  army of ones
//
//  Created by Sergio Bernal Reyes on 11/20/19.
//  Copyright © 2019 Sergio Bernal Reyes. All rights reserved.
//

import Foundation

class CurrencyConverter {
    static let instance = CurrencyConverter()
    
    func convert(amount: Double, rate: Double) -> Double {
        return amount * rate
    }
    
    private init(){}
}
