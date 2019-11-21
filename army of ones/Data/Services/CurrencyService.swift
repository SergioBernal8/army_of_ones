//
//  CurrencyService.swift
//  army of ones
//
//  Created by Sergio Bernal Reyes on 11/19/19.
//  Copyright © 2019 Sergio Bernal Reyes. All rights reserved.
//

class CurrencyService: CurrencyRepository {
    
    func getGBGCurrency(completion: @escaping ServerResponse<CurrencyResponse>) {
        let headers = [
            "x-rapidapi-host": "fixer-fixer-currency-v1.p.rapidapi.com",
            "x-rapidapi-key": "f93be5bf6cmsh491a765fb7bb67dp1b891bjsncd371d93148e"
        ]
        
        let url = Constants.Endpoint.baseUrl + Constants.Endpoint.PATH_LATEST + "?base=USD&symbols=GBP,JPY,EUR,BRL" //GBP%252CJPY%252CEUR%252CBRL
        
        NetworkService.shared.performRequest(url: url, method: .get, parameters: nil, headers: headers, handler: completion)
    }
}
