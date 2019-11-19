//
//  CurrencyService.swift
//  army of ones
//
//  Created by Sergio Bernal Reyes on 11/19/19.
//  Copyright © 2019 Sergio Bernal Reyes. All rights reserved.
//

class CurrencyService: CurrencyRepository {
    
    func getGBGCurrency(completion: @escaping ServerResponse<Currency>) {
        NetworkService.shared.performRequest(url: "", method: .get, parameters: nil, headers: nil, handler: completion)
    }
}
