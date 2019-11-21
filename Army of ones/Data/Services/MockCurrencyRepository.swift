//
//  MockCurrencyRepository.swift
//  army of ones
//
//  Created by Sergio Bernal Reyes on 11/20/19.
//  Copyright © 2019 Sergio Bernal Reyes. All rights reserved.
//

import Foundation

class MockCurrencyRepository: CurrencyRepository {
    var mockCase = CurrencyRepositoryMockCase.success
    
    func getGBGCurrency(completion: @escaping ServerResponse<CurrencyResponse>) {        
        completion(hanlder())
    }
    
    func hanlder() -> Result<CurrencyResponse,ErrorResponse> {
        if mockCase == .success {
            let data = CurrencyResponse(base: "USD", success: true, timestamp: 123, rates: ["GBP" : 1.3, "EUR":0.9, "JPY": 0.1, "BRL":0.6])
            return .success(data)
        } else {
            return.failure(ErrorResponse(errorType: .other, errorMessage: "error"))
        }
    }
}

enum CurrencyRepositoryMockCase {
    case success
    case error
}
