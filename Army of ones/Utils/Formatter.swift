//
//  Formatter.swift
//  army of ones
//
//  Created by Sergio Bernal Reyes on 11/20/19.
//  Copyright © 2019 Sergio Bernal Reyes. All rights reserved.
//

import Foundation

class Formatter {
    
    static let instance = Formatter()
    
    func formatCurrency(amount: Double) -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = NumberFormatter.Style.decimal
        numberFormatter.groupingSeparator = "."
        return numberFormatter.string(from: NSNumber(value:amount))!
    }
    
    private init(){}
}
