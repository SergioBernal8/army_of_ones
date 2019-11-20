//
//  CurrencyResponse.swift
//  army of ones
//
//  Created by Sergio Bernal Reyes on 11/19/19.
//  Copyright © 2019 Sergio Bernal Reyes. All rights reserved.
//

import Foundation

struct CurrencyResponse: Codable {
    
    let base: String
    let success: Bool
    let timestamp: Int
    let rates: [String:Double]
}
